abstract QuExponential <: QuPropagatorMethod

@doc """
Exponential solver, using Epokit.expmv
Input Parameters :
`options` : Dictionary to set the size of Krylov subspace and tolerance by using
            keys as `:m` and `:tol`.

Step Propagation using the exponential solver Expokit.expmv.
""" ->
immutable QuExpokit <: QuExponential
    options::Dict{Symbol, Any}
end

QuExpokit() = QuExpokit(Dict())

@doc """
Exponential solver, using ExpmV.expmv
Input Parameters :
`options` : Dictionary to set M, precision, shift, full_term by using
            keys as `:M`, `:precision`, `:shift`, `:full_term`

Step Propagation using the exponential solver ExpmV.expmv.
""" ->
immutable QuExpmV <: QuExponential
    options::Dict{Symbol, Any}
end

QuExpmV() = QuExpmV(Dict())

function propagate(prob::QuExpokit, op, t, current_t, current_qustate)
    dt = t - current_t
    next_state = Expokit.expmv(dt, -im*coeffs(op), coeffs(current_qustate), m = get(prob.options, :m, 30), tol = get(prob.options, :tol, 1e-7))
    return QuArray(next_state)
end

function propagate(prob::QuExpmV, op, t, current_t, current_qustate)
    dt = t - current_t
    next_state = ExpmV.expmv(dt, -im*coeffs(op), coeffs(current_qustate), M = get(prob.options, :M, []), prec = get(prob.options, :prec, "double"),
                              shift = get(prob.options, :shift, false), full_term = get(prob.options, :full_term, false))
    return QuArray(next_state)
end

export QuExpokit,
      QuExpmV
