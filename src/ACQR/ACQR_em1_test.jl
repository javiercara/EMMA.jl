nt = 1000
seed = 99
m = ACQR_simula(nt,seed)
y = m["y"]
nx = 4

#######################
print("Testing ACQR_em1: ")
mest = ACQR_em1(y,nx,max_iter=10,txo=false)
mest1 = ACQR_em1_s(y,nx,max_iter=10,txo=false)
@test sum(mest["A"].^2) > 1e-6
@test sum(mest1["A"].^2) > 1e-6
println("OK")
