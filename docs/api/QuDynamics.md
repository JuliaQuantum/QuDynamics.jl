# QuDynamics

## Exported

---

<a id="method__qulindbladmastereq.1" class="lexicon_definition"></a>
#### QuLindbladMasterEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, 1}) [¶](#method__qulindbladmastereq.1)
Lindblad Master Equation method

Input Parameters :

`hamiltonian` : Hamiltonain of the system
`collapse_ops` : Collapse operators


*source:*
[QuDynamics.jl/src/quequations.jl:68](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L68)

---

<a id="method__quliouvillevonneumanneq.1" class="lexicon_definition"></a>
#### QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(liouvillian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__quliouvillevonneumanneq.1)
Liouville von Neumann Equation method

Input Parameters :

`liouvillian` : Liouvillian of the system to construct `QuLiouvillevonNeumannEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:42](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L42)

---

<a id="method__quschrodingereq.1" class="lexicon_definition"></a>
#### QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__quschrodingereq.1)
Schrodinger Equation method

Input Parameters :

`hamiltonian` : Hamiltonian of the system to construct `QuSchrodingerEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:21](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L21)

---

<a id="type__qucranknicolson.1" class="lexicon_definition"></a>
#### QuCrankNicolson [¶](#type__qucranknicolson.1)
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:13](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propstepsolvers.jl#L13)

---

<a id="type__queuler.1" class="lexicon_definition"></a>
#### QuEuler [¶](#type__queuler.1)
Euler Method

Step Propagation using the Euler formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:5](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propstepsolvers.jl#L5)

---

<a id="type__quexpmv.1" class="lexicon_definition"></a>
#### QuExpmV [¶](#type__quexpmv.1)
Exponential solver, using ExpmV.expmv
Input Parameters :
`options` : Dictionary to set M, precision, shift, full_term by using
            keys as `:M`, `:precision`, `:shift`, `:full_term`

Step Propagation using the exponential solver ExpmV.expmv.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:24](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propexpmsolvers.jl#L24)

---

<a id="type__quexpokit.1" class="lexicon_definition"></a>
#### QuExpokit [¶](#type__quexpokit.1)
Exponential solver, using Epokit.expmv
Input Parameters :
`options` : Dictionary to set the size of Krylov subspace and tolerance by using
            keys as `:m` and `:tol`.

Step Propagation using the exponential solver Expokit.expmv.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:10](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propexpmsolvers.jl#L10)

---

<a id="type__qukrylov.1" class="lexicon_definition"></a>
#### QuKrylov [¶](#type__qukrylov.1)
Krylov subspace Method
Input Parameters :
`options` : Dictionary to set the basis size with keyword NC.

For ex :
x = [:NC => basis_size]
QuKrylov(x)
Step Propagation using the Krylov subspace iterations.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:26](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propstepsolvers.jl#L26)

---

<a id="type__qulindbladmastereq.1" class="lexicon_definition"></a>
#### QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__qulindbladmastereq.1)
Lindblad Master Equation type

Fields :

`lindblad`      : Lindblad operator of the system
`hamiltonain`   : Hamiltonian of the system
`collapse_ops`  : Collapse operators


*source:*
[QuDynamics.jl/src/quequations.jl:53](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L53)

---

<a id="type__quliouvillevonneumanneq.1" class="lexicon_definition"></a>
#### QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__quliouvillevonneumanneq.1)
Liouville von Neumann Equation type

Fields :

`liouvillian` : Liouvillian of the system is the only field for the type.


*source:*
[QuDynamics.jl/src/quequations.jl:30](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L30)

---

<a id="type__qumcwf.1" class="lexicon_definition"></a>
#### QuMCWF [¶](#type__qumcwf.1)
Quantum Monte-Carlo Wave Function Method
Input Parameters :
`eps`     : random number used in comparison of jtol and norm of the state drawn
`options` : Dictionary to set the solver used to proagate the state generated using draw.

Step Propagation using Quantum Monte-Carlo Wave Function Method.


*source:*
[QuDynamics.jl/src/propmcwf.jl:8](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L8)

---

<a id="type__qumcwfensemble.1" class="lexicon_definition"></a>
#### QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}} [¶](#type__qumcwfensemble.1)
Ensemble of state, number of trajectories, decomposition based on the state.

Fields :

`rho`   : state of the system
`ntraj` : number of trajectories
`decomp`: decomposition is of state `rho` if `rho` is a QuMatrix.


*source:*
[QuDynamics.jl/src/propmcwf.jl:24](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L24)

---

<a id="type__quode23s.1" class="lexicon_definition"></a>
#### QuODE23s [¶](#type__quode23s.1)
ODE Method type QuODE23s
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode23s implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propodesolvers.jl#L15)

---

<a id="type__quode45.1" class="lexicon_definition"></a>
#### QuODE45 [¶](#type__quode45.1)
ODE Method type QuODE45
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode45_dp implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propodesolvers.jl#L15)

---

<a id="type__quode78.1" class="lexicon_definition"></a>
#### QuODE78 [¶](#type__quode78.1)
ODE Method type QuODE78
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode78 implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propodesolvers.jl#L15)

---

<a id="type__quschrodingereq.1" class="lexicon_definition"></a>
#### QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__quschrodingereq.1)
Schrodinger Equation type

Fields :

`hamiltonian` : Hamiltonian of the system is the only field for the type.


*source:*
[QuDynamics.jl/src/quequations.jl:9](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L9)

## Internal

---

<a id="method__done.1" class="lexicon_definition"></a>
#### done(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}, i::Int64) [¶](#method__done.1)
Input Parameters : QuMCWFEnsemble and iterator state

Compares the iterator state with the number of trajectories and
returns true or false depending on the comparison.


*source:*
[QuDynamics.jl/src/propmcwf.jl:57](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L57)

---

<a id="method__done.2" class="lexicon_definition"></a>
#### done(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__done.2)
Input Parameters : QuPropagator and QuPropagator State

Returns true if the current state is final state, else false


*source:*
[QuDynamics.jl/src/propmachinery.jl:61](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmachinery.jl#L61)

---

<a id="method__draw.1" class="lexicon_definition"></a>
#### draw{QM<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(mcwfensemble::QuMCWFEnsemble{QM<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__draw.1)
Input Parameters : QuMCWFEnsemble which takes a AbstractQuMatrix as a parameter

Returns state vector using the decomposition of AbstractQuMatrix.


*source:*
[QuDynamics.jl/src/propmcwf.jl:66](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L66)

---

<a id="method__draw.2" class="lexicon_definition"></a>
#### draw{QV<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}}(mcwfensemble::QuMCWFEnsemble{QV<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}}) [¶](#method__draw.2)
Input Parameters : QuMCWFEnsemble which takes a AbstractQuVector as a parameter

Returns a copy of the state passed through the input parameter.


*source:*
[QuDynamics.jl/src/propmcwf.jl:82](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L82)

---

<a id="method__eff_hamiltonian.1" class="lexicon_definition"></a>
#### eff_hamiltonian(lme::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__eff_hamiltonian.1)
Input Parameters : QuLindbladMasterEq type parameter

Returns the effective hamiltonian calculated using the hamiltonian and
collapse operators.


*source:*
[QuDynamics.jl/src/propmcwf.jl:92](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L92)

---

<a id="method__lindblad_op.1" class="lexicon_definition"></a>
#### lindblad_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{T, 1}) [¶](#method__lindblad_op.1)
Lindblad operator construct from the `Hamiltonian` and `collapse operators`

Input Parameters :

`hamiltonian` : Hamiltonain of the system
`collapse_ops` : Collapse operators


*source:*
[QuDynamics.jl/src/quequations.jl:81](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L81)

---

<a id="method__liouvillian_op.1" class="lexicon_definition"></a>
#### liouvillian_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__liouvillian_op.1)
Liouvillian operator construct from the `Hamiltonian` and passing an empty array to `lindblad_op`

Input Parameters :

`hamiltonian` : Hamiltonain of the system


*source:*
[QuDynamics.jl/src/quequations.jl:126](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L126)

---

<a id="method__liouvillian_tensor.1" class="lexicon_definition"></a>
#### liouvillian_tensor(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__liouvillian_tensor.1)
An altenate version for liouvillian operator construct (might be depreciated)

Input Parameters :

`hamiltonian` :  Hamiltonain of the system


*source:*
[QuDynamics.jl/src/quequations.jl:135](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L135)

---

<a id="method__next.1" class="lexicon_definition"></a>
#### next(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}, i::Int64) [¶](#method__next.1)
Input Parameters : QuMCWFEnsemble and iterator state

Returns the next state by using `draw` function
to draw the next state and iterator state.


*source:*
[QuDynamics.jl/src/propmcwf.jl:46](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L46)

---

<a id="method__next.2" class="lexicon_definition"></a>
#### next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__next.2)
Input Parameters : QuPropagator and QuPropagator State

Returns the next state by dispatching to particular
`propagate` method depending on the `numerical` method type.


*source:*
[QuDynamics.jl/src/propmachinery.jl:48](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmachinery.jl#L48)

---

<a id="method__operator.1" class="lexicon_definition"></a>
#### operator(qu_eq::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.1)
Input Parameters : QuLindbladMasterEq type

Returns the `lindblad operator` of the `QuLindbladMasterEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:162](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L162)

---

<a id="method__operator.2" class="lexicon_definition"></a>
#### operator(qu_eq::QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.2)
Input Parameters : QuLiouvillevonNeumannEq type

Returns the `liouvillian` of the `QuLiouvillevonNeumannEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:144](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L144)

---

<a id="method__operator.3" class="lexicon_definition"></a>
#### operator(qu_eq::QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.3)
Input Parameters : QuSchrodingerEq type

Returns the `hamiltonian` of the `QuSchrodingerEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:153](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/quequations.jl#L153)

---

<a id="method__propagate.1" class="lexicon_definition"></a>
#### propagate(prob::QuEuler, eq::QuEquation, t, current_t, current_qustate) [¶](#method__propagate.1)
Propagates to the next time state
Input Parameters:
`prob`             :  Method to be used
`eq`               :  Quantum Equation type
`t`                :  Time corresponding to the t_state
`current_t`        :  Current time
`current_qustate`  :  Quantum state corresponding to current time


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:41](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propstepsolvers.jl#L41)

---

<a id="method__start.1" class="lexicon_definition"></a>
#### start(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}) [¶](#method__start.1)
Input Parameters : QuMCWFEnsemble

Returns the starting iterator state of the Ensemble


*source:*
[QuDynamics.jl/src/propmcwf.jl:38](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmcwf.jl#L38)

---

<a id="method__start.2" class="lexicon_definition"></a>
#### start(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}) [¶](#method__start.2)
Input Parameters : QuPropagator

Returns the starting iterator state of the propagator method, i.e., the initial state of the system


*source:*
[QuDynamics.jl/src/propmachinery.jl:35](https://github.com/amitjamadagni/QuDynamics.jl/tree/4e8fbe16f66de06394a2bd28a4cfd81993fb1586/src/propmachinery.jl#L35)
