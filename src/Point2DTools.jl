module Point2DTools

using StaticArrays

export Point2D, convex, convexperm, centroid, bounds, scalefns

const Point2D = SVector{2}

Base.atan(p::Point2D) = atan(p.y, p.x)
Base.atan(p1::Point2D, p2::Point2D) = atan(p2-p1)

dtan(p::Point2D) = rad2deg(a)

"""
    convex(points)

Return the list of Point2D points which form the convex hull of the supplied points.
"""
convex(points) = points[convexperm(points)]

×(p1::Point2D, p2::Point2D) = p1.x * p2.y - p2.x * p1.y

direction(p1, p2, p3) = ×(p3-p1, p2-p1)

right(p1, p2, p3) = direction(p1, p2, p3) > 0
left(p1, p2, p3) = direction(p1, p2, p3) < 0
collinear(p1, p2, p3) = direction(p1, p2, p3) == 0 # is 0 too large ?
"""
    convexperm(points)


 Return the list of indexes of the Point2D points which form the convex hull of the supplied points.
"""
function convexperm(points)
    ips = sortperm(points)

    Lupper = [ips[1], ips[2]]
    
    for i in 3:length(ips)
        push!(Lupper, ips[i])
        while length(Lupper) > 2 && !right(points[Lupper[end-2:end]]...)
            Lupper[end-1] = Lupper[end]
            pop!(Lupper)
        end
    end
    Lower = [ips[end], ips[end-1]]
    for i in length(ips)-2:-1:1
        push!(Lower, ips[i])
        while length(Lower) > 2 && !right(points[Lower[end-2:end]]...)
            Lower[end-1] = Lower[end]
            pop!(Lower)
        end
    end
    vcat(Lupper, Lower[2:end])
end 

"""
    centroid(points)
Calculate the unweighted centre of the closed polygon defined by `points`. 
# Arguments
- `points` a Vector of points, assumed to include the "start" and "end" point twice, so points[1] is ignored
"""
centroid(points) = length(points) < 2 ? points[1] : sum(points[2:end]) / length(points[2:end])

"""
    bounds(points)
Return the [Minimum::Point2D, Maximum::Point2D] (so you can vcat with a list of lists)
# Arguments
- `points` Vector of points with .x and .y properties
# Examples
julia> b1 = bounds([Point2D(-10,0), Point2D(1,2), Point2D(2,1)])
2-element Vector{StaticArrays.SVector{2, Int64}}:
 [-10, 0]
 [2, 2]
julia> b2 = bounds([Point2D(0,0), Point2D(1,2), Point2D(2,11)])
2-element Vector{StaticArrays.SVector{2, Int64}}:
 [0, 0]
 [2, 11]
 julia> bounds(vcat(b1, b2))
 2-element Vector{StaticArrays.SVector{2, Int64}}:
  [-10, 0]
  [2, 11]
"""
function bounds(points)
    minx, miny, maxx, maxy = Inf, Inf, -Inf, -Inf
    for p in points
        if p[1] < minx
            minx = p[1]
        elseif p[1] > maxx
            maxx = p[1]
        end
        if p[2] < miny 
            miny = p[2]
        elseif p.y > maxy
            maxy = p[2]
        end
    end
    [Point2D(minx, miny), Point2D(maxx, maxy)]
end

"""
    scalefns(points, width, height)
    scalefns(min_max, width, height)
return functions to apply to fx and fy of the points or bounds to scale to specified `width` and `height` - preserving aspect
# Arguments
- `points` Vector of points with .x and .y properties
"""
scalefns(points, width, height) = scalefns(bounds(points)..., width, height)
function scalefns(minxy, maxxy, width, height)
    scale = min(width, height) / min(maxxy.x - minxy.x, maxxy.y - minxy.y)
    x -> scale * (x - minxy.x), y -> scale * (y - minxy.y)
end

###
end
