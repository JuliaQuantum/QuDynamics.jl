abstract QuPropagatorMethod

immutable QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(QuBase.AbstractQuVector,QuBase.AbstractQuMatrix), QE<:QuEquation}
    eq::QE
    init_state::QVM
    tlist
    method::QPM
    QuPropagator(eq, init_state, tlist, method) = new(eq, init_state, tlist, method)
end

QuPropagator{QPM<:QuPropagatorMethod, QV<:QuBase.AbstractQuVector}(eq::QuSchrodingerEq, init_state::QV, tlist, method::QPM) = QuPropagator{QPM,QV,QuSchrodingerEq}(eq, init_state, tlist, method)

QuPropagator{QPM<:QuPropagatorMethod, QV<:QuBase.AbstractQuVector}(hamiltonian::QuBase.AbstractQuMatrix, init_state::QV,  tlist, method::QPM) = QuPropagator{QPM,QV,QuSchrodingerEq}(QuSchrodingerEq(hamiltonian),init_state, tlist, method)

QuPropagator{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix}(eq::QuLiouvillevonNeumannEq, init_state::QM, tlist, method::QPM) = QuPropagator{QPM,QM,QuLiouvillevonNeumannEq}(eq, init_state, tlist, method)

QuPropagator{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix}(hamiltonian::QuBase.AbstractQuMatrix, init_state::QM,  tlist, method::QPM) = QuPropagator{QPM,QM,QuLiouvillevonNeumannEq}(QuLiouvillevonNeumannEq(liouvillian_op(hamiltonian)),init_state, tlist, method)

QuPropagator{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix}(eq::QuLindbladMasterEq, init_state::QM, tlist, method::QPM) = QuPropagator{QPM,QM,QuLindbladMasterEq}(eq, init_state, tlist, method)

QuPropagator{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix, COT<:QuBase.AbstractQuMatrix}(hamiltonian::QuBase.AbstractQuMatrix, collapse_ops::Vector{COT}, init_state::QM, tlist, method::QPM) = QuPropagator{QPM,QM,QuLindbladMasterEq}(QuLindbladMasterEq(hamiltonian,collapse_ops), init_state, tlist, method)

immutable QuPropagatorState
    psi
    t
    t_state
end

@doc """
Input Parameters : QuPropagator

Returns the starting iterator state of the propagator method, i.e., the initial state of the system
""" ->
function Base.start(prob::QuPropagator)
    init_state = prob.init_state
    t_state = start(prob.tlist)
    t,t_state = next(prob.tlist,t_state)
    return QuPropagatorState(init_state,t,t_state)
end

@doc """
Input Parameters : QuPropagator and QuPropagator State

Returns the next state by dispatching to particular
`propagate` method depending on the `numerical` method type.
""" ->
function Base.next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM}, qustate::QuPropagatorState)
    current_qustate = qustate.psi
    current_t = qustate.t
    t,t_state = next(prob.tlist, qustate.t_state)
    next_qustate = propagate(prob.method, prob.eq, t, current_t, current_qustate)
    return (t, next_qustate), QuPropagatorState(next_qustate, t, t_state)
end

@doc """
Input Parameters : QuPropagator and QuPropagator State

Returns true if the current state is final state, else false
""" ->
Base.done(prob::QuPropagator, qustate::QuPropagatorState) = done(prob.tlist, qustate.t_state)

export  QuPropagator,
      QuPropagatorState
