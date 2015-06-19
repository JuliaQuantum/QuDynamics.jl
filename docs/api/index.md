# API-INDEX


## MODULE: QuDynamics

---

## Types [Exported]

[QuCrankNicolson](QuDynamics.md#type__qucranknicolson.1)  Crank Nicolson Method

[QuEuler](QuDynamics.md#type__queuler.1)  Euler Method

[QuExpm_ExpmV](QuDynamics.md#type__quexpm_expmv.1)  Exponential solver, using ExpmV.expmv

[QuExpm_Expo](QuDynamics.md#type__quexpm_expo.1)  Exponential solver, using Epokit.expmv

[QuKrylov](QuDynamics.md#type__qukrylov.1)  Krylov subspace Method

[QuODE23s](QuDynamics.md#type__quode23s.1)  ODE Method type QuODE23s

[QuODE45](QuDynamics.md#type__quode45.1)  ODE Method type QuODE45

[QuODE78](QuDynamics.md#type__quode78.1)  ODE Method type QuODE78

---

## Methods [Internal]

[done(prob::QuPropagator{QPM<:QuPropagatorMethod}, qustate::QuPropagatorState)](QuDynamics.md#method__done.1)  Input Parameters : QuPropagator and QuPropagator State

[next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod}, qustate::QuPropagatorState)](QuDynamics.md#method__next.1)  Input Parameters : QuPropagator and QuPropagator State

[propagate(prob::QuEuler, op, t, current_t, current_qustate)](QuDynamics.md#method__propagate.1)  Propagates to the next time state

[start(prob::QuPropagator{QPM<:QuPropagatorMethod})](QuDynamics.md#method__start.1)  Input Parameters : QuPropagator

