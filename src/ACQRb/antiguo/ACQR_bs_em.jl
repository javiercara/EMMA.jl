function ACQRb_em_s(y,Ai,Ci,Qi,Ri,m1i,max_iter::Int,tol::Float64,txo::Bool)
	#
	# STATIONARY EM algorithm for model
	#
	# x_{t} = A*x_{t-1} + w_{t}
	# y_{t} = C*x_{t}   + v_{t}
	#
	# cov(w_{t},v_{t}) = [Q 0;0 R]
	# x1 -> N(m1,P1)
	#
	# javier.cara@upm.es, 2108-04
	#

	# data by rows
	y,ny,nt = byrow(y)

	# number of states
	nx = size(Ai,1)

	# initial values
	A = Ai
	C = Ci
	Q = Qi
	R = Ri
	m1 = m1i
	P1 = zeros(nx,nx)

	# log-likelihood values
	loglikv = zeros(max_iter)

	# Syy does not depend on the iterations
	Syy = zeros(ny,ny)
	for t in 2:nt # start in t=2 because x0=x11 instead of x0=x00
		Syy = Syy + y[:,t]*y[:,t]'
	end

	tol1 = 1.0
	iter = 1
	while (iter <= max_iter) && (tol1 > tol)
		tic()

		# E-step
		# ---------------------------------------------------------------------------------
		# Kalmanfilter
		(xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = ACQRb_kfilter_s(y,A,C,Q,R,m1)
		(xtN,PtN,Pt1tN) = ACQRb_ksmoother_s(A,xtt,Ptt,xtt1,Ptt1)

		loglikv[iter] = loglik
		if iter > 1
			tol1 = abs( (loglikv[iter] - loglikv[iter-1])/loglikv[iter-1] )
		end

		# initial values
		Sxx = zeros(nx,nx)
		Sxb = zeros(nx,nx)
		Syx = zeros(ny,nx)

		# matrices Sxx, Sx1x, Syx, Sx1x1
		for t in 2:nt
			Sxx = Sxx + xtN[:,t]*xtN[:,t]'
			Sxb = Sxb + xtN[:,t]*xtN[:,t-1]'
			Syx = Syx + y[:,t]*xtN[:,t]'
		end
		Sxx = Sxx + (nt-1)*PtN
		Sxb = Sxb + (nt-1)*Pt1tN
		Sbb = Sxx + xtN[:,1]*xtN[:,1]' - xtN[:,nt]*xtN[:,nt]'

		# M-step
		# -------------------------------------------------------------------------------------
		# Matrices m1 y P1
		m1 = xtN[:,1]
		P1 = PtN

		# Matrix A
    	A = Sxb/Sbb

		# Matrix Q
		M1 = Sxb*A'
		Q = Sxx - M1 - M1' + A*Sbb*A'
		Q = 1/nt*Q
		Q = (Q + Q')/2 # to make sure it's a symmetric matrix

		# Matrix C
		C = Syx/Sxx

		# Matrix R
		M1 = Syx*C'
		R = Syy - M1' - M1 + C*Sxx*C'
		R = 1/nt*R
		R = (R + R')/2 # to make sure it's a symmetric matrix

		etime = toq()
		if txo
			println( "Iter " * @sprintf("%3d",iter) * ",   @time = " * @sprintf("%5.2f",etime) * ",   logLik = " * @sprintf("%.6E",loglik) * ",   tol = ", @sprintf("%.2E",tol1) )
		end

		iter += 1

	end

	loglikv = loglikv[1:(iter-1)]

	# Akaike Information Criterion
	P = ny*nx + nx*nx + nx*(nx+1)/2 + ny*(ny+1)/2
	aic = -2*loglikv[end] + 2*P

	# output
	return A,C,Q,R,m1,P1,loglikv,aic

end
