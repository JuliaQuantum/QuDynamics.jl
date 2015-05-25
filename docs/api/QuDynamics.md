# QuDynamics

## Exported

---

<a id="type__qucranknicolson.1" class="lexicon_definition"></a>
#### QuCrankNicolson [¶](#type__qucranknicolson.1)
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.


*source:*
[QuDynamics.jl/src/propagators.jl:69](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L69)

---

<a id="type__queuler.1" class="lexicon_definition"></a>
#### QuEuler [¶](#type__queuler.1)
Euler Method

Step Propagation using the Euler formula.


*source:*
[QuDynamics.jl/src/propagators.jl:61](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L61)

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
[QuDynamics.jl/src/propagators.jl:82](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L82)

## Internal

---

<a id="method__done.1" class="lexicon_definition"></a>
#### done(prob::QuPropagator{QPM<:QuPropagatorMethod}, qustate::QuPropagatorState) [¶](#method__done.1)
Input Parameters : QuPropagator and QuPropagator State

Returns true if the current state is final state, else false


*source:*
[QuDynamics.jl/src/propagators.jl:54](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L54)

---

<a id="method__next.1" class="lexicon_definition"></a>
#### next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod}, qustate::QuPropagatorState) [¶](#method__next.1)
Input Parameters : QuPropagator and QuPropagator State

Returns the next state by dispatching to particular
`propagate` method depending on the `numerical` method type.


*source:*
[QuDynamics.jl/src/propagators.jl:40](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L40)

---

<a id="method__propagate.1" class="lexicon_definition"></a>
#### propagate(prob::QuEuler, op, t, current_t, current_qustate) [¶](#method__propagate.1)
Propagates to the next time state
Input Parameters:
`prob`             :  Method to be used
`op`               :  Hamiltonian of the system
`t`                :  Time corresponding to the t_state
`current_t`        :  Current time
`current_qustate`  :  Quantum state corresponding to current time


*source:*
[QuDynamics.jl/src/propagators.jl:97](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L97)

---

<a id="method__start.1" class="lexicon_definition"></a>
#### start(prob::QuPropagator{QPM<:QuPropagatorMethod}) [¶](#method__start.1)
Input Parameters : QuPropagator

Returns the starting iterator state of the propagator method, i.e., the initial state of the system


*source:*
[QuDynamics.jl/src/propagators.jl:28](https://github.com/amitjamadagni/QuDynamics.jl/tree/f64239b5b2cf1ccc8c8877e1dd91a7b95add9a09/src/propagators.jl#L28)
