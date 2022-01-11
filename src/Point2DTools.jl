module Point2DTools

using StaticArrays

export Point2D, convex, convexperm

const Point2D = SVector{2}


Base.atan(p::Point2D) = atan(p.y, p.x)
Base.atan(p1::Point2D, p2::Point2D) = atan(p2-p1)

dtan(p::Point2D) = rad2deg(a)

convex(ps) = ps[convexperm(ps)]

×(p1::Point2D, p2::Point2D) = p1.x * p2.y - p2.x * p1.y

direction(p1, p2, p3) = ×(p3-p1, p2-p1)

right(p1, p2, p3) = direction(p1, p2, p3) > 0
left(p1, p2, p3) = direction(p1, p2, p3) < 0
collinear(p1, p2, p3) = direction(p1, p2, p3) == 0 # is 0 too large ?

function convexperm(ps)
    ips = sortperm(ps)

    Lupper = [ips[1], ips[2]]
    
    for i in 3:length(ips)
        push!(Lupper, ips[i])
        while length(Lupper) > 2 && !right(ps[Lupper[end-2:end]]...)
            Lupper[end-1] = Lupper[end]
            pop!(Lupper)
        end
    end
    Lower = [ips[end], ips[end-1]]
    for i in length(ips)-2:-1:1
        push!(Lower, ips[i])
        while length(Lower) > 2 && !right(ps[Lower[end-2:end]]...)
            Lower[end-1] = Lower[end]
            pop!(Lower)
        end
    end
    vcat(Lupper, Lower[2:end])
end 


###
end
