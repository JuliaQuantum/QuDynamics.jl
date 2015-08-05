To run the files, add the Package BenchmarkLite.jl by doing

```
Pkg.add("BenchmarkLite.jl")
```

These files relate to the benchmarks performed using the package [BenckmarkLite.jl](https://github.com/lindahua/BenchmarkLite.jl).
Benchmarks are performed using various configuration i.e., set of construction of hamiltonian,  collapse operators,
time steps, initial states.

The benchmarks aim at timing of the solvers implemented i.e., the timing of various solvers for various
configurations is analyzed and summarized. The benchmark analysis has been performed on the following models :

1. Jaynes-Cummings Model
2. Quantum Harmonic Oscillator

The Jaynes-Cummings Model uses the following parameters which can be varied :
`hamiltonian`, `collapse operators`, `initial state`, these depend on `N - basis size`, the other parameters include
`wc - cavity frequency`, `wa - atom frequency`, `g - coupling strength`,  `kappa - cavity dissipation rate`,
`gamma - atom dissipation rate`, `tlist -  time steps array`

Quantum Harmonic Oscillator uses the following parameters which can be varied :
`hamiltonian`, `initial state` these depend on `N - basis size`, `lambda`, `tlist - time step array`

The results of Jaynes Cummings model have been presented in this [notebook](https://github.com/amitjamadagni/Notes-Notebooks/blob/master/Notebooks/Jaynes%20Cummings%20Benchmarks.ipynb)
and Quantum Harmonic Oscillator in this [notebook](https://github.com/amitjamadagni/Notes-Notebooks/blob/master/Notebooks/Quantum%20Harmonic%20Oscillator%20Benchmarks.ipynb)
