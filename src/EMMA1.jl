# include the "exported" functions of the module
using Printf
using LinearAlgebra
using Statistics
using Test
using Random

# ACQR
include("ACQR/byrow.jl")
include("ACQR/dare.jl")
include("ACQR/dlyap.jl")
include("ACQR/simula01.jl")
include("ACQR/ACQR_simula.jl")
include("ACQR/ACQR_kfilter.jl")
include("ACQR/ACQR_kfilter_s.jl")
include("ACQR/ACQR_ksmoother.jl")
include("ACQR/ACQR_ksmoother_s.jl")
include("ACQR/ACQRS_sub.jl")
include("ACQR/ACQR_em.jl")
include("ACQR/ACQR_em_s.jl")
include("ACQR/ACQR_em1.jl")
include("ACQR/ACQR_em1_s.jl")
# ABCDQR
include("ABCDQR/ABCDQR_simula.jl")
include("ABCDQR/ABCDQR_kfilter.jl")
include("ABCDQR/ABCDQR_kfilter_s.jl")
include("ABCDQR/ABCDQR_em.jl")
include("ABCDQR/ABCDQR_em_s.jl")
include("ABCDQR/ABCDQR_em1.jl")
include("ABCDQR/ABCDQR_em1_s.jl")
# modal
include("modal/mac.jl")
include("modal/modalparam.jl")
include("modal/modalparami.jl")
# ACQRS
include("ACQRS/ACQRS_kfilter_s.jl")
include("ACQRS/ACQRS_em_s.jl")