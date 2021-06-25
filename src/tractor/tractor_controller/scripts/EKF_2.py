"""

Extended kalman filter (EKF) localization sample

author: Atsushi Sakai (@Atsushi_twi)

"""

import math

import matplotlib.pyplot as plt
import numpy as np
from numpy.core.records import array
from scipy.spatial.transform import Rotation as Rot


DT = 0.1  # time tick [s]
SIM_TIME = 50.0  # simulation time [s]

# Covariance for EKF simulation
Q = np.diag([
    np.deg2rad(10.0),  # variance of yaw_rate
    3.0  # variance of acc
])**2  # predict state covariance
R = np.diag([0.5,0.5])**2 # Observation x,y position covariance

#  Simulation parameter
INPUT_NOISE = np.diag([np.deg2rad(10.0),1])
GPS_NOISE = np.diag([0.2, 0.2])



show_animation = True


def calc_input():
    a = 0.0  # [m/s]
    yawrate = 0.1  # [rad/s]
    u = np.array([[yawrate],[a]])
    return u


def observation(xTrue, xd, u):
    xTrue = motion_model(xTrue, u)

    # add noise to gps x-y
    z = observation_model(xTrue) + GPS_NOISE @ np.random.randn(2, 1)

    # add noise to input
    ud = u + INPUT_NOISE @ np.random.randn(2, 1)

    xd = motion_model(xd, ud)

    return xTrue, z, xd, ud


def motion_model(x, u):
    F = np.array([[1.0, 0  , 0  , math.cos(x[2,0])*DT],
                  [0  , 1.0, 0  , math.sin(x[2,0])*DT],
                  [0  , 0  , 1.0, 0               ],
                  [0  , 0  , 0  , 1.0             ]])

    B = np.array([[0.0, 0.0],
                  [0.0, 0.0],
                  [DT , 0.0 ],
                  [0.0 , DT]])

    x = F @ x + B @ u

    return x


def observation_model(x):
    H = np.array([
        [1, 0, 0, 0],
        [0, 1, 0, 0],
    ])

    z = H @ x

    return z


def jacob_f_b(x, u):
    """
    Jacobian of Motion Model

    motion model
    x_{t+1} = x_t+v*dt*cos(yaw)
    y_{t+1} = y_t+v*dt*sin(yaw)
    yaw_{t+1} = yaw_t+omega*dt
    v_{t+1} = v{t}+a*dt
    so
    dx/dyaw = -v*dt*sin(yaw)
    dx/dv = dt*cos(yaw)
    dy/dyaw = v*dt*cos(yaw)
    dy/dv = dt*sin(yaw)
    """
    yaw = x[2, 0]
    v = x[3, 0]
    jF = np.array([
        [1.0, 0.0, -DT * v * math.sin(yaw), DT * math.cos(yaw)],
        [0.0, 1.0, DT * v * math.cos(yaw), DT * math.sin(yaw)],
        [0.0, 0.0, 1.0, 0.0],
        [0.0, 0.0, 0.0, 1.0]])
    jB=np.array([[0,0],[0,0],[DT,0],[0,DT]])

    return jF,jB


def jacob_h():
    # Jacobian of Observation Model
    jH = np.array([
        [1, 0, 0, 0],
        [0, 1, 0, 0],
    ])

    return jH


def ekf_estimation(xEst, PEst, z, u):
    #  Predict
    xPred = motion_model(xEst, u)
    jF,jB = jacob_f_b(xEst, u)
    PPred = jF @ PEst @ jF.T + jB @ Q @ jB.T

    #  Update
    jH = jacob_h()
    zPred = observation_model(xPred)
    y = z - zPred
    S = jH @ PPred @ jH.T + R
    K = PPred @ jH.T @ np.linalg.inv(S)
    xEst = xPred + K @ y
    PEst = (np.eye(len(xEst)) - K @ jH) @ PPred
    return xEst, PEst


def plot_covariance_ellipse(xEst, PEst):  # pragma: no cover
    Pxy = PEst[0:2, 0:2]
    eigval, eigvec = np.linalg.eig(Pxy)

    if eigval[0] >= eigval[1]:
        bigind = 0
        smallind = 1
    else:
        bigind = 1
        smallind = 0

    t = np.arange(0, 2 * math.pi + 0.1, 0.1)
    a = math.sqrt(eigval[bigind])
    b = math.sqrt(eigval[smallind])
    x = [a * math.cos(it) for it in t]
    y = [b * math.sin(it) for it in t]
    angle = math.atan2(eigvec[1, bigind], eigvec[0, bigind])
    rot = Rot.from_euler('z', angle).as_matrix()[0:2, 0:2]
    fx = rot @ (np.array([x, y]))
    px = np.array(fx[0, :] + xEst[0, 0]).flatten()
    py = np.array(fx[1, :] + xEst[1, 0]).flatten()
    plt.plot(px, py, "--r")


