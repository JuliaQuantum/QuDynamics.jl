# QuDynamics

## Exported

---

<a id="method__qulindbladmastereq.1" class="lexicon_definition"></a>
#### QuLindbladMasterEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, 1}) [¶](#method__qulindbladmastereq.1)
Lindblad Master Equation method

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops :: Vector{QuBase.AbstractQuMatrix}

  Collapse operators

Output :
* QuLindbladMasterEq type construct.


*source:*
[QuDynamics.jl/src/quequations.jl:98](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L98)

---

<a id="method__quliouvillevonneumanneq.1" class="lexicon_definition"></a>
#### QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(liouvillian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__quliouvillevonneumanneq.1)
Liouville von Neumann Equation method

### Arguments

Inputs :
* Liouvillian <: QuBase.AbstractQuMatrix

  Liouvillian of the system

Output :
* QuLiouvillevonNeumannEq type construct.


*source:*
[QuDynamics.jl/src/quequations.jl:58](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L58)

---

<a id="method__quschrodingereq.1" class="lexicon_definition"></a>
#### QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__quschrodingereq.1)
Schrodinger Equation method

### Arguments

Inputs :
* hamiltonian <:  QuBase.AbstractQuMatrix

  Hamiltonian of the system

Output :
* QuSchrodingerEq type construct.


*source:*
[QuDynamics.jl/src/quequations.jl:29](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L29)

---

<a id="method__propagate.1" class="lexicon_definition"></a>
#### propagate(prob::QuEuler, eq::QuEquation, t, current_t, current_qustate) [¶](#method__propagate.1)
Propagate for different solver types.

Method used to propagate one time step using the solver.

### Arguments

Inputs :
* prob <: QuPropagatorMethod

  Solver type (Method to be used  -> QuEuler, QuCrankNicolson,
                       QuKrylov, QuODE45, QuODE78, QuODE23s,
                       QuExpmV, QuExpokit, QuMCWF)
* eq <: QuEquation

  Equation type
* t :: Float64

  Final time
* current_t :: Float64

  Current time
* current_qustate

  Quantum state corresponding to current time

