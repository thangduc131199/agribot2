import rospy
import socket
from tractor_gps.msg import states_hms
from tractor_gps.srv import states_rtk,states_rtkResponse

HOST = '127.0.0.1'  # The server's hostname or IP address of rtkrcv output
PORT = 65431     # The port used by the server

def decode_data(data):
    msg=states_hms()
    str=data.decode()
    str_list=str.split()
    # lay ngay thang nam
    date=str_list[0].split('/') 
    year,month,day=int(date[0]),int(date[1]),int(date[2])
    # lay thoi gian
    time=str_list[1].split(':')
    hour,min,sec=int(time[0]),int(time[1]),float(time[2])
    lat,lon,h=float(str_list[2]),float(str_list[3]),float(str_list[4])
    Q,ns,age,ratio=int(str_list[5]),int(str_list[6]),float(str_list[13]),float(str_list[14])
    sdn,sde,sdu,sdne,sdeu,sdun=float(str_list[7]),float(str_list[8]),float(str_list[9]),float(str_list[10]),float(str_list[11]),float(str_list[13])
    msg.year,msg.month,msg.day,msg.hour,msg.min,msg.sec=year,month,day,hour,min,sec
    msg.data[0],msg.data[1],msg.data[2]=lat,lon,h
    msg.std[0],msg.std[1],msg.std[2],msg.std[3],msg.std[4],msg.std[5]=sdn,sde,sdu,sdne,sdeu,sdun
    msg.Q,msg.ns,msg.age,msg.ratio=Q,ns,age,ratio
    return msg

def publisher():
    rospy.init_node('rtkrcv_ros', anonymous=True)
    pub=rospy.Publisher('gps_rtk',states_hms,queue_size=10)
    rate=rospy.Rate(10)
    print("Ready to GPS RTK service")
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()
        conn, addr = s.accept()
        with conn:
            print('Connected by', addr)
            while not rospy.is_shutdown():
                data = conn.recv(1024)
                if not data:
                    break
                if data.decode()[0]!='%':
                    pub.publish(decode_data(data))
                    rate.sleep()


if __name__ == '__main__':
    try:
        publisher()
    except rospy.ROSInterruptException:
        pass
