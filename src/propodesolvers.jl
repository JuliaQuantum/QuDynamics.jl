abstract QuODESolvers <: QuPropagatorMethod

const type_to_method_ode = @compat Dict{Any, Any}(:QuODE45 => ODE.ode45, :QuODE78 => ODE.ode78, :QuODE23s => ODE.ode23s)

for qu_ode_type in keys(type_to_method_ode)
    method_name = type_to_method_ode[qu_ode_type]
    @eval  begin
        @doc """
        ODE solver, using $($(qu_ode_type))

        Step Propagation using the ode solver $($(method_name)).

        ### Fields :

        * options :: Dict

        Dictionary to set the relative tolerance and absolute tolerance by using
        keys as `:reltol` and `:abstol`.
        """ ->
        immutable $qu_ode_type <: QuODESolvers
            options::Dict{Symbol, Any}
        end
        $qu_ode_type() = $qu_ode_type(Dict())
    end
end

for (qu_ode_type,ode_solver) in type_to_method_ode
    @eval begin
        function propagate(prob::$qu_ode_type, eq::QuEquation, t, current_t, current_qustate)
            op = operator(eq, t)
            dims = size(current_qustate)
            # Convert the current_qustate to complex as it might result in a Inexact Error. After complex is in QuBase.jl (PR #38)
            # we could just do a complex(vec(current_qustate)) avoiding the coeffs(coeffs(vec(current_qustate))).
            next_state = $ode_solver((t,y)-> -im*coeffs(op)*y, complex(coeffs(vec(current_qustate))), [current_t, t], points=:specified,
                                  reltol = get(prob.options, :reltol, 1.0e-5), abstol = get(prob.options, :abstol, 1.0e-8))[2][end]
            CQST = QuBase.similar_type(current_qustate)
            return CQST(reshape(next_state, dims), bases(current_qustate))
        end
    end
end

export QuODE45,
      QuODE78,
      QuODE23s
