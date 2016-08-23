# CF - Cache Flag, can be set to either `1` or `0`. `1` implies caching, `0` the otherwise.
# for a more clearer picture, look at the methods
# `operator(qu_eq::QuLindbladMasterEq{1})` and `operator(qu_eq::QuLindbladMasterEq{0})`
abstract QuEquation{CF}

@doc """
Schrodinger Equation type

### Fields :

* hamiltonian <:QuBase.AbstractQuMatrix

  Hamiltonian of the system is the only field for the type.
""" ->
immutable QuSchrodingerEq{H<:QuBase.AbstractQuMatrix} <: QuEquation{1}
    hamiltonian::H
    QuSchrodingerEq(hamiltonian) = new(hamiltonian)
end

@doc """
Schrodinger Equation method

### Arguments

Inputs :
* hamiltonian <:  QuBase.AbstractQuMatrix

  Hamiltonian of the system

Output :
* QuSchrodingerEq type construct.
""" ->
QuSchrodingerEq{H<:QuBase.AbstractQuMatrix}(hamiltonian::H) = QuSchrodingerEq{H}(hamiltonian)

@doc """
Liouville von Neumann Equation type

### Fields :

* liouvillian <: QuBase.AbstractQuMatrix

  Liouvillian of the system is the only field for the type.
""" ->
immutable QuLiouvillevonNeumannEq{H<:QuBase.AbstractQuMatrix} <: QuEquation{1}
    liouvillian::H
    QuLiouvillevonNeumannEq(liouvillian) = new(liouvillian)
end

@doc """
Liouville von Neumann Equation method

### Arguments

Inputs :
* Liouvillian <: QuBase.AbstractQuMatrix

  Liouvillian of the system

Output :
* QuLiouvillevonNeumannEq type construct.
""" ->
QuLiouvillevonNeumannEq{H<:QuBase.AbstractQuMatrix}(liouvillian::H) = QuLiouvillevonNeumannEq{H}(liouvillian)

@doc """
Lindblad Master Equation type

### Fields :

* lindblad <: QuBase.AbstractQuMatrix

  Lindblad operator of the system
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops <: Vector{QuBase.AbstractQuMatrix}

  Collapse operators
""" ->
# immutable QuLindbladMasterEq{CF, L<:@compat(Union{QuBase.AbstractQuMatrix, Nothing}), H<:QuBase.AbstractQuMatrix, V<:QuBase.AbstractQuMatrix} <: QuEquation{CF}
# (Use this for running the benchmarks on version < 0.4)
immutable QuLindbladMasterEq{CF, L<:@compat(Union{QuBase.AbstractQuMatrix, Void}), H<:QuBase.AbstractQuMatrix, V<:QuBase.AbstractQuMatrix} <: QuEquation{CF}
    lindblad::L
    hamiltonian::H
    collapse_ops::Vector{V}
    QuLindbladMasterEq(lindblad, hamiltonian, collapse_ops) = new(lindblad, hamiltonian, collapse_ops)
end

@doc """
Lindblad Master Equation method, cached version creates and stores
the lindblad operator construct.

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops :: Vector{QuBase.AbstractQuMatrix}

  Collapse operators

Output :
* QuLindbladMasterEq type construct.
""" ->
function QuLindbladMasterEq{H<:QuBase.AbstractQuMatrix, V<:QuBase.AbstractQuMatrix}(hamiltonian::H, collapse_ops::Vector{V})
    lop = lindblad_op(hamiltonian, collapse_ops)
    QuLindbladMasterEq{1,typeof(lop),H,V}(lop, hamiltonian, collapse_ops)
end

@doc """
Lindblad Master Equation method, uncache version. Used in construction
of `QuPropagator` w.r.t MCWF method, as lindblad operator construct is
not required for every tracjetory.

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops :: Vector{QuBase.AbstractQuMatrix}

  Collapse operators

Output :
* QuLindbladMasterEq type construct.
""" ->
# QuLindbladMasterEq{0,Nothing,H,V}(nothing, hamiltonian, collapse_ops) (Use this for running the benchmarks on version < 0.4)
function QuLindbladMasterEqUncached{H<:QuBase.AbstractQuMatrix, V<:QuBase.AbstractQuMatrix}(hamiltonian::H, collapse_ops::Vector{V})
    QuLindbladMasterEq{0,Void,H,V}(nothing, hamiltonian, collapse_ops)
end

