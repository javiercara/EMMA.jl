nt = 1000
seed = 99
m = ABCDQR_simula(nt,seed)
y = m["y"]
u = m["u"]
nx = 4

#######################
print("Testing ABCDQR_em1: ")
mest = ABCDQR_em1(y,u,nx,max_iter=10,txo=false)
mest1 = ABCDQR_em1_s(y,u,nx,max_iter=10,txo=false)
@test sum(mest["A"].^2) > 1e-6
@test sum(mest1["A"].^2) > 1e-6
println("OK")
