# Initializing the system

# Hamiltonian of the system
hamiltonian = sigmax
# Initial State
init_state = normalize!(QuArray([0.5+0.1im, 0.2+0.2im]))
# Time step
tlist = 0.:0.1:2*pi

# Propagator using different solvers for solving the equation.

const solver = @compat Dict{Any, Any}(:qu_euler => QuEuler, :qu_cn => QuCrankNicolson, :qu_krylov => QuKrylov,
                                      :qu_ode45 => QuODE45, :qu_ode78 => QuODE78, :qu_ode23s => QuODE23s)

for (key,value) in solver
    @eval begin
        $key = QuPropagator(hamiltonian, init_state, tlist, $value())
    end
end

const next_state = @compat Dict{Any, Any}(:next_state_euler => qu_euler, :next_state_cn => qu_cn, :next_state_krylov => qu_krylov,
                                          :next_state_ode45 => qu_ode45, :next_state_ode78 => qu_ode78, :next_state_ode23s => qu_ode23s)

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
