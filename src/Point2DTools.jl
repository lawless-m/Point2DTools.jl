module Point2DTools

using StaticArrays

export Point2D, convex, convexperm

const Point2D = SVector{2}

Base.atan(p::Point2D) = atan(p.y, p.x)
Base.atan(p1::Point2D, p2::Point2D) = atan(p2-p1)

convex(ps::Vector{Point2D}) = ps[convexperm(ps)]

function convexperm(ps::Vector{Point2D})
    ips = sortperm(ps)

    right(L, fn) =  fn(atan(ps[L[end-2]], ps[L[end-1]]), atan(ps[L[end-2]], ps[L[end]]))

    Lupper = [ips[1], ips[2]]
    
    for i in 3:length(ips)
        push!(Lupper, ips[i])
        while length(Lupper) > 2 && !right(Lupper, >)
            Lupper[end-1] = Lupper[end]
            pop!(Lupper)
        end
    end
    Lower = [ips[end], ips[end-1]]
    for i in length(ips)-2:-1:1
        push!(Lower, ips[i])
        while length(Lower) > 2 && !right(Lower, <)
            Lower[end-1] = Lower[end]
            pop!(Lower)
        end
    end
    vcat(Lupper, Lower[2:end]
end 



###
end
