abstract QuExpo <: QuPropagatorMethod

@doc """
Exponential solver, using Epokit.expmv
Input Parameters :
`options` : Dictionary to set the size of Krylov subspace and tolerance by using
            keys as `:m` and `:tol`.

Step Propagation using the exponential solver Expokit.expmv.
""" ->
immutable QuExpm_Expo <: QuExpo
    options::Dict{Symbol, Any}
end

QuExpm_Expo() = QuExpm_Expo(Dict())

@doc """
Exponential solver, using ExpmV.expmv
Input Parameters :
`options` : Dictionary to set M, precision, shift, full_term by using
            keys as `:M`, `:precision`, `:shift`, `:full_term`

Step Propagation using the exponential solver ExpmV.expmv.
""" ->
immutable QuExpm_ExpmV <: QuExpo
    options::Dict{Symbol, Any}
end

QuExpm_ExpmV() = QuExpm_ExpmV(Dict())

function propagate(prob::QuExpm_Expo, op, t, current_t, current_qustate)
    dt = t - current_t
    next_state = Expokit.expmv(dt, -im*coeffs(op), coeffs(current_qustate), m = get(prob.options, :m, 30), tol = get(prob.options, :tol, 1e-7))
    return QuArray(next_state)
end

function propagate(prob::QuExpm_ExpmV, op, t, current_t, current_qustate)
    dt = t - current_t
    next_state = ExpmV.expmv(dt, -im*coeffs(op), coeffs(current_qustate), M = get(prob.options, :M, []), prec = get(prob.options, :prec, "double"),
                              shift = get(prob.options, :shift, false), full_term = get(prob.options, :full_term, false))
    return QuArray(next_state)
end

export QuExpm_Expo,
      QuExpm_ExpmV
