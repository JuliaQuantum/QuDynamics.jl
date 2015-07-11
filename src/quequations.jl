abstract QuEquation

immutable QuSchrodingerEq{H<:QuBase.AbstractQuMatrix} <: QuEquation
    hamiltonian::H
    QuSchrodingerEq(hamiltonian) = new(hamiltonian)
end

QuSchrodingerEq{H<:QuBase.AbstractQuMatrix}(hamiltonian::H) = QuSchrodingerEq{H}(hamiltonian)

immutable QuLiouvillevonNeumannEq{H<:QuBase.AbstractQuMatrix} <: QuEquation
    liouvillian::H
    QuLiouvillevonNeumannEq(liouvillian) = new(liouvillian)
end

QuLiouvillevonNeumannEq{H<:QuBase.AbstractQuMatrix}(liouvillian::H) = QuLiouvillevonNeumannEq{H}(liouvillian)

function liouvillian_op(h::QuBase.AbstractQuMatrix)
    nb = size(coeffs(h), 1)
    SI = Array(Int,0)
    SJ = Array(Int,0)
    Lvals = Array(typeof(im*one(eltype(h))),0)
    for m=1:nb
        for n=1:nb
            for i=1:nb
                for j=1:nb
                    sm = (n-1)*nb + m
                    sj = (j-1)*nb + i
                    lv = zero(Complex128)
                    if j==n
                        lv = lv - im*h[m,i]
                    end
                    if i==m
                        lv = lv + im*h[j,n]
                    end
                    if real(lv)!=0 || imag(lv)!=0
                        push!(SI, sm)
                        push!(SJ, sj)
                        push!(Lvals, lv)
                    end
                end
            end
        end
    end
    return QuBase.similar_type(h)(sparse(SI, SJ, Lvals, nb*nb, nb*nb))
end

function liouvillian_tensor(h::QuBase.AbstractQuMatrix)
    return -im*(tensor(eye(h), h) - tensor(h',eye(h)))
end

function operator(qu_eq::QuLiouvillevonNeumannEq)
    return qu_eq.liouvillian
end

function operator(qu_eq::QuSchrodingerEq)
    return qu_eq.hamiltonian
end

export QuEquation,
      QuSchrodingerEq,
      QuLiouvillevonNeumannEq
