using QuDynamics.QuTiP
begin

# Defining the system - Hamiltonian, initial state, time steps
# Hamiltonian of the system
H = sigmax

# Initial state of the system
init_state = statevec(1, FiniteBasis(2))
init_state_dm = init_state*init_state'

# Time steps
tlist = 0.:0.1:2*pi

# Collapse operators
c_ops = [lowerop(2)]

# Operators whose expectation values are to computed
# in the evolved states
e_ops = [sqrt(2)*lowerop(2) + sqrt(3)*raiseop(2), raiseop(2), lowerop(2)]

# Test set involving Schrodinger like equations
se = QuSchrodingerEq(sigmax)

# Evaluating states using the general iterator version
evolved_states_se = Array(QuBase.AbstractQuArray, length(tlist)-1)
i = 1
for (t, psi) in QuStateEvolution(sigmax, init_state, tlist, QuExpmV())
    evolved_states_se[i] = psi
    i = i + 1
end

ind = rand(1:(length(tlist)-1))

# Evaluating using sesolve by passing Hamiltonian and initial state vector
schro_direct = sesolve(sigmax, init_state, tlist)

# Evaluating using sesolve by passing Schrodinger type equation
schro_eq = sesolve(se, init_state, tlist)

# Tests comparing the states from all the above constructs
@assert schro_direct[2][ind] == evolved_states_se[ind]
@assert schro_eq[2][ind] == evolved_states_se[ind]
@assert schro_direct[2][ind] == schro_eq[2][ind]

# Evaluating the expectation values
schro_direct_expect = sesolve(sigmax, init_state, tlist, e_ops)[2]
schro_eq_expect = sesolve(se, init_state, tlist, e_ops)[2]

ind_1 = rand(1:(length(e_ops)))
ind_2 = rand(1:length(tlist)-1)

@assert schro_direct_expect[ind_2, ind_1].im == schro_eq_expect[ind_2, ind_1].im

# Test set involving LiouvillevonNeumann like equations
lvne = QuLiouvillevonNeumannEq(sigmax)

# Evaluating states using the general iterator version
evolved_states_lvne = Array(QuBase.AbstractQuArray, length(tlist)-1)
i = 1
for (t, psi) in QuStateEvolution(sigmax, init_state_dm, tlist, QuExpmV())
    evolved_states_lvne[i] = psi
    i = i + 1
end

ind=rand(1:(length(tlist)-1))

# Evaluating using sesolve by passing Hamiltonian and initial density matrix
lvne_direct = sesolve(sigmax, init_state_dm, tlist)

# Evaluating using sesolve by passing LiouvillevonNeumann type equation
lvne_eq = sesolve(lvne, init_state_dm, tlist)

# Tests comparing the states from all the above constructs
@assert lvne_direct[2][ind] == evolved_states_lvne[ind]
@assert lvne_eq[2][ind] == evolved_states_lvne[ind]
@assert lvne_direct[2][ind] == lvne_eq[2][ind]

# Evaluating the expectation values
expectation_lvne = QuDynamics.QuTiP.eops_helper(e_ops, evolved_states_lvne)

# Evaluating using sesolve
lvne_direct_expect = sesolve(sigmax, init_state_dm, tlist, e_ops)[2]
lvne_eq_expect = sesolve(lvne, init_state_dm, tlist, e_ops)[2]

ind_1 = rand(1:(length(e_ops)))
ind_2 = rand(1:length(tlist)-1)

@assert lvne_direct_expect[ind_2, ind_1].im == expectation_lvne[ind_2, ind_1].im
@assert lvne_eq_expect[ind_2, ind_1].im  == expectation_lvne[ind_2, ind_1].im
@assert lvne_direct_expect[ind_2, ind_1].im == lvne_eq_expect[ind_2, ind_1].im

# Test set involving Lindblad Master equations
lme = QuLindbladMasterEq(sigmax, c_ops)

# Evaluating states using the general iterator version
evolved_states_lme = Array(QuBase.AbstractQuArray, length(tlist)-1)
i = 1
for (t, psi) in QuStateEvolution(lme, init_state_dm, tlist, QuExpmV())
    evolved_states_lme[i] = psi
    i = i + 1
end

ind=rand(1:(length(tlist)-1))

# Evaluating using mesolve by passing Hamiltonian and initial density matrix
lme_direct = mesolve(sigmax, init_state_dm, tlist, c_ops)

# Evaluating using mesolve by passing Lindblad Master equation
lme_eq = mesolve(lme, init_state_dm, tlist)

# Tests comparing the states from all the above constructs
@assert lme_direct[2][ind] == evolved_states_lme[ind]
@assert lme_eq[2][ind] == evolved_states_lme[ind]
@assert lme_direct[2][ind] == lme_eq[2][ind]

# Evaluating the expectation values
expectation_lme = QuDynamics.QuTiP.eops_helper(e_ops, evolved_states_lme)

# Evaluating using mesolve
lme_direct_expect = mesolve(sigmax, init_state_dm, tlist, c_ops, e_ops)[2]
lme_eq_expect = mesolve(lme, init_state_dm, tlist, e_ops)[2]

ind_1 = rand(1:(length(e_ops)))
ind_2 = rand(1:length(tlist)-1)

@assert lme_direct_expect[ind_2, ind_1].im == expectation_lme[ind_2, ind_1].im
@assert lme_eq_expect[ind_2, ind_1].im == expectation_lme[ind_2, ind_1].im
@assert lme_direct_expect[ind_2, ind_1].im == lme_eq_expect[ind_2, ind_1].im

# Testing the expectation using various mcsolve constructs
mcs = mcsolve(H, init_state, tlist, c_ops)
mcs_lme = mcsolve(lme, init_state, tlist)
mcs_lme_expect = mcsolve(lme, init_state_dm, tlist, e_ops)
mcs_expect = mcsolve(H, init_state, tlist, c_ops,  e_ops)

@test_approx_eq_eps mcs[2][ind_2] mcs_lme[2][ind_2] 1e-1
@test_approx_eq_eps trace(mcs[2][ind_2]*e_ops[ind_1]) mcs_expect[2][ind_2, ind_1] 1e-1
@test_approx_eq_eps trace(mcs[2][ind_2]*e_ops[ind_1]) mcs_lme_expect[2][ind_2, ind_1] 1e-1
@test_approx_eq_eps mcs_expect[2][ind_2, ind_1] mcs_lme_expect[2][ind_2, ind_1] 1e-1
end
