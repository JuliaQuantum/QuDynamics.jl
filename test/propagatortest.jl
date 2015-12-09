# Initializing the system

# Hamiltonian of the system
hamiltonian = sigmax
# Initial State
init_state = normalize!(QuArray([0.5+0.1im, 0.2+0.2im]))
# Time step
tlist = 0.:0.1:2*pi
# Initial State density matrix
init_state_dm = init_state*init_state'

const solver = @compat Dict{Any, Any}(:qu_euler => QuEuler, :qu_cn => QuCrankNicolson, :qu_krylov => QuKrylov,
                                      :qu_ode45 => QuODE45, :qu_ode78 => QuODE78, :qu_ode23s => QuODE23s,
                                      :quexpm_expo => QuExpokit, :quexpm_expmv => QuExpmV)

for (key,value) in solver
    @eval begin
        $key = QuStateEvolution(hamiltonian, init_state, tlist, $value())
    end
end

const next_state = @compat Dict{Any, Any}(:next_state_euler => qu_euler, :next_state_cn => qu_cn, :next_state_krylov => qu_krylov,
                                          :next_state_ode45 => qu_ode45, :next_state_ode78 => qu_ode78, :next_state_ode23s => qu_ode23s,
                                          :next_state_quexpm_expo => quexpm_expo, :next_state_quexpm_expmv => quexpm_expmv)

for (key,value) in next_state
    @eval begin
        $key = next($value, start($value))
    end
end
next_state_actual = expm(-im*sigmax*0.1)*init_state

@test_approx_eq_eps coeffs(next_state_euler[1][2]) coeffs(next_state_actual) 1e-2
@test_approx_eq_eps coeffs(next_state_cn[1][2]) coeffs(next_state_actual) 1e-4
@test_approx_eq coeffs(next_state_krylov[1][2]) coeffs(next_state_actual)
@test_approx_eq coeffs(next_state_ode45[1][2]) coeffs(next_state_actual)
@test_approx_eq coeffs(next_state_ode78[1][2]) coeffs(next_state_actual)
@test_approx_eq_eps coeffs(next_state_ode23s[1][2]) coeffs(next_state_actual) 1.0e-5
@test_approx_eq coeffs(next_state_quexpm_expo[1][2]) coeffs(next_state_actual)
@test_approx_eq coeffs(next_state_quexpm_expmv[1][2]) coeffs(next_state_actual)

# Tests for the different constructs for Liouville von Neumann Equation

lvn = QuLiouvillevonNeumannEq(QuDynamics.liouvillian_op(sigmax))

