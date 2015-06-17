abstract QuODESolvers <: QuPropagatorMethod

const type_to_method = @compat Dict{Any, Any}(:QuODE45 => ODE.ode45, :QuODE78 => ODE.ode78, :QuODE23s => ODE.ode23s)

for op in keys(type_to_method)
    text = type_to_method[op]
    @eval  begin
        @doc """
        ODE Method type $($(op))
        Input Parameters :
        `options` : Dictionary to set the relative tolerance and absolute tolerance by using
                    keys as `:reltol` and `:abstol`.

        Step Propagation using the $($(text)) implementation from `ODE.jl`.
        """ ->
        immutable $op <: QuODESolvers
            options::Dict{Symbol, Any}
        end
        $op() = $op(Dict())
    end
end

for (key,value) in type_to_method
    @eval  begin
        function propagate(prob::$key, op, t, current_t, current_qustate)
            next_state = $value((t,y)-> -im*coeffs(op)*y, coeffs(current_qustate), [current_t, t], points=:specified,
                                  reltol = get(prob.options, :reltol, 1.0e-5), abstol = get(prob.options, :abstol, 1.0e-8))[2][end]
            return QuArray(next_state)
        end
    end
end

export QuODE45,
      QuODE78,
      QuODE23s
