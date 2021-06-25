#!/usr/bin/env python3

import rospy
import importlib
import module.geonav_conversions as gc
from tractor_controller.msg import state_tractor
from sensor_msgs.msg import Imu,NavSatFix
from tf.transformations import quaternion_from_euler,euler_from_quaternion
import numpy as np
import math
import matplotlib.pyplot as plt
importlib.reload(math)

rate_=5.0

DT=1/rate_

show_animation=False

# Covariance for EKF simulation
Q = np.diag([
    0.01,  # variance of location on x-axis
    0.01,  # variance of location on y-axis
    np.deg2rad(1.0),  # variance of yaw angle
    0.1  # variance of velocity
])**2  # predict state covariance
R = np.diag([0.5,0.5])**2 # Observation x,y position covariance, and yaw

x_gps=0
y_gps=0
yaw_imu=0
v=0
a_imu=0
W_imu=0
long_origin=-71
lat_origin=42
lat=0
long=0
sub_gps=False
sub_imu=False
def longlat2xy():
    global long_origin,lat_origin,long,lat,x_gps,y_gps

    if long_origin==None or lat_origin==None:
        long_origin=long
        lat_origin=lat
    
    x_gps,y_gps=gc.ll2xy(lat,long,lat_origin,long_origin)

def callback_gps(msg):
    global long,lat,sub_gps

    sub_gps=True
    long=msg.longitude
    lat=msg.latitude
    longlat2xy()
  


def callback_imu(msg):
    global yaw_imu,W_imu,a_imu,sub_imu

    sub_imu=True
    orientation_q = msg.orientation
    list_q=[orientation_q.x,orientation_q.y,orientation_q.z,orientation_q.w]
    roll,pitch,yaw=euler_from_quaternion(list_q)
    yaw_imu=yaw
    W_imu=msg.angular_velocity.z
    a_imu=msg.linear_acceleration.x



def motion_model(x, u):
    F = np.array([[1.0, 0  , 0  , math.cos(x[2,0])*DT],
                  [0  , 1.0, 0  , math.sin(x[2,0])*DT],
                  [0  , 0  , 1.0, 0               ],
                  [0  , 0  , 0  , 1.0             ]])

    B = np.array([[0.0, 0.0],
                  [0.0, 0.0],
                  [0.0, DT ],
                  [DT , 0.0]])

    x = F @ x + B @ u

    return x


def jacob_f(x, u):
    """
    Jacobian of Motion Model

    motion model
    x_{t+1} = x_t+v*dt*cos(yaw)
    y_{t+1} = y_t+v*dt*sin(yaw)
    yaw_{t+1} = yaw_t+omega*dt
    v_{t+1} = v{t}
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

    return jF

def jacob_h():
    # Jacobian of Observation Model
    jH = np.array([
        [1, 0, 0, 0],
        [0, 1, 0, 0],
    ])

    return jH

def observation_model(x):
    H = np.array([
        [1, 0, 0, 0],
        [0, 1, 0, 0],
    ])

    z = H @ x

    return z    

def ekf_estimation(xEst, PEst, z, u):
    #  Predict
    xPred = motion_model(xEst, u)
    jF = jacob_f(xEst, u)
    PPred = jF @ PEst @ jF.T + Q

    #  Update
    jH = jacob_h()
    zPred = observation_model(xPred)
    y = z - zPred
    S = jH @ PPred @ jH.T + R
    K = PPred @ jH.T @ np.linalg.inv(S)
    xEst = xPred + K @ y
    PEst = (np.eye(len(xEst)) - K @ jH) @ PPred
    return xEst, PEst

def observation():
    z=np.array([[x_gps],[y_gps]])
    ud=np.array([[a_imu],[W_imu]])
    return z,ud


def run_node():
    rospy.init_node("EKF_node",anonymous=True)
    #Dang ki topic /odometry/gps de lay du lieu GPS sau khi da quy doi longlat -> x,y
    rospy.Subscriber('/gps/fix',NavSatFix,callback_gps)
    #Dang ki topic /imu/data_raw de lay di lieu tu cam bien imu
    rospy.Subscriber('/imu/data_raw',Imu,callback_imu)
    pub=rospy.Publisher("ekf_solution",state_tractor,queue_size=10)
    rate=rospy.Rate(rate_)

    # khoi tao cho EKF


    while not (sub_imu and sub_gps):
        rate.sleep()
    xEst = np.zeros((4, 1))
    PEst = np.eye(4)
    hx_est=[xEst[0,0]]
    hy_est=[xEst[1,0]]
    hv_est=[xEst[3,0]]
    ht=[0]
    z,ud=observation()
    hz_0=[z[0,0]]
    hz_1=[z[1,0]]
    time=0
    while not rospy.is_shutdown():
        time=time+DT
        z,ud=observation()
        xEst, PEst = ekf_estimation(xEst, PEst, z, ud)
        msg=state_tractor()
        msg.x  =xEst[0,0]
        msg.y  =xEst[1,0]
        msg.yaw=xEst[2,0]
        msg.v  =xEst[3,0]
        pub.publish(msg)
        hx_est.append(xEst[0,0])
        hy_est.append(xEst[1,0])
        hv_est.append(xEst[3,0])
        hz_0.append(z[0,0])
        hz_1.append(z[1,0])
        ht.append(time)
        
        if show_animation:
            plt.cla()
            #plt.plot(hz_0,hz_1,"ob",label="GPS")
            #plt.plot(hx_est,hy_est,"-r",label="EKF")
            plt.grid(True)
            #plt.axis("equal")
            plt.plot(ht,hv_est,"-b")
            #plt.grid(True)
            plt.pause(0.0005)
            


       
        rate.sleep()

def run():
    print("HELLO")

if __name__=='__main__':
    try:
        run_node()
    except rospy.ROSInterruptException:
        pass



