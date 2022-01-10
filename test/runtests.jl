using Point2DTools
using Test

# Computational Geometry, Third Edition, P.243 - not in order
const hull1 = Point2D[(0.1, 0.35), (0.13, 0.22), (0.07, 0.15), (0.12, 0.3), (0.16,0.2)]
const hull1vx = Point2D[(0.07, 0.15), (0.1, 0.35), (0.16, 0.2), (0.07, 0.15)]

@testset "Point2DTools.jl" begin
    @test hull1[convex(hull1)] == hull1vx
end
