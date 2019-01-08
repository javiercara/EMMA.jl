function ACQR_em1(y,nx::Int;max_iter::Int=100,tol::Float64=1e-6,txo::Bool=true)
	#=
	estimate A, C, Q, R, m1, P1 using the EM algorithm
	and the subspace algorithm for the starting point
	for model

	x_{t+1} = A*x_{t} + w_{t}
	y_{t}   = C*x_{t} + v_{t}

	cov(w_{t},v_{t}) = [Q 0;0 R]
	x1 -> N(m1,P1)

	javier.cara@upm.es, 2107-05

	=#

	# data as a matrix and by rows
	y,ny,nt = byrow(y)

	# starting values from the ssi algorithm
	i = nx+1
	Ai,Ci,Qi,Ri,Si = ACQRS_sub(y,nx,i)
	# x11 = C^{-1}(y_1 - v_1)
	m1i = Ci\y[:,1:1]
	P1i = zeros(nx,nx)

	# em
	A,C,Q,R,m1,P1,loglikv,aic = ACQR_em(y,Ai,Ci,Qi,Ri,m1i,P1i,max_iter,tol,txo)

	# output
	m = Dict("A"=>A,"C"=>C,"Q"=>Q,"R"=>R,"m1"=>m1,"P1"=>P1,
	"loglikv"=>loglikv[end],"aic"=>aic)
	return m

end
