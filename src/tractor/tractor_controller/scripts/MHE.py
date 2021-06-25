import numpy as np
import cvxpy
import math as m
import matplotlib.pyplot as plt

def noise_value():
    x=[]
    y=[]
    for i in range(10):
        x.append(4*m.sin(0.4*i)+0.5*np.random.randn())
        y.append(4*m.sin(0.4*i))
    return x,y


def mhe(x_m,x_true):

    x_e=cvxpy.Variable(10)

    cost=0
    constrain=[]
    for i in range(10):
        cost+=cvxpy.square(x_e[i]-x_m[i])
        cost+=cvxpy.square(x_e[i]-x_true[i])
        if i!=9:
            cos_i=m.cos(0.4*i)
            constrain+=[x_e[i+1]==x_e[i]+1.6*cos_i]
    prob = cvxpy.Problem(cvxpy.Minimize(cost), constrain)
    prob.solve(solver=cvxpy.ECOS, verbose=False)

    if prob.status == cvxpy.OPTIMAL or prob.status == cvxpy.OPTIMAL_INACCURATE:
        x=x_e.value[:]
    else:
        print("Error: Cannot solve mpc..")
        x=None

    return x
def do_MHE():

    x_m,x_true=noise_value()
    x=mhe(x_m,x_true)
    #print(x)
    #x_m=np.array(x_m).flatten()
    t=np.linspace(0,9,10)
    #print(t)
    plt.figure(1)

    plt.plot(t,x_m,".r")
    plt.plot(t,x,"-b")
    plt.show()
if __name__=='__main__':
    do_MHE()