@doc """
Lindblad operator construct from the `Hamiltonian` and `collapse operators`

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system
* collapse_ops :: Vector

  Collapse operators

Output :
* Lindblad operator.
""" ->
function lindblad_op(hamiltonian::QuBase.AbstractQuMatrix, collapse_ops::Vector)
    nb = size(coeffs(hamiltonian), 1)
    nlop = length(collapse_ops)
    heff = zeros(typeof(im*one(eltype(hamiltonian))), size(coeffs(hamiltonian)))
    for l=1:nlop
        heff = heff + 0.5*coeffs(collapse_ops[l])'*coeffs(collapse_ops[l])
    end
    SI = Array(Int,0)
    SJ = Array(Int,0)
    Lvals = Array(typeof(im*one(eltype(hamiltonian))),0)
    for m=1:nb
        for n=1:nb
            for i=1:nb
                for j=1:nb
                    sm = (n-1)*nb + m
                    sj = (j-1)*nb + i
                    lv = zero(eltype(Lvals))
                    for l=1:nlop
                        lv = lv + collapse_ops[l][m,i]*collapse_ops[l]'[j,n]
                    end
                    if j==n
                        lv = lv - im*hamiltonian[m,i] - heff[m,i]
                    end
                    if i==m
                        lv = lv + im*hamiltonian[j,n] - heff[j,n]
                    end
                    if real(lv)!=0 || imag(lv)!=0
                        push!(SI, sm)
                        push!(SJ, sj)
                        push!(Lvals, im*lv)
                    end
                end
            end
        end
    end
    return QuBase.similar_type(hamiltonian)(sparse(SI, SJ, Lvals, nb*nb, nb*nb))
end

@doc """
Liouvillian operator construct from the `Hamiltonian` and passing an empty array to `lindblad_op`

### Arguments

Inputs :
* hamiltonian <: QuBase.AbstractQuMatrix

  Hamiltonian of the system

Output :
* Liouvillian operator.
""" ->
liouvillian_op(hamiltonian::QuBase.AbstractQuMatrix) = lindblad_op(hamiltonian, [])

@doc """
Liouvillian of the QuLiouvillevonNeumannEq type.

### Arguments

Inputs :
* qu_eq :: QuLiouvillevonNeumannEq

  Liouville von Neumann Equation type
* t

  Time parameter to facilitate time dependent operations.

Output :
* Liouvillian of the system
""" ->
function operator(qu_eq::QuLiouvillevonNeumannEq, t=0)
    return qu_eq.liouvillian
end

@doc """
Hamiltonian of the QuSchrodingerEq type.

### Arguments

Inputs :
* qu_eq :: QuSchrodingerEq

  Schrodinger Equation type
* t

  Time parameter to facilitate time dependent operations.

Output :
* Hamiltonian of the system
""" ->
function operator(qu_eq::QuSchrodingerEq, t=0)
    return qu_eq.hamiltonian
end

@doc """
Lindblad operator of the QuLindbladMasterEq type, cached version.
To be used when `QuLindbladMasterEq` is in use.

### Arguments

Inputs :
* qu_eq :: QuLindbladMasterEq{1}

  Lindblad Master Equation type
* t

  Time parameter to facilitate time dependent operations.

Output :
* Lindblad operator of the system
""" ->
function operator(qu_eq::QuLindbladMasterEq{1}, t=0)
    return qu_eq.lindblad
end

@doc """
Lindblad operator of the QuLindbladMasterEq type, uncached version.
To be used in when `QuLindbladMasterEqUncached` is in use.

### Arguments

Inputs :
* qu_eq :: QuLindbladMasterEq{0}

  Lindblad Master Equation type
* t

  Time parameter to facilitate time dependent operations.

Output :
* Lindblad operator of the system
""" ->
function operator(qu_eq::QuLindbladMasterEq{0}, t=0)
    return lindblad_op(qu_eq.hamiltonian, qu_eq.collapse_ops)
end

@doc """
Effective hamiltonian calculated using the hamiltonian and collapse operators.

### Arguments

Inputs :
* lme :: QuLindbladMasterEq

Output
* Effective hamiltonian of the system
""" ->
function eff_hamiltonian(lme::QuLindbladMasterEq)
    heff = lme.hamiltonian
    for c_ops in lme.collapse_ops
       heff = heff - im*0.5*c_ops'*c_ops
    end
    return heff
end

export QuEquation,
      QuSchrodingerEq,
      QuLiouvillevonNeumannEq,
      QuLindbladMasterEq,
      QuLindbladMasterEqUncached
