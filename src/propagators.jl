import Base: start, next, done

abstract QuPropagatorMethod

immutable QuPropagator{QPM<:QuPropagatorMethod}
    hamiltonian
    init_state::QuVector
    tlist
    method::QPM
    QuPropagator(hamiltonian, init_state, tlist, method) = new(hamiltonian, init_state, tlist, method)
end

QuPropagator{QPM<:QuPropagatorMethod}(hamiltonian, init_state, tlist, method::QPM) = QuPropagator{QPM}(hamiltonian, init_state, tlist, method)

immutable QuPropagatorState
    psi::QuVector
    t
    t_state
end

@doc """
Input Parameters : QuPropagator

Returns the starting iterator state of the propagator method, i.e., the initial state of the system
""" ->
function Base.start(prob::QuPropagator)
    t_state = start(prob.tlist)
    t,t_state = next(prob.tlist,t_state)
    return QuPropagatorState(prob.init_state,t,t_state)
end

@doc """
Input Parameters : QuPropagator and QuPropagator State

Returns the next state by dispatching to particular
`propagate` method depending on the `numerical` method type.
""" ->
function Base.next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM}, qustate::QuPropagatorState)
    op = prob.hamiltonian
    current_qustate = qustate.psi
    current_t = qustate.t
    t,t_state = next(prob.tlist, qustate.t_state)
    next_qustate = propagate(prob.method, op, t, current_t, current_qustate)
    return (t, next_qustate), QuPropagatorState(next_qustate, t, t_state)
end

@doc """
Input Parameters : QuPropagator and QuPropagator State

Returns true if the current state is final state, else false
""" ->
Base.done(prob::QuPropagator, qustate::QuPropagatorState) = done(prob.tlist, qustate.t_state)

@doc """
Euler Method

Step Propagation using the Euler formula.
""" ->
immutable QuEuler <: QuPropagatorMethod
end

@doc """
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.
""" ->
immutable QuCrankNicolson <: QuPropagatorMethod
end

@doc """
Krylov subspace Method
Input Parameters :
`options` : Dictionary to set the basis size with keyword NC.

For ex :
x = [:NC => basis_size]
QuKrylov(x)
Step Propagation using the Krylov subspace iterations.
""" ->
immutable QuKrylov <: QuPropagatorMethod
    options::Dict
end

QuKrylov() = QuKrylov(Dict([:NC=>10]))

@doc """
Propagates to the next time state
Input Parameters:
`prob`             :  Method to be used
`op`               :  Hamiltonian of the system
`t`                :  Time corresponding to the t_state
`current_t`        :  Current time
`current_qustate`  :  Quantum state corresponding to current time
""" ->
function propagate(prob::QuEuler, op, t, current_t, current_qustate)
    dt = t - current_t
    return (eye(op)-im*op*dt)*current_qustate
end

function propagate(prob::QuCrankNicolson, op, t, current_t, current_qustate)
    dt = t - current_t
    uni = eye(op)-im*op*dt/2
    return \(uni', uni*current_qustate)
end

function propagate(prob::QuKrylov, op, t, current_t, current_qustate)
    dt = t - current_t
    basis_size = get(prob.options,:NC, length(current_qustate))
    N = min(basis_size, length(current_qustate))
    v = Array(typeof(current_qustate),0)
    sizehint(v, N+1)
    push!(v,zeros(current_qustate))
    push!(v,current_qustate)
    alpha = Array(Complex{Float64},0)
    sizehint(alpha, N)
    beta = Array(Complex{Float64},0)
    sizehint(beta, N+1)
    push!(beta,0.)
    for i=2:N
        w = op*v[i]
        push!(alpha, w'*v[i])
        w = w-alpha[i-1]*v[i]-beta[i-1]*v[i-1]
        push!(beta, norm(w))
        push!(v, w/beta[i])
    end
    w = op*v[end]
    push!(alpha, w'*v[end])
    deleteat!(v,1)
    H_k = full(Tridiagonal(beta[2:end], alpha, beta[2:end]))
    U_k = expm(-im*dt*H_k)
    next_state = zeros(current_qustate)
    for j=1:N
        next_state = next_state + v[j]*U_k[j,1]
    end
    return next_state
end

export  QuPropagator,
      QuPropagatorState,
      QuEuler,
      QuCrankNicolson,
      QuKrylov
