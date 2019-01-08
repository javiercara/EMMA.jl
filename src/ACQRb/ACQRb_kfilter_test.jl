nt = 1000
seed = 99
m = ACQR_simula(nt,seed)

y = m["y"]
A = m["A"]
C = m["C"]
Q = m["Q"]
R = m["R"]
x0 = 0*A[:,1]
P0 = 0*A


#######################
print("Testing ACQR_bs_kfilter: ")
xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik = ACQRb_kfilter_s(y,A,C,Q,R,x0)
@test sum(xtt.^2) > 1e-6
println("OK")

print("Testing ACQR_bs_ksmoother: ")
xtN,PtN,Pt1tN = ACQRb_ksmoother_s(A,xtt,Ptt,xtt1,Ptt1)
@test sum(xtN.^2) > 1e-6
println("OK")
