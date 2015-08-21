# API-INDEX


## MODULE: QuDynamics

---

## Methods [Exported]

[QuLindbladMasterEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, 1})](QuDynamics.md#method__qulindbladmastereq.1)  Lindblad Master Equation method

[QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(liouvillian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2})](QuDynamics.md#method__quliouvillevonneumanneq.1)  Liouville von Neumann Equation method

[QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(hamiltonian::H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2})](QuDynamics.md#method__quschrodingereq.1)  Schrodinger Equation method

[propagate(prob::QuEuler, eq::QuEquation, t, current_t, current_qustate)](QuDynamics.md#method__propagate.1)  Propagate for different solver types.

---

## Types [Exported]

[QuCrankNicolson](QuDynamics.md#type__qucranknicolson.1)  Crank Nicolson Method

[QuEuler](QuDynamics.md#type__queuler.1)  Euler method

[QuExpmV](QuDynamics.md#type__quexpmv.1)  Exponential solver, using ExpmV.expmv

[QuExpokit](QuDynamics.md#type__quexpokit.1)  Exponential solver, using Expokit.expmv

[QuKrylov](QuDynamics.md#type__qukrylov.1)  Krylov subspace Method

[QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}](QuDynamics.md#type__qulindbladmastereq.1)  Lindblad Master Equation type

[QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}](QuDynamics.md#type__quliouvillevonneumanneq.1)  Liouville von Neumann Equation type

[QuMCWF](QuDynamics.md#type__qumcwf.1)  Quantum Monte-Carlo Wave Function Method

[QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}](QuDynamics.md#type__qumcwfensemble.1)  Ensemble of state, number of trajectories, decomposition based on the state.

[QuODE23s](QuDynamics.md#type__quode23s.1)  ODE solver, using QuODE23s

[QuODE45](QuDynamics.md#type__quode45.1)  ODE solver, using QuODE45

[QuODE78](QuDynamics.md#type__quode78.1)  ODE solver, using QuODE78

[QuPropagatorState](QuDynamics.md#type__qupropagatorstate.1)  QuPropagator State

[QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}](QuDynamics.md#type__qupropagator.1)  QuPropagator Type

[QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}](QuDynamics.md#type__quschrodingereq.1)  Schrodinger Equation type

---

## Methods [Internal]

[done(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}, i::Int64)](QuDynamics.md#method__done.1)  Iterator for QuMCWFEnsemble

[done(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState)](QuDynamics.md#method__done.2)  Iterator for QuPropagator

[draw{QM<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}}(mcwfensemble::QuMCWFEnsemble{QM<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}})](QuDynamics.md#method__draw.1)  Method to draw a vector from the decomposition, using random number for selection.

[draw{QV<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}}(mcwfensemble::QuMCWFEnsemble{QV<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}})](QuDynamics.md#method__draw.2)  Method to draw a vector, which returns a copy of the vector instead of decomposing.

[eff_hamiltonian(lme::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}})](QuDynamics.md#method__eff_hamiltonian.1)  Effective hamiltonian calculated using the hamiltonian and collapse operators.

[lindblad_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, collapse_ops::Array{T, 1})](QuDynamics.md#method__lindblad_op.1)  Lindblad operator construct from the `Hamiltonian` and `collapse operators`

[liouvillian_op(hamiltonian::AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2})](QuDynamics.md#method__liouvillian_op.1)  Liouvillian operator construct from the `Hamiltonian` and passing an empty array to `lindblad_op`

[next(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}}, i::Int64)](QuDynamics.md#method__next.1)  Iterator for QuMCWFEnsemble

[next{QPM<:QuPropagatorMethod}(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation}, qustate::QuPropagatorState)](QuDynamics.md#method__next.2)  Iterator for QuPropagator

[operator(qu_eq::QuLindbladMasterEq{L<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, V<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}})](QuDynamics.md#method__operator.1)  Lindblad operator of the QuLindbladMasterEq type.

[operator(qu_eq::QuLiouvillevonNeumannEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}})](QuDynamics.md#method__operator.2)  Liouvillian of the QuLiouvillevonNeumannEq type.

[operator(qu_eq::QuSchrodingerEq{H<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}})](QuDynamics.md#method__operator.3)  Hamiltonian of the QuSchrodingerEq type.

[start(mcwfensemble::QuMCWFEnsemble{QA<:AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, N}})](QuDynamics.md#method__start.1)  Iterator for QuMCWFEnsemble

[start(prob::QuPropagator{QPM<:QuPropagatorMethod, QVM<:Union(AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 2}, AbstractQuArray{B<:AbstractBasis{S<:AbstractStructure}, T, 1}), QE<:QuEquation})](QuDynamics.md#method__start.2)  Iterator for QuPropagator

