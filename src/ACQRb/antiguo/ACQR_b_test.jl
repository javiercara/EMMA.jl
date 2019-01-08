# testing programs
using Base.Test # para que funcionen los *_test.jl

include("ini.jl")

# testing
include("ACQR_b_kfilter_test.jl")
include("ACQR_b_em_test.jl")
