@doc """
Euler Method

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
Input Parameters :
`options` : Dictionary to set the basis size with keyword NC.

For ex :
x = [:NC => basis_size]
QuKrylov(x)
Step Propagation using the Krylov subspace iterations.
""" ->
immutable QuKrylov <: QuPropagatorMethod
    options::Dict
end

QuKrylov() = QuKrylov(@compat Dict(:NC=>10))

@doc """
Propagates to the next time state
Input Parameters:
`prob`             :  Method to be used
`op`               :  Hamiltonian of the system
`t`                :  Time corresponding to the t_state
`current_t`        :  Current time
`current_qustate`  :  Quantum state corresponding to current time
""" ->
function propagate(prob::QuEuler, op, t, current_t, current_qustate)
    dt = t - current_t
    return (eye(op)-im*op*dt)*current_qustate
end

function propagate(prob::QuCrankNicolson, op, t, current_t, current_qustate)
    dt = t - current_t
    uni = eye(op)-im*op*dt/2
    return \(uni', uni*current_qustate)
end

function propagate(prob::QuKrylov, op, t, current_t, current_qustate)
    dt = t - current_t
    basis_size = get(prob.options,:NC, length(current_qustate))
    N = min(basis_size, length(current_qustate))
    v = Array(typeof(current_qustate),0)
    @compat sizehint!(v, N+1)
    push!(v,zeros(current_qustate))
    push!(v,current_qustate)
    alpha = Array(Complex{Float64},0)
    @compat sizehint!(alpha, N)
    beta = Array(Complex{Float64},0)
    @compat sizehint!(beta, N+1)
    push!(beta,0.)
    for i=2:N
        w = op*v[i]
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
    next_state = zeros(current_qustate)
    for j=1:N
        next_state = next_state + v[j]*U_k[j,1]
    end
    return next_state
end

export  QuEuler,
      QuCrankNicolson,
      QuKrylov
