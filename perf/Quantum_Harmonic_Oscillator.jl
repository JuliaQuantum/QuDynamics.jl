using QuBase
using QuDynamics
using BenchmarkLite

type SampleProc{Alg} <: Proc end

# Quantum Harmonic Oscillator type
# The type construct takes in the parameters which are used
# for constructing the various configuration used for benchmarking.
type HarmonicOscillator
    N::Int
    lambda
    tlist
end

# Name of the solver, used in the creating the table of timing analysis
Base.string{Alg}(::SampleProc{Alg}) = lowercase(string(Alg))

# Constructing a valid configuration, this is set to `true` as we have
# set the type of the required fields in the construct of `HarmonicOscillator` itself.
Base.isvalid{Alg}(p::SampleProc{Alg}, cfg::HarmonicOscillator) = true

# This returns the `hamitlonian`, initial state`, `observable whose expectation
# value is to be calculated` taking in the `cfg` configuration of the system.
function operator_set(p::SampleProc, cfg::HarmonicOscillator)
    a = lowerop(cfg.N)
    hamiltonian = a'*a + cfg.lambda*(a + a')
    init_state = complex(statevec(1,FiniteBasis(cfg.N)))
    return hamiltonian, init_state, a+a'
end

# Start states are pre-allocated, that is they are constructed before the evaluation
# here we return the `hamiltonian`, `initial state`, `observable whose expectation
# is to be calculated` using the above function i.e., operator_set. The first two remain fixed,
# the third can be varied as required.
Base.start(p::SampleProc, cfg::HarmonicOscillator) = (operator_set(p, cfg))
Base.length(p::SampleProc, cfg::HarmonicOscillator) = cfg.N
function Base.run{Alg}(p::SampleProc{Alg}, cfg::HarmonicOscillator, s::(QuBase.QuArray, QuBase.QuArray, QuBase.QuArray))
    qprop = QuPropagator(s[1], s[2], cfg.tlist, Alg())
    for (t, psi) in qprop
        psi'*s[3]*psi
    end
end

Base.done(p::SampleProc, cfg, s) = nothing

# Creating the array of methods on which benchmarks have to be performed
procs = Proc[ SampleProc{QuExpmV}(),
              SampleProc{QuExpokit}(),
              SampleProc{QuODE45}(),
              SampleProc{QuODE78}(),
              SampleProc{QuODE23s}(),
              SampleProc{QuKrylov}(),
              SampleProc{QuCrankNicolson}(),
              SampleProc{QuEuler}()]

# Setting up various configurations.
cfgs = HarmonicOscillator[HarmonicOscillator(2, 0.3, 0.:0.1:2*pi),
        HarmonicOscillator(3, 0.3, 0.:0.1:2*pi),
        HarmonicOscillator(6, 0.3, 0.:0.1:2*pi),
        HarmonicOscillator(10, 0.3, 0.:0.1:2*pi),
        HarmonicOscillator(12, 0.3, 0.:0.1:2*pi)]

# Generating the timing analysis.
rtable = run(procs, cfgs)

# Table display from the above method.
show(rtable; unit=:usec)
