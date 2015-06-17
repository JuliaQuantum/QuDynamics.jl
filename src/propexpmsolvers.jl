using ExpmV
using Expokit

immutable QuExpm_Expo <: QuPropagatorMethod
    options::Dict
end

QuExpm_Expo() = QuExpm_Expo(Dict())

function propagate(prob::QuExpm_Expo, op, t, current_t, current_qustate)
    dt = t - current_t
    next_state = Expokit.expmv(dt, -im*coeffs(op), coeffs(current_qustate))
    return QuArray(next_state)
end

immutable QuExpm_ExpmV <: QuPropagatorMethod
    options::Dict
end

QuExpm_ExpmV() = QuExpm_ExpmV(Dict())

function propagate(prob::QuExpm_ExpmV, op, t, current_t, current_qustate)
    dt = t - current_t
    next_state = ExpmV.expmv(dt, -im*coeffs(op), coeffs(current_qustate))
    return QuArray(next_state)
end

export QuExpm_Expo,
      QuExpm_ExpmV
