# QuDynamics

## Exported

---

<a id="type__qucranknicolson.1" class="lexicon_definition"></a>
#### QuCrankNicolson [¶](#type__qucranknicolson.1)
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:13](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propstepsolvers.jl#L13)

---

<a id="type__queuler.1" class="lexicon_definition"></a>
#### QuEuler [¶](#type__queuler.1)
Euler Method

Step Propagation using the Euler formula.


*source:*
[QuDynamics.jl/src/propstepsolvers.jl:5](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propstepsolvers.jl#L5)

---

<a id="type__quexpmv.1" class="lexicon_definition"></a>
#### QuExpmV [¶](#type__quexpmv.1)
Exponential solver, using ExpmV.expmv
Input Parameters :
`options` : Dictionary to set M, precision, shift, full_term by using
            keys as `:M`, `:precision`, `:shift`, `:full_term`

Step Propagation using the exponential solver ExpmV.expmv.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:24](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propexpmsolvers.jl#L24)

---

<a id="type__quexpokit.1" class="lexicon_definition"></a>
#### QuExpokit [¶](#type__quexpokit.1)
Exponential solver, using Epokit.expmv
Input Parameters :
`options` : Dictionary to set the size of Krylov subspace and tolerance by using
            keys as `:m` and `:tol`.

Step Propagation using the exponential solver Expokit.expmv.


*source:*
[QuDynamics.jl/src/propexpmsolvers.jl:10](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propexpmsolvers.jl#L10)

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
[QuDynamics.jl/src/propstepsolvers.jl:26](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propstepsolvers.jl#L26)

---

<a id="type__quode23s.1" class="lexicon_definition"></a>
#### QuODE23s [¶](#type__quode23s.1)
ODE Method type QuODE23s
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode23s implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propodesolvers.jl#L15)

---

<a id="type__quode45.1" class="lexicon_definition"></a>
#### QuODE45 [¶](#type__quode45.1)
ODE Method type QuODE45
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode45_dp implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propodesolvers.jl#L15)

---

<a id="type__quode78.1" class="lexicon_definition"></a>
#### QuODE78 [¶](#type__quode78.1)
ODE Method type QuODE78
Input Parameters :
`options` : Dictionary to set the relative tolerance and absolute tolerance by using
            keys as `:reltol` and `:abstol`.

Step Propagation using the ode78_fb implementation from `ODE.jl`.


*source:*
[QuDynamics.jl/src/propodesolvers.jl:15](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propodesolvers.jl#L15)

## Internal

---

<a id="method__done.1" class="lexicon_definition"></a>
#### done(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__done.1)
Input Parameters : QuPropagator and QuPropagator State

Returns true if the current state is final state, else false


*source:*
[QuDynamics.jl/src/propmachinery.jl:55](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propmachinery.jl#L55)

---

<a id="method__next.1" class="lexicon_definition"></a>
#### next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}), QE<:QuEquation}, qustate::QuPropagatorState) [¶](#method__next.1)
Input Parameters : QuPropagator and QuPropagator State

Returns the next state by dispatching to particular
`propagate` method depending on the `numerical` method type.


*source:*
[QuDynamics.jl/src/propmachinery.jl:42](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propmachinery.jl#L42)

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
[QuDynamics.jl/src/propstepsolvers.jl:41](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propstepsolvers.jl#L41)

---

<a id="method__start.1" class="lexicon_definition"></a>
#### start(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}), QE<:QuEquation}) [¶](#method__start.1)
Input Parameters : QuPropagator

Returns the starting iterator state of the propagator method, i.e., the initial state of the system


*source:*
[QuDynamics.jl/src/propmachinery.jl:29](https://github.com/amitjamadagni/QuDynamics.jl/tree/473660e023dbcf579848d92b1318e375cf1c5c65/src/propmachinery.jl#L29)
