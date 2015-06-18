abstract QuExpo <: QuPropagatorMethod

const type_to_method_expo = @compat Dict{Any, Any}(:QuExpm_Expo => Expokit.expmv, :QuExpm_ExpmV => ExpmV.expmv)

for key in keys(type_to_method_expo)
    @eval begin
        immutable $key <: QuExpo
            options::Dict{Symbol, Any}
        end
        $key() = $key(Dict())
    end
end

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
