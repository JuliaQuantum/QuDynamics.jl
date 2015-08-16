# We thank QuTiP developers for sharing the example on Quantum MCWF method,
# this is a direct translation of QuTiP version to solving in Julia using
# QuDynamics.

using QuBase
using QuDynamics

# Parameters
wc = 1.0 * 2 * pi   # cavity frequency
wa = 1.0 * 2 * pi   # atom frequency
g  = 0.25 * 2 * pi  # coupling strength
kappa = 0.05        # cavity dissipation rate
gamma = 0.15        # atom dissipation rate
use_rwa = true
tlist = linspace(0., 10., 200)

# System construction

# Hamiltonian
idc = QuArray(eye(10))
ida = QuArray(eye(2))
a  = tensor(ida, lowerop(10))
sm = tensor(lowerop(2), idc)
if use_rwa
    # use the rotating wave approxiation
    hamiltonian = wc * a' * a + wa * sm' * sm + g * (a' * sm + a * sm')
else
    hamiltonian = wc * a' * a + wa * sm' * sm + g * (a' + a) * (sm + sm')
end

# initial state
init_state = complex(tensor(statevec(1, FiniteBasis(2)), statevec(6, FiniteBasis(10))))
init_state_dm = complex(init_state*init_state')

# collapse operators
c_ops = [sqrt(0.1) * a]

# rho being constructed to store density matrix at every time step
rho = Array(typeof(init_state_dm), length(tlist)-1)
qumcwfen = QuMCWFEnsemble(complex(init_state), 1000)
for i=1:length(tlist)-1
    rho[i] = complex(zeros(init_state_dm))
end

# Using MCWF and extracting the density matrices
for psi0 in qumcwfen
    i = 1
    mcwf = QuMCWF()
    for (t,psi) in QuPropagator(hamiltonian, c_ops, psi0, tlist, mcwf)
        rho[i] = rho[i] + (psi*psi')/length(qumcwfen)/norm(psi)^2
        i = i + 1
    end
end

# Calculating the expectation of the observable a'*a and sm'*sm at every time step
for i in 1:length(tlist)-1
    println("t = $(tlist[i+1]) : <a'*a> = $(trace(rho[i]*a'*a)), <sm'*sm> = $(trace(rho[i]*sm'* sm))")
end
