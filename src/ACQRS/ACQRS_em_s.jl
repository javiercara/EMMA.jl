#########################################################################################
function ACQRS_em_s(y,Ai,Ci,Qi,Ri,Si,m1i,max_iter::Int,tol::Float64,txo::Bool)
	#
	# STATIONARY EM algorithm
	#
	# estimate A, C, Q, R, x0, P0 using the EM algorithm for model
	# 
	# x_{t+1} = Ax_{t} + w_{t}
	# y_{t}   = Cx_{t} + v_{t}
	#
	# cov(w_{t},v_{t}) = [Q S;S' R]
	#
	# javier.cara@upm.es, 2018-07
	#
	
	# number of states and outputs
	nx = size(Ai,1)	
		
	# data by rows
	y,ny,nt = byrow(y)

	# initial values
	A = Ai
	C = Ci
	Q = Qi
	R = Ri
	S = Si
	m1 = m1i
	P1 = zeros(nx,nx)

	# log-likelihood values
	loglikv = zeros(max_iter)

	# Syy does not depend on the iterations
	Syy = zeros(ny,ny)
	for t in 1:nt 
		Syy = Syy + y[:,t]*y[:,t]'
	end

	tol1 = 1.0
	iter = 1
	while (iter <= max_iter) && (tol1 > tol)
		time1 = time()
	
		# E-step
		# ---------------------------------------------------------------------------------
		# Kalmanfilter
		(xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = ACQRS_kfilter_s(y,A,C,Q,R,S,m1)
		A1 = A - (S/R)*C
		(xtN,PtN,Pt1tN) = ACQR_ksmoother_s(A1,xtt,Ptt,xtt1,Ptt1)		
			
		loglikv[iter] = loglik
		if iter > 1
			tol1 = abs( (loglikv[iter] - loglikv[iter-1])/loglikv[iter-1] )
		end
		  
		# initial values
		Sxx = zeros(nx,nx)
		Sx1x = zeros(nx,nx)
		Syx = zeros(ny,nx)
		Sx1y = zeros(nx,ny)
		
		# matrices Sxx, Sx1x, Syx, Sx1x1, Sx1y
		for t in 1:nt 
			Sxx = Sxx + xtN[:,t]*xtN[:,t]'
			Sx1x = Sx1x + xtN[:,t+1]*xtN[:,t]'
			Syx = Syx + y[:,t]*xtN[:,t]'
			Sx1y = Sx1y + xtN[:,t+1]*y[:,t]'
		end
		Sxx = Sxx + nt*PtN
		Sx1x = Sx1x + nt*Pt1tN
		Sx1x1 = Sxx - xtN[:,1]*xtN[:,1]' + xtN[:,nt+1]*xtN[:,nt+1]'
				
		# M-step
		# -------------------------------------------------------------------------------------
		# Matrices x0 y P0
		m1 = xtN[:,1]		
		P1 = PtN
	
		# Matrix A
    	A = Sx1x/Sxx
    
		# Matrix Q
		M1 = Sx1x*A'
		Q = Sx1x1 - M1 - M1' + A*Sxx*A'
		Q = 1/nt*Q
		Q = (Q + Q')/2 # to make sure it's a symmetric matrix
			
    	# Matrix C
    	C = Syx/Sxx

		# Matrix R
		M1 = Syx*C'
		R = Syy - M1' - M1 + C*Sxx*C'
		R = 1/nt*R
		R = (R + R')/2 # to make sure it's a symmetric matrix
		
		# Matrix S
		S = Sx1y - A*Syx' - Sx1x*C' + A*Sxx*C'
		S = 1/nt*S
		    
		etime = time() - time1
		if txo
			println( "Iter " * @sprintf("%3d",iter) * ",   @time = " * @sprintf("%.2E",etime) * ",   logLik = " * @sprintf("%.6E",loglik) * ",   tol = ", @sprintf("%.2E",tol1) )
		end
		
		iter += 1
		  
	end
	
	loglikv = loglikv[1:(iter-1)]	
	
	# Akaike Information Criterion: C A Q R S
	P = ny*nx + nx*nx + nx*(nx+1)/2 + ny*(ny+1)/2 + nx*ny
	aic = -2*loglikv[end] + 2*P
	
	# output
	return A,C,Q,R,S,m1,P1,loglikv,aic

end
