#!/usr/bin/env python3
import math as m 
import rospy
import module.geonav_conversions as gc
from std_msgs import msg
from std_msgs.msg import Float64
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from control_msgs.msg import JointControllerState
from sensor_msgs.msg import Imu,NavSatFix
from tf.transformations import quaternion_from_euler,euler_from_quaternion
from tractor_controller.msg import state_tractor



class TractorController:
    def __init__(self):
        self.x=0
        self.y=0
        self.v=0
        self.yaw=0
        self.W=0 # van toc goc omega
        self.yaw_imu=0
        self.steer_R=0
        self.steer_L=0
        self.long=None
        self.lat=None
        self.long_origin=None
        self.lat_origin=None
        self.gps_x=0
        self.gps_y=0
        self.ekf_x=0
        self.ekf_y=0
        self.ekf_yaw=0
        self.ekf_v=0
        rospy.init_node('tractor_control',anonymous=True)
        self.left_steer_joint=rospy.Publisher('/left_steer_joint/command',Float64,queue_size=10,latch=True)
        self.right_steer_joint=rospy.Publisher('/right_steer_joint/command',Float64,queue_size=10,latch=True)
        #self.left_steer_joint=rospy.Publisher('/left_steer_joint/pos_command',Float64,queue_size=10,latch=True)
        #self.right_steer_joint=rospy.Publisher('/right_steer_joint/pos_command',Float64,queue_size=10,latch=True)
        #self.vel_left_steer_joint=rospy.Publisher('/left_steer_joint/vel_command',Float64,queue_size=10,latch=True)
        #self.vel_right_steer_joint=rospy.Publisher('/right_steer_joint/vel_command',Float64,queue_size=10,latch=True)
        self.vel_tractor=rospy.Publisher('/cmd_vel',Twist,queue_size=10,latch=True)
        rospy.Subscriber('/right_steer_joint/state',JointControllerState,self.callback_steer_R)
        rospy.Subscriber('/left_steer_joint/state',JointControllerState,self.callback_steer_L)
        rospy.Subscriber('/odom',Odometry,self.callback_odom)
        #Dang ki topic /odometry/gps de lay du lieu GPS sau khi da quy doi longlat -> x,y
        #rospy.Subscriber('/gps/fix',NavSatFix,self.callback_gps)
        #Dang ki topic /imu/data_raw de lay di lieu tu cam bien imu
        #rospy.Subscriber('/imu/data_raw',Imu,self.callback_imu)
        rospy.Subscriber('/ekf_solution',state_tractor,self.callback_ekf_solution)
        self.rate=rospy.Rate(10)
        self.rate.sleep()
        
        #wheel_separation
        self.L=0.8
        #Khoang? cach' truc. truoc' va truc. sau banh' xe
        self.H=1.2
        self.vel_steer=0.3
        #self.vel_left_steer_joint.publish(self.vel_steer)
        #self.vel_right_steer_joint.publish(self.vel_steer)
    def callback_ekf_solution(self,msg):
        self.ekf_x=msg.x
        self.ekf_y=msg.y
        self.ekf_yaw=msg.yaw
        self.ekf_v=msg.v

    def callback_odom(self,msg):
        self.x=msg.pose.pose.position.x
        self.y=msg.pose.pose.position.y
        self.v=msg.twist.twist.linear.x
        orientation_q = msg.pose.pose.orientation
        list_q=[orientation_q.x,orientation_q.y,orientation_q.z,orientation_q.w]
        roll,pitch,yaw=euler_from_quaternion(list_q)
        self.yaw=yaw
    def callback_steer_R(self,msg):
        self.steer_R=msg.process_value
    def callback_steer_L(self,msg):
        self.steer_L=msg.process_value
    def callback_gps(self,msg):
        self.long=msg.longitude
        self.lat=msg.latitude
        self.longlat2xy()
    def callback_imu(self,msg):
        orientation_q = msg.orientation
        list_q=[orientation_q.x,orientation_q.y,orientation_q.z,orientation_q.w]
        roll,pitch,yaw=euler_from_quaternion(list_q)
        self.yaw_imu=yaw
        self.W=msg.angular_velocity.z

    def tractor(self,vel=0.0,ang=0.0):
        if ang>m.pi/4:
            ang=m.pi/4
        elif ang<-m.pi/4:
            ang=-m.pi/4
        if m.tan(ang)==0:
            alpha_L=0.0
            alpha_R=0.0
            omega=0.0
        else:
            h=self.H/m.tan(ang)
            alpha_L=m.atan(self.H/(h-self.L/2))
            alpha_R=m.atan(self.H/(h+self.L/2))
            omega=vel/h
        a=Twist()
        a.linear.x=vel
        a.linear.y=0.0
        a.linear.z=0.0
        a.angular.x=0.0
        a.angular.y=0.0
        a.angular.z=omega
        #for i in range(5):
        self.left_steer_joint.publish(alpha_L)
        self.right_steer_joint.publish(alpha_R)
        self.vel_tractor.publish(a)
        self.rate.sleep()
        info="\nLeft steering: "+str(alpha_L)+\
            "\nRigh steering: "+str(alpha_R)+\
            "\nVelocity: "+str(vel)+\
            "\nOmega: "+str(omega)
        rospy.loginfo(info)
        #self.rate.sleep()
    def config_tractor(self,H,L):
        self.H=H
        self.L=L
    #def set_vel_steer(self,vel):
    #    self.vel_steer=vel
    #    self.vel_left_steer_joint.publish(self.vel_steer)
    #    self.vel_right_steer_joint.publish(self.vel_steer)
    def state(self):
        return self.x,self.y,self.yaw
    def state_ang(self):
        if m.tan(self.steer_L)==0 or m.tan(self.steer_R)==0:
            ang=0
        else:
            h=self.H/m.tan(self.steer_L)/2.0+self.H/m.tan(self.steer_R)/2.0
            ang=m.atan(self.H/h) 
        return ang
    def state_from_sensor(self):
        return self.gps_x,self.gps_y,self.yaw_imu
    def velocity(self):
        return self.v,self.W
    def set_origin(self,lat=None,long=None):
        if lat==None or long==None:
            lat=self.lat
            long=self.long
        self.lat_origin=lat
        self.long_origin=long
    def longlat2xy(self):
        if self.long_origin==None or self.lat_origin==None:
            self.long_origin=self.long
            self.lat_origin=self.lat
        
        self.gps_x,self.gps_y=gc.ll2xy(self.lat,self.long,self.lat_origin,self.long_origin)
    def ekf_state(self):
        return self.ekf_x,self.ekf_y,self.ekf_yaw,self.ekf_v


    


if __name__=='__main__':
    try:
        a=TractorController()
        while not rospy.is_shutdown():
            a.tractor()
            a.rate.sleep()
    except rospy.ROSInterruptException:
        pass 


    




  

