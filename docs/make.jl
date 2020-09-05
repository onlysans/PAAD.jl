using Documenter, PAAD

# TODO: use Literate to process examples
# using Literate
# preprocess tutorial scripts

# make documents
makedocs(
    modules = [PAAD],
    clean = false,
    format = :html,
    sitename = "PAAD.jl",
    linkcheck = !("skiplinks" in ARGS),
    analytics = "UA-89508993-1",
    pages = [
        "Home" => "index.md",
    ],
    html_prettyurls = !("local" in ARGS),
    html_canonical = "https://ucalyptus-plus.github.io/PAAD.jl/latest/",
)

deploydocs(
    repo = "github.com/ucalyptus-plus/PAAD.jl.git",
    target = "build",
    julia = "1.0",
    osname = "osx",
    deps = nothing,
    make = nothing,
)
