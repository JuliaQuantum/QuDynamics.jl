module QuDynamics
    using QuBase
    using Compat
    using ODE
    using Expokit
    using ExpmV
    VERSION < v"0.4-" && using Docile
    include("quequations.jl")
    include("propmachinery.jl")
    include("propstepsolvers.jl")
    include("propodesolvers.jl")
    include("propexpmsolvers.jl")
end
