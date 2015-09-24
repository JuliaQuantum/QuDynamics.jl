abstract QuPropagatorMethod

@doc """
QuPropagator and QuStateEvolution types are the same.

The central piece which dispatches to various solvers. The various outer constructions, allow to
give in various inputs. For example if the Hamiltonian is `QuBase.AbstractQuMatrix` and the  initial state
is `QuBase.AbstractQuVector`, we construct a `QuSchrodingerEq` with these parameters and then construct
`QuPropagator`.

### Fields :

Inputs :
* eq <: QuEquation

  Type of the equation to be solved, for example : `QuSchrodingerEq`, `QuLindbladMasterEq`
* init_state <: Union(QuBase.AbstractQuVector, QuBase.AbstractQuMatrix)

  Initial state of the system.
* tlist

  Time step array/range
* method <: QuPropagatorMethod

  Method to be used to solve the equation.

Output :
* QuPropagator construct depending on the input.
""" ->
immutable QuStateEvolution{QPM<:QuPropagatorMethod, QVM<:@compat(Union{QuBase.AbstractQuVector,QuBase.AbstractQuMatrix}), QE<:QuEquation}
    eq::QE
    init_state::QVM
    tlist
    method::QPM
    QuStateEvolution(eq, init_state, tlist, method) = new(eq, init_state, tlist, method)
end

QuStateEvolution{QPM<:QuPropagatorMethod, QV<:QuBase.AbstractQuVector}(eq::QuSchrodingerEq, init_state::QV, tlist, method::QPM) = QuStateEvolution{QPM,QV,QuSchrodingerEq}(eq, init_state, tlist, method)

QuStateEvolution{QPM<:QuPropagatorMethod, QV<:QuBase.AbstractQuVector}(hamiltonian::QuBase.AbstractQuMatrix, init_state::QV,  tlist, method::QPM) = QuStateEvolution{QPM,QV,QuSchrodingerEq}(QuSchrodingerEq(hamiltonian),init_state, tlist, method)

QuStateEvolution{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix}(eq::QuLiouvillevonNeumannEq, init_state::QM, tlist, method::QPM) = QuStateEvolution{QPM,QM,QuLiouvillevonNeumannEq}(eq, init_state, tlist, method)

QuStateEvolution{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix}(hamiltonian::QuBase.AbstractQuMatrix, init_state::QM,  tlist, method::QPM) = QuStateEvolution{QPM,QM,QuLiouvillevonNeumannEq}(QuLiouvillevonNeumannEq(liouvillian_op(hamiltonian)),init_state, tlist, method)

QuStateEvolution{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix}(eq::QuLindbladMasterEq, init_state::QM, tlist, method::QPM) = QuStateEvolution{QPM,QM,QuLindbladMasterEq}(eq, init_state, tlist, method)

QuStateEvolution{QPM<:QuPropagatorMethod, QM<:QuBase.AbstractQuMatrix, COT<:QuBase.AbstractQuMatrix}(hamiltonian::QuBase.AbstractQuMatrix, collapse_ops::Vector{COT}, init_state::QM, tlist, method::QPM) = QuStateEvolution{QPM,QM,QuLindbladMasterEq}(QuLindbladMasterEq(hamiltonian,collapse_ops), init_state, tlist, method)

QuStateEvolution{QPM<:QuPropagatorMethod, QV<:QuBase.AbstractQuVector, COT<:QuBase.AbstractQuMatrix}(hamiltonian::QuBase.AbstractQuMatrix, collapse_ops::Vector{COT}, init_state::QV, tlist, method::QPM) = QuStateEvolution{QPM,QV,QuLindbladMasterEq}(QuLindbladMasterEq(hamiltonian,collapse_ops), init_state, tlist, method)

# QuPropagator and QuStateEvolution types are the same.
typealias QuPropagator QuStateEvolution

@doc """
QuPropagator State

Iterator version for QuPropagator used to propagate for a single time-step.

### Fields :

Inputs :
* psi

  Current state to be evolved
* t

  Current time
* t_state

  Index of next time from time step array

Output :
* QuPropagatorState construct.
""" ->
immutable QuPropagatorState
    state
    t
    t_state
end

@doc """
Iterator for QuPropagator

Iterator `start` method for QuPropagator

### Arguments

Inputs :
* prob :: QuPropagator

  The  `QuPropagator` is used to get the initial state of the system.

Output :
* QuPropagatorState construct with parameters as initial state, start time and time state.
""" ->
function Base.start(prob::QuStateEvolution)
    init_state = prob.init_state
    t_state = start(prob.tlist)
    t,t_state = next(prob.tlist,t_state)
    return QuPropagatorState(init_state,t,t_state)
end

@doc """
Iterator for QuPropagator

Iterator `next` method for QuPropagator

### Arguments

Inputs :
* prob :: QuPropagator{QuPropagatorMethod}

  The  `QuPropagator` contruct which involves the parameters of the system.
* qustate :: QuPropagatorState

  Current QuPropagatorState

Output :
* Next state, Time corresponding to the current time and related QuPropagatorState
""" ->
function Base.next{QPM<:QuPropagatorMethod}(prob::QuStateEvolution{QPM}, qustate::QuPropagatorState)
    current_qustate = qustate.state
    current_t = qustate.t
    t,t_state = next(prob.tlist, qustate.t_state)
    next_qustate = propagate(prob.method, prob.eq, t, current_t, current_qustate)
    return (t, next_qustate), QuPropagatorState(next_qustate, t, t_state)
end

@doc """
Iterator for QuPropagator

Iterator `done` method for QuPropagator

### Arguments

Inputs :
* prob :: QuPropagator

* qustate :: QuPropagatorState

Output :
* True if the current state is final state, else false.
""" ->
Base.done(prob::QuStateEvolution, qustate::QuPropagatorState) = done(prob.tlist, qustate.t_state)

@doc """
Propagation of the time evolution operator.

### Arguments

Inputs :
* op <: QuBase.AbstractQuMatrix

  Operator to be evolved.
* dt :: Float64

  Time step.

* tf, ti :: Float64

  Final Time, Initial Time.

Output :
* Evolved operator.
""" ->
QuEvolutionOp{QM<:QuBase.AbstractQuMatrix}(op::QM, dt::Float64) = expm(-im*op*dt)

QuEvolutionOp{QM<:QuBase.AbstractQuMatrix}(op::QM, tf::Float64,  ti::Float64) = QuEvolutionOp(op, tf-ti)

QuEvolutionOp{QE<:QuEquation}(eq::QE, dt::Float64) = QuEvolutionOp(operator(eq), dt)

QuEvolutionOp{QE<:QuEquation}(eq::QE, tf::Float64, ti::Float64) = QuEvolutionOp(eq, tf-ti)

export  QuStateEvolution,
      QuPropagator,
      QuEvolutionOp,
      QuPropagatorState
