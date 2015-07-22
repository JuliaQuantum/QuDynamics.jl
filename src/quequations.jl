abstract QuEquation

@doc """
Schrodinger Equation type

Fields :

`hamiltonian` : Hamiltonian of the system is the only field for the type.
""" ->
immutable QuSchrodingerEq{H<:QuBase.AbstractQuMatrix} <: QuEquation
    hamiltonian::H
    QuSchrodingerEq(hamiltonian) = new(hamiltonian)
end

@doc """
Schrodinger Equation method

Input Parameters :

`hamiltonian` : Hamiltonian of the system to construct `QuSchrodingerEq` type.
""" ->
QuSchrodingerEq{H<:QuBase.AbstractQuMatrix}(hamiltonian::H) = QuSchrodingerEq{H}(hamiltonian)

@doc """
Liouville von Neumann Equation type

Fields :

`liouvillian` : Liouvillian of the system is the only field for the type.
""" ->
immutable QuLiouvillevonNeumannEq{H<:QuBase.AbstractQuMatrix} <: QuEquation
    liouvillian::H
    QuLiouvillevonNeumannEq(liouvillian) = new(liouvillian)
end

@doc """
Liouville von Neumann Equation method

Input Parameters :

`liouvillian` : Liouvillian of the system to construct `QuLiouvillevonNeumannEq` type.
""" ->
QuLiouvillevonNeumannEq{H<:QuBase.AbstractQuMatrix}(liouvillian::H) = QuLiouvillevonNeumannEq{H}(liouvillian)

@doc """
Lindblad Master Equation type

Fields :

`lindblad`      : Lindblad operator of the system
`hamiltonain`   : Hamiltonian of the system
`collapse_ops`  : Collapse operators
""" ->
immutable QuLindbladMasterEq{L<:QuBase.AbstractQuMatrix, H<:QuBase.AbstractQuMatrix, V<:QuBase.AbstractQuMatrix} <: QuEquation
    lindblad::L
    hamiltonian::H
    collapse_ops::Vector{V}
    QuLindbladMasterEq(lindblad, hamiltonian, collapse_ops) = new(lindblad, hamiltonian, collapse_ops)
end

@doc """
Lindblad Master Equation method

Input Parameters :

`hamiltonian` : Hamiltonain of the system
`collapse_ops` : Collapse operators
""" ->
function QuLindbladMasterEq{H<:QuBase.AbstractQuMatrix, V<:QuBase.AbstractQuMatrix}(hamiltonian::H, collapse_ops::Vector{V})
    lop = lindblad_op(hamiltonian, collapse_ops)
    QuLindbladMasterEq{typeof(lop),H,V}(lop, hamiltonian, collapse_ops)
end

@doc """
Lindblad operator construct from the `Hamiltonian` and `collapse operators`

Input Parameters :

`hamiltonian` : Hamiltonain of the system
`collapse_ops` : Collapse operators
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

Input Parameters :

`hamiltonian` : Hamiltonain of the system
""" ->
liouvillian_op(hamiltonian::QuBase.AbstractQuMatrix) = lindblad_op(hamiltonian, [])

@doc """
An altenate version for liouvillian operator construct (might be depreciated)

Input Parameters :

`hamiltonian` :  Hamiltonain of the system
""" ->
function liouvillian_tensor(hamiltonian::QuBase.AbstractQuMatrix)
    return tensor(eye(hamiltonian), hamiltonian) - tensor(hamiltonian',eye(hamiltonian))
end

@doc """
Input Parameters : QuLiouvillevonNeumannEq type

Returns the `liouvillian` of the `QuLiouvillevonNeumannEq` type.
""" ->
function operator(qu_eq::QuLiouvillevonNeumannEq)
    return qu_eq.liouvillian
end

@doc """
Input Parameters : QuSchrodingerEq type

Returns the `hamiltonian` of the `QuSchrodingerEq` type.
""" ->
function operator(qu_eq::QuSchrodingerEq)
    return qu_eq.hamiltonian
end

@doc """
Input Parameters : QuLindbladMasterEq type

Returns the `lindblad operator` of the `QuLindbladMasterEq` type.
""" ->
function operator(qu_eq::QuLindbladMasterEq)
    return qu_eq.lindblad
end

export QuEquation,
      QuSchrodingerEq,
      QuLiouvillevonNeumannEq,
      QuLindbladMasterEq
