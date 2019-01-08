__precompile__()

module ACQRb

mutable struct ACQR{T <: Real}
	A::Array{T,2}
	C::Array{T,2}
	Q::Array{T,2}
	R::Array{T,2}
end
###########################

include("../aux/byrow.jl")
include("../aux/dare.jl")
include("../aux/dlyap.jl")


export
	byrow, dare, dlyap

end # module
