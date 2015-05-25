# Initializing the system

# Hamiltonian of the system
hamiltonian = sigmax
# Initial State
init_state = normalize!(QuArray([0.5+0.1im, 0.2+0.2im]))
# Time step
tlist = [0.:0.1:2*pi]

# Propagator using Euler method for solving the equation.
qu_euler = QuPropagator(hamiltonian, init_state, tlist, QuEuler())
start_state_euler = start(qu_euler)

# Propagator using Crank Nicolson method for solving the equation.
qu_cn = QuPropagator(hamiltonian, init_state, tlist, QuCrankNicolson())
start_state_cn = start(qu_cn)

# Propagator using Krylov method for solving the equation.
qu_krylov = QuPropagator(hamiltonian, init_state, tlist, QuKrylov())
start_state_krylov = start(qu_krylov)

next_state_euler = next(qu_euler, start_state_euler)
next_state_cn = next(qu_cn, start_state_cn)
next_state_krylov = next(qu_krylov, start_state_krylov)
next_state_actual = expm(-im*sigmax*0.1)*init_state

@test_approx_eq_eps coeffs(next_state_euler[1][2]) coeffs(next_state_actual) 1e-2
@test_approx_eq_eps coeffs(next_state_cn[1][2]) coeffs(next_state_actual) 1e-4
@test_approx_eq coeffs(next_state_krylov[1][2]) coeffs(next_state_actual)
