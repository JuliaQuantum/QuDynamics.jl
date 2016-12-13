# TODO : QuBase.jl - WIP : complex and expectation.

@doc """
Quantum Monte-Carlo Wave Function Method

Step Propagation using the exponential solver Expokit.expmv.

### Fields :

* eps  :: Float64

  Random number used to realize (quantum) jumps.

* options :: Dict

  Dictionary to set the solver used to proagate the state generated using `draw`.
""" ->
type QuMCWF <: QuPropagatorMethod
    eps::Float64
    options::Dict{Symbol, Any}
end

QuMCWF(options::Dict=Dict()) = QuMCWF(rand(), options)

@doc """
Ensemble of state, number of trajectories, decomposition based on the state.

### Fields :

* rho <: QuBase.AbstractQuArray

  State of the system
* ntraj :: Int

  Number of trajectories
* decomp

  Decomposition is of state `rho` if `rho` is a `QuBase.AbstractQuMatrix`.
""" ->
type QuMCWFEnsemble{QA<:Union{AbstractVector, AbstractMatrix, SparseVector, SparseMatrixCSC}}
    rho::QA
    ntraj::Int
    decomp
    QuMCWFEnsemble(rho, ntraj, decomp) = new(rho, ntraj, decomp)
end

QuMCWFEnsemble{QM<:Union{AbstractMatrix, SparseMatrixCSC}}(rho::QM, ntraj=500) = QuMCWFEnsemble{QM}(rho, ntraj, eigfact(full(rho)))
QuMCWFEnsemble{QV<:AbstractVector}(psi::QV, ntraj=500) = QuMCWFEnsemble{QV}(psi, ntraj, nothing)
QuMCWFEnsemble{QV<:SparseVector}(psi::QV, ntraj=500) = QuMCWFEnsemble{QV}(SparseMatrixCSC(psi), ntraj, nothing)

Base.length(en::QuMCWFEnsemble) = en.ntraj

@doc """
Iterator for QuMCWFEnsemble

Iterator `start` method of the Ensemble

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble

Output :
* 1
""" ->
Base.start(mcwfensemble::QuMCWFEnsemble) = 1

@doc """
Iterator for QuMCWFEnsemble

Iterator `next` method of the Ensemble

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble

* state :: Int

Output :
* State using `draw` and next state.
""" ->
function Base.next(mcwfensemble::QuMCWFEnsemble, i::Int)
    state = draw(mcwfensemble)
    return (state, i+1)
end

@doc """
Iterator for QuMCWFEnsemble

Iterator `done` method of the Ensemble

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble

* state ::  Int

Output :
* Compares the iterator state with the number of trajectories and
  returns true or false depending on the comparison.
""" ->
function Base.done(mcwfensemble::QuMCWFEnsemble, i::Int)
    i > mcwfensemble.ntraj
end

@doc """
Method to draw a vector from the decomposition, using random number for selection.

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble{QuBase.AbstractQuMatrix}

  Ensemble on which decomposition is performed

Output :
* QuArray with eigen vector from decomposition passed as an argument.
""" ->
function draw{QM<:Union{AbstractMatrix, SparseMatrixCSC}}(mcwfensemble::QuMCWFEnsemble{QM})
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
Method to draw a vector, which returns a copy of the vector instead of decomposing.

### Arguments

Inputs :
* mcwfensemble :: QuMCWFEnsemble{QuBase.AbstractQuVector}

  Ensemble which is constructed using a QuVector

Output :
* Copy of the QuVector.
""" ->
function draw{QV<:Union{AbstractVector, SparseVector}}(mcwfensemble::QuMCWFEnsemble{QV})
    return copy(mcwfensemble.rho)
end

function propagate(prob::QuMCWF, eq::Union{QuLindbladMasterEq, QuLindbladMasterEqSparse}, t_end, t_start, psi)
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

propagate(prob::QuMCWF, eq::QuLindbladMasterEq, t_end, t_start, psi::AbstractVector) = propagae(prob, eq, t_end, t_start, psi)

propagate(prob::QuMCWF, eq::QuLindbladMasterEqSparse, t_end, t_start, psi::SparseVector) = propagate(prob, eq, t_end, t_start, SparseMatrixCSC(psi))

export QuMCWFEnsemble,
      QuMCWF
