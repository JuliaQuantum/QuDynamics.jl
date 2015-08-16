using QuBase
using QuDynamics

# Quantum Harmonic Oscillator using solvers from QuDynamics

# Constructor for constructing the Hamiltonian, Initial state.
function initialize(n::Int, λ)
    a = lowerop(n)
    hamiltonian = a'*a + λ*(a + a')
    init_state = statevec(1,FiniteBasis(n))
    return hamiltonian, init_state
end

# Initializing the system by selecting the size of the basis and parameter lambda
init = initialize(4, 0.5)

# Time step array
t = 0.:0.1:2*π

# Construct the QuPropagator `P`, by passing the Hamiltonian `H`, initial state `psi`, time step array `t` and Method type
# `Method type` can be QuEuler, QuCrankNicolson, QuKrylov, QuODE45, QuODE78, QuODE23s
Η = init[1]
ψ = init[2]
Ρ = QuPropagator(Η, ψ , t, QuKrylov())

# Evolve the ground state, the next state at the next time step 0.1
η = next(Ρ, start(Ρ))
println(η)

# Alternatively using the iterator methods calculate the evolved states at every point in time step array
for (t, β) in Ρ
    println("$t $β")
end
