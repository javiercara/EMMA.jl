print("Testing mac: ")

v1 = [-2im, 1-im]
v2 = [1, 2]
m = mac(v1,v2)

@test m > 0
println("OK")
