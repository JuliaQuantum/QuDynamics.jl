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

export  QuPropagator,
      QuPropagatorState
