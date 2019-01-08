nt = 1000
seed = 99
m = ACQR_simula(nt,seed)
y = m["y"]

############################### starting point
nx = 4
i = nx+1
Ai,Ci,Qi,Ri,Si = ACQRS_sub(y,nx,i)
m1i = Ci\y[:,1:1]
P1i = 0*Ai

#######################
max_iter=10
tol=1e-10
txo=false
print("Testing ACQRS_em_s: ")
A,C,Q,R,S,m1,P1,loglik,aic = ACQRS_em_s(y,Ai,Ci,Qi,Ri,Si,m1i,max_iter,tol,txo)
@test sum(A.^2) > 1e-6
println("OK")
