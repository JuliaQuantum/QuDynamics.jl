@doc """
Euler method

Step Propagation using the Euler formula.
""" ->
immutable QuEuler <: QuPropagatorMethod
end

@doc """
Crank Nicolson Method

Step Propagation using the Crank Nicolson formula.
""" ->
immutable QuCrankNicolson <: QuPropagatorMethod
end

@doc """
Krylov subspace Method

Step Propagation using the Krylov subspace method.

### Fields :

* options :: Dict

  Dictionary to set the size of basis by using the key `:NC`.
""" ->
immutable QuKrylov <: QuPropagatorMethod
    options::Dict
end

QuKrylov() = QuKrylov(@compat Dict(:NC=>10))

@doc """
Propagate for different solver types.

Method used to propagate one time step using the solver.

### Arguments

Inputs :
* prob <: QuPropagatorMethod

  Solver type (Method to be used  -> QuEuler, QuCrankNicolson,
                       QuKrylov, QuODE45, QuODE78, QuODE23s,
                       QuExpmV, QuExpokit, QuMCWF)
* eq <: QuEquation

  Equation type
* t :: Float64

  Final time
* current_t :: Float64

  Current time
* current_qustate

  Quantum state corresponding to current time

Output :
* Same type as current_qustate.
""" ->
function propagate(prob::QuEuler, eq::QuEquation, t, current_t, current_qustate)
    dt = t - current_t
    dims = size(current_qustate)
    op = operator(eq, t)
    next_state = (eye(op)-im*op*dt)*vec(current_qustate)
    return reshape(next_state, dims)
end

function propagate(prob::QuCrankNicolson, eq::QuEquation, t, current_t, current_qustate)
    dt = t - current_t
    dims = size(current_qustate)
    op = operator(eq, t)
    uni = eye(op)-im*op*dt/2
    next_state = \(uni', uni*vec(current_qustate))
    return reshape(next_state, dims)
end

function propagate(prob::QuKrylov, eq::QuEquation, t, current_t, current_qustate)
    dt = t - current_t
    dims = size(current_qustate)
    cqs = vec(current_qustate)
    basis_size = get(prob.options,:NC, length(cqs))
    N = min(basis_size, length(cqs))
    v = Array(Any,0)
    @compat sizehint!(v, N+1)
    push!(v,zeros(Complex{Float64}, cqs))
    push!(v,cqs)
    println(v)
    alpha = Array(Complex{Float64},0)
    @compat sizehint!(alpha, N)
    println(alpha)
    beta = Array(Complex{Float64},0)
    @compat sizehint!(beta, N+1)
    op = operator(eq, t)
    push!(beta,0.)
    for i=2:N
        println(i)
        w = op*v[i]
        println(w)
        println("alpha",alpha)
        push!(alpha, w'*v[i])
        w = w-alpha[i-1]*v[i]-beta[i-1]*v[i-1]
        push!(beta, norm(w))
        push!(v, w/beta[i])
    end
    w = op*v[end]
    push!(alpha, w'*v[end])
    deleteat!(v,1)
    H_k = full(Tridiagonal(beta[2:end], alpha, beta[2:end]))
    U_k = expm(-im*dt*H_k)
    next_state = zeros(cqs)
    for j=1:N
        next_state = next_state + v[j]*U_k[j,1]
    end
    return reshape(next_state, dims)
end

export QuEuler,
     QuCrankNicolson,
     QuKrylov
