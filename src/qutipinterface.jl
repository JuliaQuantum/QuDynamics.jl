# TODO : QuBase.jl complex WIP. Issue 38. https://github.com/JuliaQuantum/QuBase.jl/pull/38
Base.complex{B<:QuBase.OrthonormalBasis}(qarr::QuBase.AbstractQuArray{B}) = QuBase.similar_type(qarr)(complex(coeffs(qarr)), bases(qarr))

@doc """
Inspired by `sesolve`[http://qutip.org/docs/3.1.0/apidoc/functions.html#module-qutip.sesolve] of QuTiP in QuDynamics

`sesolve` in QuDynamics, extended version.

### Arguments

Inputs :
* H/SE/LVNE :: AbstractQuArray/QuSchrodingerEq/QuLiouvillevonNeumannEq Types

  This parameter supports Hamiltonian of the system, Schrodinger Equation, LiouvillevonNeumann Equation
* psi :: AbstractQuArray

  Initial state vector or density matrix of the system
* tlist

  Time step array/range
* e_ops

  Operators whose expectation values are to computed in the evolved states
* solver

  Keyword for selecting the solver from the various solvers supported by QuDynamics

Output :
* Two Arrays, with first index of output giving the time-step and the second the corresponding evolved states
""" ->
function sesolve(H::QuBase.AbstractQuArray, psi::QuBase.AbstractQuArray, tlist; solver=QuExpmV())
    time = collect(tlist)[2:end]
    evolved_state = Array(typeof(complex(psi)), length(tlist)-1)
    j = 1
    for (t, psi) in QuStateEvolution(H, psi, tlist, solver)
        evolved_state[j] = psi
        j = j + 1
    end
    return time, evolved_state
end

sesolve(SE::QuSchrodingerEq, psi::QuBase.AbstractQuVector, tlist; solver=QuExpmV()) = sesolve(SE.hamiltonian, psi, tlist; solver=solver)
sesolve(LVNE::QuLiouvillevonNeumannEq, rho0::QuBase.AbstractQuMatrix, tlist; solver=QuExpmV()) =  sesolve(LVNE.liouvillian, rho0, tlist; solver=solver)

function sesolve(H::QuBase.AbstractQuArray, psi::QuBase.AbstractQuArray, tlist, eops::Vector; solver=QuExpmV())
    expectation = zeros(Complex128, length(tlist)-1, length(eops))
    j = 1
    for (t,psi) in QuStateEvolution(H, psi, tlist, solver)
        for i=1:length(eops)
            expectation[j,i] = expectationvalue(psi, eops[i])
        end
        j = j + 1
    end
    return collect(tlist)[2:end], expectation
end

sesolve(SE::QuSchrodingerEq, psi::QuBase.AbstractQuVector, tlist, eops::Vector; solver=QuExpmV()) = sesolve(SE.hamiltonian, psi, tlist, eops; solver=solver)
sesolve(LVNE::QuLiouvillevonNeumannEq, rho0::QuBase.AbstractQuMatrix, tlist, eops::Vector; solver=QuExpmV()) = sesolve(LVNE.liouvillian, rho0, tlist, eops; solver=solver)

@doc """
Interface for `mesolve`[http://qutip.org/docs/3.1.0/apidoc/functions.html#module-qutip.mesolve] of QuTiP in QuDynamics

`mesolve` in QuDynamics, extended version.

### Arguments

Inputs :
* H/ME :: AbstractQuArray/QuLindbladMasterEq Types

  This parameter supports Hamiltonian of the system, Lindblad Master Equation
* psi :: AbstractQuArray

  Initial density matrix of the system
* tlist

  Time step array/range
* e_ops

  Operators whose expectation values are to computed in the evolved states
* solver

  Keyword for selecting the solver from the various solvers supported by QuDynamics

Output :
* Two Arrays, with first index of output giving the time-step and the second the corresponding evolved states
""" ->
function mesolve(H::QuBase.AbstractQuArray, rho0::QuBase.AbstractQuMatrix, tlist, c_ops::Vector; solver=QuExpmV())
    time = collect(tlist)[2:end]
    evolved_state = Array(typeof(complex(rho0)), length(tlist)-1)
    j = 1
    for (t, rho) in QuStateEvolution(H, c_ops, rho0, tlist, solver)
        evolved_state[j] = rho
        j = j + 1
    end
    return time, evolved_state
end