Output :
* Same type as current_qustate.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:62](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propstepsolvers.jl#L62)

---

<a id="type__qucranknicolson.1" class="lexicon_definition"></a>
#### QuCrankNicolson [¶](#type__qucranknicolson.1)
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:13](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propstepsolvers.jl#L13)


<a id="type__queuler.1" class="lexicon_definition"></a>
#### QuEuler [¶](#type__queuler.1)
Euler method

Step Propagation using the Euler formula.
$ket{psi(t_{k+1})} = (mathbb{I}-iHartriangle{t})ket{psi(t_{k})}$


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:5](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propstepsolvers.jl#L5)

---

<a id="type__quexpmv.1" class="lexicon_definition"></a>
#### QuExpmV [¶](#type__quexpmv.1)
Exponential solver, using ExpmV.expmv

Step Propagation using the exponential solver ExpmV.expmv.

### Fields :

* options :: Dict

Dictionary to set M, precision, shift, full_term by using
keys as `:M`, `:precision`, `:shift`, `:full_term`


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:32](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propexpmsolvers.jl#L32)

---

<a id="type__quexpokit.1" class="lexicon_definition"></a>
#### QuExpokit [¶](#type__quexpokit.1)
Exponential solver, using Expokit.expmv

Step Propagation using the exponential solver Expokit.expmv.

### Fields :

* options :: Dict

Dictionary to set the size of Krylov subspace and tolerance by using
keys as `:m` and `:tol`.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:14](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propexpmsolvers.jl#L14)


<a id="type__qukrylov.1" class="lexicon_definition"></a>
#### QuKrylov [¶](#type__qukrylov.1)
Krylov subspace Method

Step Propagation using the Krylov subspace method.

### Fields :

* options :: Dict

  Dictionary to set the size of basis by using the key `:NC`.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:27](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propstepsolvers.jl#L27)

---

<a id="type__qulindbladmastereq.1" class="lexicon_definition"></a>
#### QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__qulindbladmastereq.1)
Lindblad Master Equation type

### Fields :

* lindblad <: QuBase.AbstractQuMatrix

  Lindblad operator of the system
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops <: Vector{QuBase.AbstractQuMatrix}

  Collapse operators


*source:*
[QuDynamics.jl/src/quequations.jl:75](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L75)

---

<a id="type__quliouvillevonneumanneq.1" class="lexicon_definition"></a>
#### QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__quliouvillevonneumanneq.1)
Liouville von Neumann Equation type

### Fields :

* liouvillian <: QuBase.AbstractQuMatrix

  Liouvillian of the system is the only field for the type.


*source:*
[QuDynamics.jl/src/quequations.jl:40](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L40)

---

<a id="type__qumcwf.1" class="lexicon_definition"></a>
#### QuMCWF [¶](#type__qumcwf.1)
Quantum Monte-Carlo Wave Function Method

Step Propagation using the exponential solver Expokit.expmv.

### Fields :

* eps  :: Float64

  Random number used to realize (quantum) jumps.

* options :: Dict

  Dictionary to set the solver used to proagate the state generated using `draw`.


*source:*
[QuDynamics.jl/src/propmcwf.jl:17](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L17)

---

<a id="type__qumcwfensemble.1" class="lexicon_definition"></a>
#### QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}} [¶](#type__qumcwfensemble.1)
Ensemble of state, number of trajectories, decomposition based on the state.

### Fields :

* rho <: QuBase.AbstractQuArray

  State of the system
* ntraj :: Int

  Number of trajectories
* decomp

  Decomposition is of state `rho` if `rho` is a `QuBase.AbstractQuMatrix`.


*source:*
[QuDynamics.jl/src/propmcwf.jl:39](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L39)


<a id="type__quode23s.1" class="lexicon_definition"></a>
#### QuODE23s [¶](#type__quode23s.1)
ODE solver, using QuODE23s

Step Propagation using the ode solver ode23s.

### Fields :

* options :: Dict

Dictionary to set the relative tolerance and absolute tolerance by using
keys as `:reltol` and `:abstol`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:19](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propodesolvers.jl#L19)

---

<a id="type__quode45.1" class="lexicon_definition"></a>
#### QuODE45 [¶](#type__quode45.1)
ODE solver, using QuODE45

Step Propagation using the ode solver ode45_dp.

### Fields :

* options :: Dict

Dictionary to set the relative tolerance and absolute tolerance by using
keys as `:reltol` and `:abstol`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:19](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propodesolvers.jl#L19)

---

<a id="type__quode78.1" class="lexicon_definition"></a>
#### QuODE78 [¶](#type__quode78.1)
ODE solver, using QuODE78

Step Propagation using the ode solver ode78.

### Fields :

* options :: Dict

Dictionary to set the relative tolerance and absolute tolerance by using
keys as `:reltol` and `:abstol`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:19](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propodesolvers.jl#L19)

---

<a id="type__qupropagatorstate.1" class="lexicon_definition"></a>
#### QuPropagatorState [¶](#type__qupropagatorstate.1)
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


*source:*
[QuDynamics.jl/src/propmachinery.jl:72](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmachinery.jl#L72)

---

<a id="type__qupropagator.1" class="lexicon_definition"></a>
#### QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation} [¶](#type__qupropagator.1)
QuPropagator Type

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


*source:*
[QuDynamics.jl/src/propmachinery.jl:29](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmachinery.jl#L29)

---

<a id="type__quschrodingereq.1" class="lexicon_definition"></a>
#### QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__quschrodingereq.1)
Schrodinger Equation type

### Fields :

* hamiltonian <:QuBase.AbstractQuMatrix

  Hamiltonian of the system is the only field for the type.


*source:*
[QuDynamics.jl/src/quequations.jl:11](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L11)

## Internal


<a id="method__done.1" class="lexicon_definition"></a>
#### done(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}, i::Int64) [¶](#method__done.1)
Iterator for QuMCWFEnsemble

Iterator `done` method of the Ensemble

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble

* state ::  Int

Output :
* Compares the iterator state with the number of trajectories and
  returns true or false depending on the comparison.


*source:*
[QuDynamics.jl/src/propmcwf.jl:102](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L102)

---

<a id="method__done.2" class="lexicon_definition"></a>
#### done(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__done.2)
Iterator for QuPropagator

Iterator `next` method for QuPropagator

### Arguments

Inputs :
* prob :: QuPropagator

* qustate :: QuPropagatorState

Output :
* True if the current state is final state, else false.


*source:*
[QuDynamics.jl/src/propmachinery.jl:142](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmachinery.jl#L142)

---

<a id="method__draw.1" class="lexicon_definition"></a>
#### draw{QM<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(mcwfensemble::QuMCWFEnsemble{QM<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__draw.1)
Method to draw a vector from the decomposition, using random number for selection.

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble{QuBase.AbstractQuMatrix}

  Ensemble on which decomposition is performed

Output :
* QuArray with eigen vector from decomposition passed as an argument.


*source:*
[QuDynamics.jl/src/propmcwf.jl:119](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L119)

---

<a id="method__draw.2" class="lexicon_definition"></a>
#### draw{QV<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}}(mcwfensemble::QuMCWFEnsemble{QV<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}}) [¶](#method__draw.2)
Method to draw a vector, which returns a copy of the vector instead of decomposing.

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble{QuBase.AbstractQuVector}

  Ensemble which is constructed using a QuVector

Output :
* Copy of the QuVector.


*source:*
[QuDynamics.jl/src/propmcwf.jl:143](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L143)

---

<a id="method__eff_hamiltonian.1" class="lexicon_definition"></a>
#### eff_hamiltonian(lme::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__eff_hamiltonian.1)
Effective hamiltonian calculated using the hamiltonian and collapse operators.

### Arguments

Inputs :
* lme :: QuLindbladMasterEq

Output
* Effective hamiltonian of the system


*source:*
[QuDynamics.jl/src/quequations.jl:234](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L234)

---

<a id="method__lindblad_op.1" class="lexicon_definition"></a>
#### lindblad_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{T, 1}) [¶](#method__lindblad_op.1)
Lindblad operator construct from the `Hamiltonian` and `collapse operators`

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops :: Vector

  Collapse operators

Output :
* Lindblad operator.


*source:*
[QuDynamics.jl/src/quequations.jl:119](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L119)

---

<a id="method__liouvillian_op.1" class="lexicon_definition"></a>
#### liouvillian_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__liouvillian_op.1)
Liouvillian operator construct from the `Hamiltonian` and passing an empty array to `lindblad_op`

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system

Output :
* Liouvillian operator.


*source:*
[QuDynamics.jl/src/quequations.jl:170](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L170)


<a id="method__next.1" class="lexicon_definition"></a>
#### next(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}, i::Int64) [¶](#method__next.1)
Iterator for QuMCWFEnsemble

Iterator `next` method of the Ensemble

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble

* state :: Int

Output :
* State using `draw` and next state.


*source:*
[QuDynamics.jl/src/propmcwf.jl:81](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L81)


<a id="method__next.2" class="lexicon_definition"></a>
#### next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__next.2)
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


*source:*
[QuDynamics.jl/src/propmachinery.jl:119](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmachinery.jl#L119)

---

<a id="method__operator.1" class="lexicon_definition"></a>
#### operator(qu_eq::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.1)
Lindblad operator of the QuLindbladMasterEq type.

### Arguments

Inputs :
* qu_eq :: QuLindbladMasterEq

  Lindblad Master Equation type

Output :
* Lindblad operator of the system


*source:*
[QuDynamics.jl/src/quequations.jl:219](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L219)

---

<a id="method__operator.2" class="lexicon_definition"></a>
#### operator(qu_eq::QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.2)
Liouvillian of the QuLiouvillevonNeumannEq type.

### Arguments

Inputs :
* qu_eq :: QuLiouvillevonNeumannEq

  Liouville von Neumann Equation type

Output :
* Liouvillian of the system


*source:*
[QuDynamics.jl/src/quequations.jl:185](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L185)

---

<a id="method__operator.3" class="lexicon_definition"></a>
#### operator(qu_eq::QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.3)
Hamiltonian of the QuSchrodingerEq type.

### Arguments

Inputs :
* qu_eq :: QuSchrodingerEq

  Schrodinger Equation type

Output :
* Hamiltonian of the system


*source:*
[QuDynamics.jl/src/quequations.jl:202](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/quequations.jl#L202)


<a id="method__start.1" class="lexicon_definition"></a>
#### start(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}) [¶](#method__start.1)
Iterator for QuMCWFEnsemble

Iterator `start` method of the Ensemble

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble

Output :
* 1


*source:*
[QuDynamics.jl/src/propmcwf.jl:64](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmcwf.jl#L64)

---

<a id="method__start.2" class="lexicon_definition"></a>
#### start(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}) [¶](#method__start.2)
Iterator for QuPropagator

Iterator `start` method for QuPropagator

### Arguments

Inputs :
* prob :: QuPropagator

  The  `QuPropagator` is used to get the initial state of the system.

Output :
* QuPropagatorState construct with parameters as initial state, start time and time state.


*source:*
[QuDynamics.jl/src/propmachinery.jl:93](https://github.com/JuliaQuantum/QuDynamics.jl/tree/becd9775c09c354e88049381321f944b6c7c5760/src/propmachinery.jl#L93)
