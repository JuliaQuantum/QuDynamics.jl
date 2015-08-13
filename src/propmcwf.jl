# TODO : QuBase.jl - WIP : complex and expectation.

@doc """
Quantum Monte-Carlo Wave Function Method
Input Parameters :
`eps`     : random number used in comparison of jtol and norm of the state drawn
`options` : Dictionary to set the solver used to proagate the state generated using draw.

Step Propagation using Quantum Monte-Carlo Wave Function Method.
""" ->
type QuMCWF <: QuPropagatorMethod
    eps::Float64
    options::Dict{Symbol, Any}
end

QuMCWF(options::Dict=Dict()) = QuMCWF(rand(), options)

@doc """
Ensemble of state, number of trajectories, decomposition based on the state.

Fields :

`rho`   : state of the system
`ntraj` : number of trajectories
`decomp`: decomposition is of state `rho` if `rho` is a QuMatrix.
""" ->
type QuMCWFEnsemble{QA<:QuBase.AbstractQuArray}
    rho::QA
    ntraj::Int
    decomp
    QuMCWFEnsemble(rho, ntraj, decomp) = new(rho, ntraj, decomp)
end

QuMCWFEnsemble{QM<:QuBase.AbstractQuMatrix}(rho::QM, ntraj=500) = QuMCWFEnsemble{QM}(rho, ntraj, eigfact(full(coeffs(rho))))
QuMCWFEnsemble{QV<:QuBase.AbstractQuVector}(psi::QV, ntraj=500) = QuMCWFEnsemble{QV}(psi, ntraj, nothing)

Base.length(en::QuMCWFEnsemble) = en.ntraj

@doc """
Input Parameters : QuMCWFEnsemble

Returns the starting iterator state of the Ensemble
""" ->
Base.start(mcwfensemble::QuMCWFEnsemble) = 1

@doc """
Input Parameters : QuMCWFEnsemble and iterator state

Returns the next state by using `draw` function
to draw the next state and iterator state.
""" ->
function Base.next(mcwfensemble::QuMCWFEnsemble, i::Int)
    state = draw(mcwfensemble)
    return (state, i+1)
end

@doc """
Input Parameters : QuMCWFEnsemble and iterator state

Compares the iterator state with the number of trajectories and
returns true or false depending on the comparison.
""" ->
function Base.done(mcwfensemble::QuMCWFEnsemble, i::Int)
    i > mcwfensemble.ntraj
end

@doc """
Input Parameters : QuMCWFEnsemble which takes a AbstractQuMatrix as a parameter

Returns state vector using the decomposition of AbstractQuMatrix.
""" ->
function draw{QM<:QuBase.AbstractQuMatrix}(mcwfensemble::QuMCWFEnsemble{QM})
    r = rand() # draw random number from [0,1)
    pacc = 0.
    for i=1:length(mcwfensemble.decomp[:values])
        pacc = pacc + mcwfensemble.decomp[:values][i]
        if pacc >= r
            return QuArray(mcwfensemble.decomp[:vectors][:,i])
        end
    end
end

@doc """
Input Parameters : QuMCWFEnsemble which takes a AbstractQuVector as a parameter

Returns a copy of the state passed through the input parameter.
""" ->
function draw{QV<:QuBase.AbstractQuVector}(mcwfensemble::QuMCWFEnsemble{QV})
    return copy(mcwfensemble.rho)
end

function propagate(prob::QuMCWF, eq::QuLindbladMasterEq, t_end, t_start, psi)
    const jtol = 1.e-6  # jump tolerance
    # get information of QME
    heff = eff_hamiltonian(eq)
    c_ops = eq.collapse_ops
    dt = t_end - t_start
    accdt = 0.
    while accdt < t_end - t_start
        # propagate one time-step
        # the following only works for time independent cases (WIP for time dependent)
        psi1 = propagate(get(prob.options, :solver, QuExpmV()), QuSchrodingerEq(heff), t_start + dt, t_start, psi)
        if norm(psi1)^2 > prob.eps + jtol/2
            psi = copy(psi1)  # no jump
            accdt = accdt + dt
            dt = (t_end - t_start) - accdt
        elseif norm(psi1)^2 < prob.eps - jtol/2
            dt = dt/2		# jump in the current interval
        else
            if isempty(c_ops)
                psi = copy(psi1)
            else
                PnS = 0.
                for cind in c_ops
                    # PnS = PnS + real(expectation(psi1, cind'*cind))
                    PnS =  PnS + real(dot(psi1, cind'*cind*psi1))
                end
                Pn = 0.
                for cind in c_ops
                    # Pn = Pn + real(expectation(psi1, cind'*cind))/PnS
                    Pn = Pn + real(dot(psi1, cind'*cind*psi1))/PnS
                    if Pn >= prob.eps
                        psi = cind*psi1
                        break
                    end
                end
            end
            normalize!(psi)
            prob.eps =  rand()
            accdt = accdt + dt
            dt =  (t_end - t_start) - accdt
        end
    end
    return psi
end

export QuMCWFEnsemble,
      QuMCWF
