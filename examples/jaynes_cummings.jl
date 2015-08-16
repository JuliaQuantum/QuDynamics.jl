# We thank QuTiP developers for sharing the notebook on Jaynes Cummings model,
# https://github.com/qutip/qutip-notebooks/blob/master/examples/example-JC-model-wigner-function.ipynb
# this is a direct translation of QuTiP version to solving in Julia using
# QuDynamics.

using QuBase
using QuDynamics

function jc_setup(N, wc, wa, g, kappa, gamma, use_rwa)
    # Hamiltonian
    idc = QuArray(eye(N))
    ida = QuArray(eye(2))
    a  = tensor(lowerop(N), ida)
    sm = tensor(idc, lowerop(2))
    if use_rwa
        # use the rotating wave approxiation
        H = wc * a' * a + wa * sm' * sm + g * (a' * sm + a * sm')
    else
        H = wc * a' * a + wa * sm' * sm + g * (a' + a) * (sm + sm')
    end
    # collapse operators
    c_op_list = Array(QuBase.AbstractQuMatrix, 0)
    n_th_a = 0.0
    rate = kappa * (1 + n_th_a)
    if rate > 0.0
       push!(c_op_list, full(sqrt(rate) * a))
    end
    rate = kappa * n_th_a
    if rate > 0.0
        push!(c_op_list, full(sqrt(rate) * a'))
    end
    rate = gamma
    if rate > 0.0
        push!(c_op_list, full(sqrt(rate) * sm))
    end
    return full(H), c_op_list
end

# parameters
wc = 1.0 * 2 * pi   # cavity frequency
wa = 1.0 * 2 * pi   # atom frequency
g  = 0.05 * 2 * pi  # coupling strength
kappa = 0.05        # cavity dissipation rate
gamma = 0.15        # atom dissipation rate
N = 2           # number of cavity fock states
use_rwa = true

# initial state
psi0 = complex(tensor(statevec(1, FiniteBasis(N)), statevec(2, FiniteBasis(2))))

tlist = 0.:0.1:2*pi

H, c_ops = jc_setup(N, wc, wa, g, kappa, gamma, use_rwa)

qprop = QuPropagator(H, c_ops, psi0*psi0', tlist, QuODE45())

# Calculating the expectation values for observable a'*a
a = tensor(lowerop(2), QuArray(eye(2)))
op = a'*a
for (t, rho) in qprop
    println("t = $t : <a'*a> = $(trace(rho*op))")
end
