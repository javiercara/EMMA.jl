#include("ACQRb.jl") # para tener tipos y funciones

include("../auxfun/byrow.jl")
include("../auxfun/dare.jl")
include("../auxfun/dlyap.jl")

include("../ACQR/ACQR_simula.jl")

include("../ACQRS/ACQRS_sub.jl")

include("ACQRb_kfilter_s.jl")
include("ACQRb_ksmoother_s.jl")
include("ACQRb_em_s.jl")
