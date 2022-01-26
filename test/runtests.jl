using Point2DTools
using Test

# Computational Geometry, Third Edition, P.243 - not in order
const hull1 = Point2D[(0.1, 0.35), (0.13, 0.22), (0.07, 0.15), (0.12, 0.3), (0.16,0.2)]
const hull1vx = Point2D[(0.07, 0.15), (0.1, 0.35), (0.16, 0.2), (0.07, 0.15)]

const rpoints = Point2D[[408, 22], [424, 65], [484, 416], [283, 161], [98, 358], [126, 288], [309, 56], [63, 410], [221, 8] ,[71, 378] ,[73, 138], [305, 105], [397, 475], [376, 212], [292, 304], [498, 303]]

@testset "Point2DTools.jl" begin
   @test hull1[convexperm(hull1)] == hull1vx
   @test convex(hull1) == hull1vx
   @test convexperm(rpoints) == ([8, 13, 3, 16, 2, 1, 9, 11, 8])
   @test bounds([Point2D(0,0), Point2D(1,2), Point2D(2,1)]) == [Point2D(0,0), Point2D(2,2)]
end
