using Documenter
using Point2DTools
using Dates


makedocs(
    modules = [Point2DTools],
    sitename="Point2DTools.jl", 
    authors = "Matt Lawless",
    format = Documenter.HTML(),
)

deploydocs(
    repo = "github.com/lawless-m/Point2DTools.jl.git", 
    devbranch = "main",
    push_preview = true,
)
