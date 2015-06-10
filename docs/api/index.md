# API-INDEX


## MODULE: QuDynamics

---

## Types [Exported]

[QuCrankNicolson](QuDynamics.md#type__qucranknicolson.1)  Crank Nicolson Method

[QuEuler](QuDynamics.md#type__queuler.1)  Euler Method

[QuKrylov](QuDynamics.md#type__qukrylov.1)  Krylov subspace Method

---

## Methods [Internal]

[done(prob::QuPropagator{QPM<:QuPropagatorMethod}, qustate::QuPropagatorState)](QuDynamics.md#method__done.1)  Input Parameters : QuPropagator and QuPropagator State

[next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod}, qustate::QuPropagatorState)](QuDynamics.md#method__next.1)  Input Parameters : QuPropagator and QuPropagator State

[propagate(prob::QuEuler, op, t, current_t, current_qustate)](QuDynamics.md#method__propagate.1)  Propagates to the next time state

[start(prob::QuPropagator{QPM<:QuPropagatorMethod})](QuDynamics.md#method__start.1)  Input Parameters : QuPropagator

