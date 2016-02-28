abstract QuExponential <: QuPropagatorMethod

@doc """
Exponential solver, using Expokit.expmv

Step Propagation using the exponential solver Expokit.expmv.

### Fields :

* options :: Dict

Dictionary to set the size of Krylov subspace and tolerance by using
keys as `:m` and `:tol`.
""" ->
immutable QuExpokit <: QuExponential
    options::Dict{Symbol, Any}
end

QuExpokit() = QuExpokit(Dict())

@doc """
Exponential solver, using ExpmV.expmv

Step Propagation using the exponential solver ExpmV.expmv.

### Fields :

* options :: Dict

Dictionary to set M, precision, shift, full_term by using
keys as `:M`, `:precision`, `:shift`, `:full_term`
""" ->
immutable QuExpmV <: QuExponential
    options::Dict{Symbol, Any}
end

QuExpmV() = QuExpmV(Dict())

function propagate(prob::QuExpokit, eq::QuEquation, t, current_t, current_qustate)
    dt = t - current_t
    dims = size(current_qustate)
    next_state = Expokit.expmv(dt, -im*coeffs(operator(eq, t)), coeffs(vec(current_qustate)), m = get(prob.options, :m, 30), tol = get(prob.options, :tol, 1e-7))
    CQST = QuBase.similar_type(current_qustate)
    return CQST(reshape(next_state, dims), bases(current_qustate))
end

function propagate(prob::QuExpmV, eq::QuEquation, t, current_t, current_qustate)
    dt = t - current_t
    dims = size(current_qustate)
    next_state = ExpmV.expmv(dt, -im*coeffs(operator(eq, t)), coeffs(vec(current_qustate)), M = get(prob.options, :M, []), prec = get(prob.options, :prec, "double"),
                            shift = get(prob.options, :shift, false), full_term = get(prob.options, :full_term, false))
    CQST = QuBase.similar_type(current_qustate)
    return CQST(reshape(next_state, dims), bases(current_qustate))
end

export QuExpokit,
      QuExpmV
