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
[QuDynamics.jl/src/quequations.jl:68](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L68)

---

<a id="method__quliouvillevonneumanneq.1" class="lexicon_definition"></a>
#### QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(liouvillian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__quliouvillevonneumanneq.1)
Liouville von Neumann Equation method

Input Parameters :

`liouvillian` : Liouvillian of the system to construct `QuLiouvillevonNeumannEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:42](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L42)

---

<a id="method__quschrodingereq.1" class="lexicon_definition"></a>
#### QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__quschrodingereq.1)
Schrodinger Equation method

Input Parameters :

`hamiltonian` : Hamiltonian of the system to construct `QuSchrodingerEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:21](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L21)

---

<a id="type__qucranknicolson.1" class="lexicon_definition"></a>
#### QuCrankNicolson [¶](#type__qucranknicolson.1)
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:13](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propstepsolvers.jl#L13)

---

<a id="type__queuler.1" class="lexicon_definition"></a>
#### QuEuler [¶](#type__queuler.1)
Euler Method

Step Propagation using the Euler formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:5](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propstepsolvers.jl#L5)

---

<a id="type__quexpmv.1" class="lexicon_definition"></a>
#### QuExpmV [¶](#type__quexpmv.1)
Exponential solver, using ExpmV.expmv
Input Parameters :
`options` : Dictionary to set M, precision, shift, full_term by using
            keys as `:M`, `:precision`, `:shift`, `:full_term`

Step Propagation using the exponential solver ExpmV.expmv.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:24](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propexpmsolvers.jl#L24)

---

<a id="type__quexpokit.1" class="lexicon_definition"></a>
#### QuExpokit [¶](#type__quexpokit.1)
Exponential solver, using Epokit.expmv
Input Parameters :
`options` : Dictionary to set the size of Krylov subspace and tolerance by using
            keys as `:m` and `:tol`.

Step Propagation using the exponential solver Expokit.expmv.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:10](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propexpmsolvers.jl#L10)

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
[QuDynamics.jl/src/propstepsolvers.jl:26](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propstepsolvers.jl#L26)

---

<a id="type__qulindbladmastereq.1" class="lexicon_definition"></a>
#### QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__qulindbladmastereq.1)
Lindblad Master Equation type

Fields :

`lindblad`      : Lindblad operator of the system
`hamiltonain`   : Hamiltonian of the system
`collapse_ops`  : Collapse operators


*source:*
[QuDynamics.jl/src/quequations.jl:53](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L53)

---

<a id="type__quliouvillevonneumanneq.1" class="lexicon_definition"></a>
#### QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__quliouvillevonneumanneq.1)
Liouville von Neumann Equation type

Fields :

`liouvillian` : Liouvillian of the system is the only field for the type.


*source:*
[QuDynamics.jl/src/quequations.jl:30](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L30)

---

<a id="type__quode23s.1" class="lexicon_definition"></a>
#### QuODE23s [¶](#type__quode23s.1)
ODE Method type QuODE23s
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode23s implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propodesolvers.jl#L15)

---

<a id="type__quode45.1" class="lexicon_definition"></a>
#### QuODE45 [¶](#type__quode45.1)
ODE Method type QuODE45
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode45_dp implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propodesolvers.jl#L15)

---

<a id="type__quode78.1" class="lexicon_definition"></a>
#### QuODE78 [¶](#type__quode78.1)
ODE Method type QuODE78
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode78 implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propodesolvers.jl#L15)

---

<a id="type__quschrodingereq.1" class="lexicon_definition"></a>
#### QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}} [¶](#type__quschrodingereq.1)
Schrodinger Equation type

Fields :

`hamiltonian` : Hamiltonian of the system is the only field for the type.


*source:*
[QuDynamics.jl/src/quequations.jl:9](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L9)

## Internal

---

<a id="method__done.1" class="lexicon_definition"></a>
#### done(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__done.1)
Input Parameters : QuPropagator and QuPropagator State

Returns true if the current state is final state, else false


*source:*
[QuDynamics.jl/src/propmachinery.jl:59](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propmachinery.jl#L59)

---

<a id="method__lindblad_op.1" class="lexicon_definition"></a>
#### lindblad_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{T, 1}) [¶](#method__lindblad_op.1)
Lindblad operator construct from the `Hamiltonian` and `collapse operators`

Input Parameters :

`hamiltonian` : Hamiltonain of the system
`collapse_ops` : Collapse operators


*source:*
[QuDynamics.jl/src/quequations.jl:78](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L78)

---

<a id="method__liouvillian_op.1" class="lexicon_definition"></a>
#### liouvillian_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__liouvillian_op.1)
Liouvillian operator construct from the `Hamiltonian` and passing an empty array to `lindblad_op`

Input Parameters :

`hamiltonian` : Hamiltonain of the system


*source:*
[QuDynamics.jl/src/quequations.jl:123](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L123)

---

<a id="method__liouvillian_tensor.1" class="lexicon_definition"></a>
#### liouvillian_tensor(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}) [¶](#method__liouvillian_tensor.1)
An altenate version for liouvillian operator construct (might be depreciated)

Input Parameters :

`hamiltonian` :  Hamiltonain of the system


*source:*
[QuDynamics.jl/src/quequations.jl:132](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L132)

---

<a id="method__next.1" class="lexicon_definition"></a>
#### next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__next.1)
Input Parameters : QuPropagator and QuPropagator State

Returns the next state by dispatching to particular
`propagate` method depending on the `numerical` method type.


*source:*
[QuDynamics.jl/src/propmachinery.jl:46](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propmachinery.jl#L46)

---

<a id="method__operator.1" class="lexicon_definition"></a>
#### operator(qu_eq::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.1)
Input Parameters : QuLindbladMasterEq type

Returns the `lindblad operator` of the `QuLindbladMasterEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:159](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L159)

---

<a id="method__operator.2" class="lexicon_definition"></a>
#### operator(qu_eq::QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.2)
Input Parameters : QuLiouvillevonNeumannEq type

Returns the `liouvillian` of the `QuLiouvillevonNeumannEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:141](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L141)

---

<a id="method__operator.3" class="lexicon_definition"></a>
#### operator(qu_eq::QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}) [¶](#method__operator.3)
Input Parameters : QuSchrodingerEq type

Returns the `hamiltonian` of the `QuSchrodingerEq` type.


*source:*
[QuDynamics.jl/src/quequations.jl:150](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/quequations.jl#L150)

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
[QuDynamics.jl/src/propstepsolvers.jl:41](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propstepsolvers.jl#L41)

---

<a id="method__start.1" class="lexicon_definition"></a>
#### start(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}) [¶](#method__start.1)
Input Parameters : QuPropagator

Returns the starting iterator state of the propagator method, i.e., the initial state of the system


*source:*
[QuDynamics.jl/src/propmachinery.jl:33](https://github.com/amitjamadagni/QuDynamics.jl/tree/96819bf75eb5059b3ba6719ee1fc193349d867d9/src/propmachinery.jl#L33)
