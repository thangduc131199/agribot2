from cvxpy.interface.matrix_utilities import DEFAULT_SPARSE_INTF
import numpy as np
import math as m
import matplotlib.pyplot as plt
import cvxpy




NX=4
NU=2
DT=0.1
T=5
H=np.zeros((2,4))
H[0,0]=1
H[1,1]=1
DU_TH=0.25
INPUT_NOISE = np.diag([np.deg2rad(30.0),0.2])**2
GPS_NOISE = np.diag([0.5, 0.5])**2 
SIM_TIME=30

Q=np.eye(NX)
P=np.eye(2)*0.2

show_animation=True
def calc_input():
    v = 1  # [m/s]
    yawrate = 0.1 # [rad/s]
    u = np.array([[yawrate],[v]])
    return u

def observation(x_True,u):
    x_True=motion_model(x_True,u)

    z=observation_model(x_True) + GPS_NOISE@np.random.randn(2,1)

    ud = u + INPUT_NOISE @ np.random.randn(2, 1)


    return x_True,z,ud

def motion_model(x, u):
    F = np.array([[1.0, 0, 0, 0],
                  [0, 1.0, 0, 0],
                  [0, 0, 1.0, 0],
                  [0, 0, 0, 0]])

    B = np.array([[0,DT * m.cos(x[2])],
                  [0,DT * m.sin(x[2])],
                  [DT, 0],
                  [0.0, 1.0]])

    x = F @ x + B @ u
    return x


def observation_model(x):
    H = np.array([
        [1, 0, 0, 0],
        [0, 1, 0, 0]
    ])

    z = H @ x

    return z


def get_linear_model_matrix(v,phi):
    A=np.eye(NX)
    A[0,2]=-v*m.sin(phi)*DT
    A[1,2]=v*m.cos(phi)*DT
    A[3,3]=0

    B=np.zeros((NX,NU))
    B[0,1]=DT*m.cos(phi)
    B[1,1]=DT*m.sin(phi)
    B[2,0]=DT
    B[3,1]=1

    C=np.zeros(NX)
    C[0]=v*m.sin(phi)*phi*DT
    C[1]=-v*m.cos(phi)*phi*DT

    return A,B,C

def pi_2_pi(angle):
    while(angle > m.pi):
        angle = angle - 2.0 * m.pi

    while(angle < -m.pi):
        angle = angle + 2.0 * m.pi

    return angle

def get_nparray_from_matrix(x):
    return np.array(x).flatten()

def MHE(x_pre,y,u):

    x_est=cvxpy.Variable((NX,T))

    cost=0
    constraints=[]

    for t in range(T):
        cost+=cvxpy.quad_form(y[:,t]-H@x_est[:,t],P)
        cost+=cvxpy.quad_form(x_est[:,t]-x_pre[:,t],Q)
        A,B,C=get_linear_model_matrix(u[1,t],x_pre[2,t])
        if t!=T-1:
            constraints+=[x_est[:,t+1]==A@x_est[:,t]+B@u[:,t]+C]
    
    prob = cvxpy.Problem(cvxpy.Minimize(cost), constraints)
    prob.solve(solver=cvxpy.ECOS, verbose=False)

    if prob.status == cvxpy.OPTIMAL or prob.status == cvxpy.OPTIMAL_INACCURATE:
        return x_est.value

    else:
        print("Error: Cannot solve mpc..")
    return None

def update_horizon(x_pre,x_est,u):
    for i in range(T-1):
        x_pre[:,i]=x_est[:,i+1]
    
    x_pre[:,T-1]=motion_model(x_pre[:,T-2],u)
    return x_pre
def update_observation(z_,u_,z,u):
    for i in range(T-1):
        z_[:,i]=z_[:,i+1]
        u_[:,i]=u_[:,i+1]
    
    z_[:,T-1]=z[:,0]
    u_[:,T-1]=u[:,0]

    return z_,u_

def iterative_MHE(x_pre,y,u):
    for i in range(10):
        pod=x_pre[2:,:]
        x_est=MHE(x_pre,y,u)
        od=x_est[2:,:]
        x_pre=x_est
        du=sum(abs(pod[0,:]-od[0,:])) + sum(abs(pod[1,:]-od[1,:]))
        print(du)
        if du<= DU_TH :
            break
    else:
        print("Iterative is max iter")
    return x_est

def do_MHE():

    y_=np.zeros((2,T))
    u_=np.zeros((NU,T))
    i_=0
    x_pre=np.zeros((NX,T))
    #for i in range(T):
     #   x_pre[3,i]=5
    

    time=0
    x_True=np.zeros((4,1))
    #x_True[3,0]=5 #v=0.5 m/s
    hx_true=x_True
    hz=None
    hx=None
    init=False
    init_1=True
    htime=0
    while SIM_TIME>time:

        u=calc_input()
        if init==True:
            x_pre=update_horizon(x_pre,x_est,u_[:,T-1])
            x_True,z,ud=observation(x_True,u)
            hx_true=np.hstack((hx_true,x_True))
            hz=np.hstack((hz,z))
            y_,u_=update_observation(y_,u_,z,ud)
            time+=DT
            htime=np.hstack((htime,time))

        while time<DT*T:
            x_True,z,ud=observation(x_True,u)
            hx_true=np.hstack((hx_true,x_True))
            y_[:,i_]=z[:,0]
            u_[:,i_]=ud[:,0]
            i_+=1
            time+=DT
            htime=np.hstack((htime,time))
            init=True
        
        x_est=iterative_MHE(x_pre,y_,u_)
        x_est_=x_est[:,T-1]
        x_est_=np.reshape(x_est_,(4,1))
        if init_1 :
            hx=x_est
            hz=y_
            init_1=False
        else:
            hx=np.hstack((hx,x_est_))
        if show_animation:
            

            # for stopping simulation with the esc key.
            plt.gcf().canvas.mpl_connect('key_release_event',lambda event: [exit(0) if event.key == 'escape' else None])
            plt.plot(hx[0,:].flatten(),hx[1,:].flatten(),"-r")
            plt.plot(hz[0,:].flatten(),hz[1,:].flatten(),".g")
            plt.plot(hx_true[0,:].flatten(),hx_true[1,:].flatten(),"-b")
            plt.axis("equal")
            plt.grid(True)
            plt.pause(0.001)
    plt.cla()
    plt.plot(htime[0:300],hx[3,0:300],"-r")
    plt.grid(True)
    plt.show()
    #print(hx)

if __name__=='__main__':
    do_MHE()


