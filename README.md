QuDynamics.jl
============

[![Build Status](https://travis-ci.org/JuliaQuantum/QuDynamics.jl.png?branch=master)](https://travis-ci.org/JuliaQuantum/QuDynamics.jl)

A JuliaQuantum package for solving dynamical equations in quantum mechanics.

The package aims to provide a flexible and unified framework for solving dynamical equations in quantum mechanics. The package will make use of existing packages mainly QuBase.jl in addition to various other solver packages like ODE.jl, Expokit.jl.
Some of the discussion regarding design and implementation can be found [here](https://github.com/JuliaQuantum/JuliaQuantum.github.io/issues/20) and [here](https://github.com/numfocus/gsoc/blob/7917b4fc08ce73ac74f8a2b9dd7929d994fc4282/2015/proposals/Amit.md). Updates of the implemented features can be followed on the [news page](http://juliaquantum.github.io/news/) of the JuliaQuantum website.

**Dependencies**

QuBase.jl

This has to be added using
```julia
Pkg.clone("https://github.com/JuliaQuantum/QuBase.jl.git")
```

**Usage**

QuDynamics.jl

The current package can be used by
```julia
Pkg.clone("https://github.com/JuliaQuantum/QuDynamics.jl.git")
```
