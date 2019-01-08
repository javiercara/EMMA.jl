print("Testing modalparami: ")

m = simula01()
A = m["A"]
B = m["B"]
C = m["C"]
dt = m["dt"]
wm = m["wm"]
zm = m["zm"]
Vm = m["Vm"]
mm = m["mm"]
dofu = [1,2]
wm1,zm1,Vm1,mm1 = modalparami(A,B,C,dt,dofu)

@test sum(abs.(wm-wm1)) < 0.1
@test sum(abs.(zm-zm1)) < 0.1
@test sum(abs.(Vm-Vm1)) < 0.1
@test sum(abs.(mm-mm1)) < 0.1
println("OK")