qexpokit_lvn = QuStateEvolution(lvn, init_state*init_state', tlist, QuExpokit())
qexpokit_dm = QuStateEvolution(sigmax, init_state*init_state', tlist, QuExpokit())
next_state_qexpokit_lvn = next(qexpokit_lvn, start(qexpokit_lvn))
next_state_qexpokit_dm = next(qexpokit_dm, start(qexpokit_dm))
@assert next_state_qexpokit_lvn[1][2] == next_state_qexpokit_dm[1][2]
qode45_lvn = QuStateEvolution(lvn, init_state*init_state', tlist, QuODE45())
qode45_dm = QuStateEvolution(sigmax, init_state*init_state', tlist, QuODE45())
next_state_qode45_lvn = next(qode45_lvn, start(qode45_lvn))
next_state_qode45_dm = next(qode45_dm, start(qode45_dm))
@assert next_state_qode45_lvn[1][2] == next_state_qode45_dm[1][2]
qeuler_lvn = QuStateEvolution(lvn, init_state*init_state', tlist, QuEuler())
qeuler_dm = QuStateEvolution(sigmax, init_state*init_state', tlist, QuEuler())
next_state_qeuler_lvn = next(qeuler_lvn, start(qeuler_lvn))
next_state_qeuler_dm = next(qeuler_dm, start(qeuler_dm))
@assert next_state_qeuler_lvn[1][2] == next_state_qeuler_dm[1][2]

# Tests comparing results for Liouville von Neumann Equation

next_state_actual = expm(-im*QuDynamics.liouvillian_op(sigmax)*0.1)*vec(init_state_dm)
@test_approx_eq coeffs(vec(next_state_qexpokit_lvn[1][2])) coeffs(next_state_actual)
@test_approx_eq_eps coeffs(vec(next_state_qode45_dm[1][2])) coeffs(next_state_actual) 1e-10
@test_approx_eq_eps coeffs(vec(next_state_qeuler_lvn[1][2])) coeffs(next_state_actual) 1e-2

# Tests for the different constructs for Lindblad Master Equation

c_ops = [lowerop(2)]
lmeq = QuLindbladMasterEq(sigmax, c_ops)

qexpokit_lmeq = QuStateEvolution(lmeq, init_state*init_state', tlist, QuExpokit())
qexpokit_dm = QuStateEvolution(sigmax, c_ops, init_state*init_state', tlist, QuExpokit())
next_state_qexpokit_lmeq = next(qexpokit_lmeq, start(qexpokit_lmeq))
next_state_qexpokit_dm = next(qexpokit_dm, start(qexpokit_dm))
@assert next_state_qexpokit_lmeq[1][2] == next_state_qexpokit_dm[1][2]
qode78_lmeq = QuStateEvolution(lmeq, init_state*init_state', tlist, QuODE78())
qode78_dm = QuStateEvolution(sigmax, c_ops, init_state*init_state', tlist, QuODE78())
next_state_qode78_lmeq = next(qode78_lmeq, start(qode78_lmeq))
next_state_qode78_dm = next(qode78_dm, start(qode78_dm))
@assert next_state_qode78_lmeq[1][2] == next_state_qode78_dm[1][2]
qcn_lmeq = QuStateEvolution(lmeq, init_state*init_state', tlist, QuCrankNicolson())
qcn_dm = QuStateEvolution(sigmax, c_ops, init_state*init_state', tlist, QuCrankNicolson())
next_state_qcn_lmeq = next(qcn_lmeq, start(qcn_lmeq))
next_state_qcn_dm = next(qcn_dm, start(qcn_dm))
@assert next_state_qcn_lmeq[1][2] == next_state_qcn_dm[1][2]

# Tests comparing results for Lindblad Master Equation

next_state_actual = expm(-im*QuDynamics.lindblad_op(sigmax, [lowerop(2)])*0.1)*vec(init_state_dm)
@test_approx_eq coeffs(vec(next_state_qexpokit_lmeq[1][2])) coeffs(next_state_actual)
@test_approx_eq coeffs(vec(next_state_qexpokit_dm[1][2])) coeffs(next_state_actual)
@test_approx_eq coeffs(vec(next_state_qexpokit_lmeq[1][2])) coeffs(next_state_actual)

# TODO : QuBase.jl complex WIP. Issue 38. https://github.com/JuliaQuantum/QuBase.jl/pull/38
Base.complex{B<:QuBase.OrthonormalBasis}(qarr::QuBase.AbstractQuArray{B}) = QuBase.similar_type(qarr)(complex(coeffs(qarr)), bases(qarr))

# Monte Carlo Wave Function Method

rho = init_state_dm
rhos = Array(typeof(rho), length(tlist)-1)
ps = Array(typeof(rho), length(tlist)-1)
qumcwfen = QuMCWFEnsemble(complex(init_state), 1000)

for i=1:length(tlist)-1
    rhos[i] = complex(zeros(rho))
    ps[i] = complex(zeros(rho))
end

for psi0 in qumcwfen
    i = 1
    mcwf = QuMCWF()
    for (t,psi) in QuStateEvolution(hamiltonian, c_ops, psi0, tlist, mcwf)
        rhos[i] = rhos[i] + (psi*psi')/length(qumcwfen)/norm(psi)^2
        i = i + 1
    end
end

prop_expm = QuStateEvolution(hamiltonian, c_ops, rho, tlist, QuExpmV())
j = 1
for (t, rhot) in prop_expm
    ps[j] = rhot
    j = j + 1
end

ind=rand(1:(length(tlist)-1))
@test_approx_eq_eps coeffs(vec(rhos[ind])) coeffs(vec(ps[ind])) 1e-1

# tests for  evolution opeator.
evolved_state = coeffs(propagate(QuExpokit(), QuSchrodingerEq(hamiltonian), tlist[2], tlist[1], init_state))
@test_approx_eq coeffs(QuEvolutionOp(sigmax, 0.1)*init_state) evolved_state
@test_approx_eq coeffs(QuEvolutionOp(sigmax, tlist[5], tlist[4])*init_state) evolved_state
@test_approx_eq coeffs(QuEvolutionOp(QuSchrodingerEq(sigmax), tlist[5], tlist[4])*init_state) evolved_state

# caching and uncached version testing
@assert QuLindbladMasterEqUncached(sigmax, [sigmax]).lindblad == nothing
@assert QuLindbladMasterEq(sigmax, [sigmax]).lindblad == QuDynamics.operator(QuLindbladMasterEqUncached(sigmax,  [sigmax]))
