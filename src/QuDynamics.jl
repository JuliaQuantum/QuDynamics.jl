module QuDynamics
    using QuBase
    using Compat
    VERSION < v"0.4-" && using Docile
    include("propagators.jl")
end
