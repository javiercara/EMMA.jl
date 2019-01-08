print("Testing ABCDQR_simula: ")
###################################
nt = 1000
seed = 99
m = ABCDQR_simula(nt,seed)
y = m["y"]

@test sum(y.^2) > 1e-6
####################################
println("OK")
