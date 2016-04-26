QuDynamics.jl
============

A [JuliaQuantum](http://juliaquantum.github.io/) package for solving dynamical equations in quantum mechanics.


[![Build Status](https://travis-ci.org/JuliaQuantum/QuDynamics.jl.png?branch=master)](https://travis-ci.org/JuliaQuantum/QuDynamics.jl)
[![Coverage Status](https://coveralls.io/repos/github/JuliaQuantum/QuDynamics.jl/badge.svg?branch=master)](https://coveralls.io/github/JuliaQuantum/QuDynamics.jl?branch=master)
[![Join the chat at https://gitter.im/JuliaQuantum/QuDynamics.jl](https://badges.gitter.im/JuliaQuantum/QuDynamics.jl.svg)](https://gitter.im/JuliaQuantum/QuDynamics.jl?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Use [Binder](http://mybinder.org/) to play around instantly, preloaded with QuDynamics, QuBase packages and PyPlot, Gadfly packages for plotting. Jupyter is the medium allowing notebooks, terminal interface. For instance checkout the notebooks in examples.

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org/repo/JuliaQuantum/QuDynamics.jl)

Background
----------
The package is aimed at providing a unified framework for solvers for solving Dynamical Equations in Quantum Mechanics. Various solvers have been integrated from packages like [ODE.jl](https://github.com/JuliaLang/ODE.jl), [ExpmV.jl](https://github.com/marcusps/ExpmV.jl),
[Expokit.jl](https://github.com/acroy/Expokit.jl), using base features from [QuBase.jl](https://github.com/JuliaQuantum/QuBase.jl). QuBase.jl is the base package which includes most of the basic type constructs and methods used in Quantum Mechanics.

Overview
--------
The following Dynamical Equations can be solved using this package :

1. Schrodinger Equation
2. Liouville von Neumann Equation
3. Lindblad Master Equation

Using the following solvers :

1. Euler Method, Crank-Nicholson Method, Krylov subspace Method
2. ode45, ode78, ode23s which have been integrated from [ODE.jl](https://github.com/JuliaLang/ODE.jl)
3. Two versions of `expmv` implementations from :

    a. [ExpmV.jl](https://github.com/marcusps/ExpmV.jl)
    b. [Expokit.jl](https://github.com/acroy/Expokit.jl)
4. Quantum Monte-Carlo Wave Function Method has been integrated with reference from the article : Monte Carlo Simulation of the Atomic Master Equation for Spontaneous Emission, Phys. Rev. A 45, 4879 (1992)
by R. Dum, P. Zoller, and H. Ritsch.

Installation
------------
As the solvers have been integrated from various packages and also that QuDynamics is based on QuBase.jl, we need to install the following for using QuDynamics.

**Dependencies**

* **QuBase.jl**

This has to be added using
```julia
Pkg.clone("https://github.com/JuliaQuantum/QuBase.jl.git")
```

* **Expokit.jl**

This has to be added using
```julia
Pkg.clone("https://github.com/acroy/Expokit.jl.git")
```

* **ExpmV.jl**

This has to be added using
```julia
Pkg.clone("https://github.com/marcusps/ExpmV.jl.git")
```

The current package can be used by
```julia
Pkg.clone("https://github.com/JuliaQuantum/QuDynamics.jl.git")
```

Usage
-----

We could start using the package by :
```julia
using QuBase
using QuDynamics
```

`QuPropagator` is the starting point in order to compute or plot, related entities like states at different time steps, expectation values of an observable and so on. `QuProagator` is the  one which takes
in the configuration of the system along with the solver which is to be used for solving.

For example, consider the following configuration :

```julia
hamiltonian = sigmax                           # the Hamiltonian of the system
initial_state = statevec(1, FiniteBasis(2))    # the initial state of the system
tlist = 0.:0.1:2*pi                            # the time steps at each of which we have the evolved state
```

Now we have the basic ingredients to construct the `QuPropagator`, assuming we have a solver in mind.
We construct the following :

```julia
qprop_ode45 = QuPropagator(hamiltonian, initial_state, tlist, QuODE45())
```

The general format of `QuPropagator` construct is as follows :
`QuPropagator(Hamiltonian_of_the_system, Collapse_operators, Initial_state, Time_step_array, Solver)`

Alternatively we can also pass :
`QuPropagator(Type_of_Equation, Initial_state, Time_step_array, Solver)`

Implying, we could do the following which is equivalent to the above construction of `qprop_ode45`

```julia
schrodinger_eq = QuSchrodingerEq(hamiltonian)
qprop_ode45 = QuPropagator(schrodinger_eq, initial_state, tlist, QuODE45())
```

A common convention for the `equations` and `solvers` types and methods is they start with a prefix `Qu`.
For example :
```
`Schrodinger Equation` => `QuSchrodingerEq`
`ode45` => `QuODE45`
`expmv` => `QuExpmV` or `QuExpokit` (based on the packages)
```

Now we are all set to calculate the states at various time steps which can be achieved in the
following ways :

**Method - 1**:
To get the evolved state at every time instant, we can do the following :
```julia
for (t, psi) in qprop_ode45
    println("t : $t, psi : $psi")
end
```

**Method - 2**:
To get the evolved state at the next time instant (here we get the state after the fist time-step), we can do the following :
```julia
next_state = propagate(QuODE45(), QuSchrodingerEq(h), t[2], t[1], initial_state)
println(next_state)
```

For more examples and work cases, please refer to the [examples](https://github.com/JuliaQuantum/QuDynamics.jl/tree/master/examples) folder of the repo.

Note : Instances of `QuPropagator` can also be called by `QuStateEvolution`. Also the propagation of evolution operator can be
evaluated using `QuEvolutionOp`.

Discussions
----------

The following discussions tend to provide an insight on the design of the internals :

1. [The GSoC blog updates](http://juliaquantum.github.io/news/index.html)
2. Design and implementation related discussion [a](https://github.com/JuliaQuantum/JuliaQuantum.github.io/issues/20), [b](https://github.com/numfocus/gsoc/blob/7917b4fc08ce73ac74f8a2b9dd7929d994fc4282/2015/proposals/Amit.md)
3. [Issues](https://github.com/JuliaQuantum/QuDynamics.jl/issues) and [Pull Requests](https://github.com/JuliaQuantum/QuDynamics.jl/pulls) are also good references which shed light on the development of the package.
4. [Wiki](https://github.com/JuliaQuantum/QuDynamics.jl/wiki) page has a mention of the design and implementation related discussion.

Contributions
-----------

We would love to have contributors. The process is simple :

1. Fork and clone the repo.
2. Create a local branch and implement the changes.
3. Test the changes and send in a pull request.
