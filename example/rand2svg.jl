using Point2DTools
using SVG

function conv_svg(fname, points, upper, lower)
    cs = map(p->Circle(p.x, p.y, 2), points)
    hull = [Polyline(points[upper]; style=Style(;strokecolor="green")), Polyline(points[lower]; style=Style(;strokecolor="red"))]
    write("$fname.html", SVG.Svg(vcat(cs, hull)), 500, 500; inhtml = true)
end

function rand_svg()
    points(n=16) = 500 * rand(Point2D, n)
    ps = collect(points())
    conv_svg("rand", ps, convexperm(ps)...)
end

function rpoints_svg()
    rpoints = Point2D[[408, 22], [424, 65], [484, 416], [283, 161], [98, 358], [126, 288], [309, 56], [63, 410], [221, 8] ,[71, 378] ,[73, 138], [305, 105], [397, 475], [376, 212], [292, 304], [498, 303]])
    conv_svg("rpoints", rpoints, convexperm(rpoints)...)
end