mesolve(ME::QuLindbladMasterEq, rho0::QuBase.AbstractQuMatrix, tlist; solver=QuExpmV()) = mesolve(ME.hamiltonian, rho0, tlist, ME.collapse_ops; solver=solver)

function mesolve(H::QuBase.AbstractQuArray, rho0::QuBase.AbstractQuMatrix, tlist, c_ops::Vector, eops::Vector; solver=QuExpmV())
    expectation = zeros(Complex128, length(tlist)-1, length(eops))
    j = 1
    for (t,rho) in QuStateEvolution(H, c_ops, rho0, tlist, solver)
        for i=1:length(eops)
            expectation[j,i] = expectationvalue(rho, eops[i])
        end
        j = j + 1
    end
    return collect(tlist)[2:end], expectation
end

mesolve(ME::QuLindbladMasterEq, rho0::QuBase.AbstractQuMatrix, tlist, eops::Vector; solver=QuExpmV()) = mesolve(ME.hamiltonian, rho0, tlist, ME.collapse_ops, eops; solver=solver)


@doc """
Interface for `mcsolve`[http://qutip.org/docs/3.1.0/apidoc/functions.html#module-qutip.mcsolve] of QuTiP in QuDynamics

`mcsolve` in QuDynamics, extended version.

### Arguments

Inputs :
* H/ME :: AbstractQuArray/QuLindbladMasterEq Types

  This parameter supports Hamiltonian of the system, Lindblad Master Equation
* psi :: AbstractQuArray

  Initial state vector of the system
* tlist

  Time step array/range
* e_ops

  Operators whose expectation values are to computed in the evolved states
* ntraj

  Keyword for setting up the number of trajectories.

Output :
* Two Arrays, with first index of output giving the time-step and the second the corresponding evolved states
""" ->
function mcsolve(H::QuBase.AbstractQuArray, psi0::QuBase.AbstractQuArray, tlist, c_ops::Vector; ntraj=1000)
    time = collect(tlist)[2:end]
    qumcwfen = QuMCWFEnsemble(complex(psi0), ntraj)
    rho = complex(psi0*psi0')
    rhos = Array(typeof(rho), length(tlist)-1)
    for i=1:length(tlist)-1
        rhos[i] = complex(zeros(rho))
    end
    for psi0 in qumcwfen
        j = 1
        for (t,psi) in QuStateEvolution(H, c_ops, psi0, tlist, QuMCWF())
            rhos[j] = rhos[j] + (psi*psi')/length(qumcwfen)/norm(psi)^2
            j = j + 1
        end
    end
    return time, rhos
end

mcsolve(ME::QuLindbladMasterEq, psi0::QuBase.AbstractQuArray, tlist; ntraj=1000) = mcsolve(ME.hamiltonian, psi0, tlist, ME.collapse_ops; ntraj=ntraj)

function mcsolve(H::QuBase.AbstractQuArray, psi0::QuBase.AbstractQuArray, tlist, c_ops::Vector, eops::Vector; ntraj=1000)
    time = collect(tlist)[2:end]
    qumcwfen = QuMCWFEnsemble(complex(psi0), ntraj)
    expectation = zeros(Complex128, length(tlist)-1, length(eops))
    for psi0 in qumcwfen
        j = 1
        for (t,psi) in QuStateEvolution(H, c_ops, psi0, tlist, QuMCWF())
            for i=1:length(eops)
                expectation[j,i] = expectation[j,i] + expectationvalue(psi, eops[i])/length(qumcwfen)/norm(psi)^2
            end
            j = j + 1
        end
    end
    return time, expectation
end

mcsolve(ME::QuLindbladMasterEq, psi0::QuBase.AbstractQuArray, tlist, eops::Vector; ntraj=1000) = mcsolve(ME.hamiltonian, psi0, tlist, ME.collapse_ops, eops; ntraj=ntraj)

# eops_helper function is used in the test suite. This has been included in this file
# as it can be used as a check for QuTiP being a separate module, though in the test
# file there is still `using QuDynamics.QuTiP`.
function eops_helper(eops, evolved_states)
    expectation = zeros(Complex128, length(evolved_states), length(eops))
    for j=1:length(evolved_states)
        for i = 1:length(eops)
            expectation[j,i] = trace(coeffs(evolved_states[j]*eops[i]))
        end
    end
    return expectation
end

export mesolve,
      sesolve,
      mcsolve