def main():
    print(__file__ + " start!!")

    time = 0.0

    # State Vector [x y yaw v]'
    xEst = np.zeros((4, 1))
    xTrue = np.zeros((4, 1))
    xTrue[3,0]=3 #m/s
    PEst = np.eye(4)

    xDR =xTrue # Dead reckoning

    # history
    hxEst = xEst
    hxTrue = xTrue
    hxDR = xTrue
    hz = np.zeros((2, 1))
    htime=time

    while SIM_TIME >= time:
        time += DT
        u = calc_input()

        xTrue, z, xDR, ud = observation(xTrue, xDR, u)

        xEst, PEst = ekf_estimation(xEst, PEst, z, ud)

        # store data history
        hxEst = np.hstack((hxEst, xEst))
        hxDR = np.hstack((hxDR, xDR))
        hxTrue = np.hstack((hxTrue, xTrue))
        hz = np.hstack((hz, z))
        htime=np.hstack((htime,time))

        if show_animation:
            plt.cla()
            # for stopping simulation with the esc key.
            plt.gcf().canvas.mpl_connect('key_release_event',
                    lambda event: [exit(0) if event.key == 'escape' else None])
            plt.plot(hz[0, :], hz[1, :], ".g")
            plt.plot(hxTrue[0, :].flatten(),
                     hxTrue[1, :].flatten(), "-b")
            plt.plot(hxDR[0, :].flatten(),
                     hxDR[1, :].flatten(), "-k")
            plt.plot(hxEst[0, :].flatten(),
                     hxEst[1, :].flatten(), "-r")
            plot_covariance_ellipse(xEst, PEst)
            plt.axis("equal")
            plt.grid(True)
            plt.pause(0.001)
    plt.cla()
    plt.figure(1)
    plt.plot(htime,hxEst[3,:],"-r")
    plt.plot(htime,hxTrue[3,:],"-b")
    plt.figure(2)
    plt.plot(htime,hxEst[2,:],"-r")
    
    plt.plot(htime,hxTrue[2,:],"-b")
    
    plt.show()

def main1():
    print(__file__ + " start!!")
    tractor=tractor_controller.TractorController()
    tractor.tractor(0.3,0.3)
    time = 0.0
    z1,z2,z3=tractor.state_from_sensor()
    u1,u2=tractor.velocity()
    
    # State Vector [x y yaw v]'
    xEst = np.zeros((4, 1))
    xEst[0]=z1
    xEst[1]=z2
    xEst[2]=z3
    xEst[3]=u1

    #xTrue = np.zeros((4, 1))
    PEst = np.eye(4)

    #xDR = np.zeros((4, 1))  # Dead reckoning

    # history
    hxEst = xEst
    #hxTrue = xTrue
    #hxDR = xTrue
    hz = np.zeros((2, 1))
    hz[0]=z1
    hz[1]=z2

    while SIM_TIME >= time:
        time += DT

        z1,z2,z3=tractor.state_from_sensor()
        z=np.array([[z1],[z2]])
        u1,u2=tractor.velocity()
        ud=np.array([[u1],[u2]])

        xEst, PEst = ekf_estimation(xEst, PEst, z, ud)

        # store data history
        hxEst = np.hstack((hxEst, xEst))
        #hxDR = np.hstack((hxDR, xDR))
        #hxTrue = np.hstack((hxTrue, xTrue))
        hz = np.hstack((hz, z))

        if show_animation:
            plt.cla()
            # for stopping simulation with the esc key.
            plt.gcf().canvas.mpl_connect('key_release_event',
                    lambda event: [exit(0) if event.key == 'escape' else None])
            plt.plot(hz[0, :], hz[1, :], ".g")
            #plt.plot(hxTrue[0, :].flatten(),
            #         hxTrue[1, :].flatten(), "-b")
            #plt.plot(hxDR[0, :].flatten(),
            #        hxDR[1, :].flatten(), "-k")
            plt.plot(hxEst[0, :].flatten(),
                     hxEst[1, :].flatten(), "-r")
            plot_covariance_ellipse(xEst, PEst)
            plt.axis("equal")
            plt.grid(True)
            plt.pause(0.001)
    tractor.tractor()

if __name__ == '__main__':
    main()