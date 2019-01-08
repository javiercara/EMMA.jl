# testing programs
using Base.Test # para que funcionen los *_test.jl

include("ini.jl")

# testing
include("ACQRb_kfilter_test.jl")
include("ACQRb_em_test.jl")
