# to run tests, type in Julia: Pkg.test("emACQR")

#using EMMA
using Base.Test

include("../src/EMMA1.jl") # including modules

include("../src/ACQR/ACQR_test.jl")
include("../src/ABCDQR/ABCDQR_test.jl")
include("../src/modal/modal_test.jl")
