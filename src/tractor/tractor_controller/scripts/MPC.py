#!/usr/bin/env python3
"""

Path tracking simulation with iterative linear model predictive control for speed and steer control

author: Atsushi Sakai (@Atsushi_twi)

"""

import numpy as np
import math
import cvxpy
import matplotlib.pyplot as plt
import module.cubic_spline_planner as cubic_spline_planner
import module.Tractor_controller as Tractor_controller
import time as tm

NX = 3  # x = x, y, yaw
NU = 1  # a = [accel, steer]
T =  5  # horizon length
# mpc parameters
R = 1 # input cost matrix
Rd =  5 # input difference cost matrix
Q = np.diag([1.0,1.0,1])  # state cost matrix
Qf = Q  # state final matrix
GOAL_DIS = 0.5  # goal distance
STOP_SPEED = 0.5 / 3.6  # stop speed
MAX_TIME = 200.0  # max simulation time

# iterative paramter
MAX_ITER = 3  # Max iteration
DU_TH = 1  # iteration finish param

TARGET_SPEED = 1.0 # [m/s] target speed
N_IND_SEARCH = 10  # Search index number

DT = 0.5  # [s] time tick

# Vehicle parameters
LENGTH = 4.5  # [m]
WIDTH = 2.0  # [m]
BACKTOWHEEL = 1.0  # [m]
WHEEL_LEN = 0.3  # [m]
WHEEL_WIDTH = 0.2  # [m]
TREAD = 0.7  # [m]
WB = 2.5  # [m]
WB_= 1.2

MAX_STEER = math.radians(45.0)  # maximum steering angle [rad]
MAX_DSTEER = 0.3  # maximum steering speed [rad/s]
MAX_SPEED = 55.0 / 3.6  # maximum speed [m/s]
MIN_SPEED = -20.0 / 3.6  # minimum speed [m/s]
MAX_ACCEL = 1.0  # maximum accel [m/ss]

show_animation = True


class State:
    """
    vehicle state class
    """

    def __init__(self, x=0.0, y=0.0, yaw=0.0):
        self.x = x
        self.y = y
        self.yaw = yaw
        self.predelta = None


def pi_2_pi(angle):
    while(angle > math.pi):
        angle = angle - 2.0 * math.pi

    while(angle < -math.pi):
        angle = angle + 2.0 * math.pi

    return angle


def get_linear_model_matrix(v, phi, delta):

    A =np.zeros((NX, NX))
    A[0, 0] = 1.0
    A[1, 1] = 1.0
    A[2, 2] = 1.0
    A[0, 2] = - DT * v * math.sin(phi)
    A[1, 2] = DT * v * math.cos(phi)
    #A=A.reshape((3,3))


    B = np.zeros(NX)
    B[2] = DT * v / (WB_ * math.cos(delta) ** 2)
    #B=B.reshape((NX,1))

    C = np.zeros(NX)
    C[0] = DT * (v*math.cos(phi) + v * math.sin(phi) * phi)
    C[1] = DT * (v*math.sin(phi) - v * math.cos(phi) * phi)
    C[2] = (v*math.tan(delta)/WB_ - v * delta / (WB_ * math.cos(delta) ** 2))*DT
    #C=C.reshape((NX,1))
    return A, B, C


def plot_car(x, y, yaw, steer=0.0, cabcolor="-r", truckcolor="-k"):

    outline = np.matrix([[-BACKTOWHEEL, (LENGTH - BACKTOWHEEL), (LENGTH - BACKTOWHEEL), -BACKTOWHEEL, -BACKTOWHEEL],
                         [WIDTH / 2, WIDTH / 2, - WIDTH / 2, -WIDTH / 2, WIDTH / 2]])

    fr_wheel = np.matrix([[WHEEL_LEN, -WHEEL_LEN, -WHEEL_LEN, WHEEL_LEN, WHEEL_LEN],
                          [-WHEEL_WIDTH - TREAD, -WHEEL_WIDTH - TREAD, WHEEL_WIDTH - TREAD, WHEEL_WIDTH - TREAD, -WHEEL_WIDTH - TREAD]])

    rr_wheel = np.copy(fr_wheel)

    fl_wheel = np.copy(fr_wheel)
    fl_wheel[1, :] *= -1
    rl_wheel = np.copy(rr_wheel)
    rl_wheel[1, :] *= -1

    Rot1 = np.matrix([[math.cos(yaw), math.sin(yaw)],
                      [-math.sin(yaw), math.cos(yaw)]])
    Rot2 = np.matrix([[math.cos(steer), math.sin(steer)],
                      [-math.sin(steer), math.cos(steer)]])

    fr_wheel = (fr_wheel.T * Rot2).T
    fl_wheel = (fl_wheel.T * Rot2).T
    fr_wheel[0, :] += WB
    fl_wheel[0, :] += WB

    fr_wheel = (fr_wheel.T * Rot1).T
    fl_wheel = (fl_wheel.T * Rot1).T

    outline = (outline.T * Rot1).T
    rr_wheel = (rr_wheel.T * Rot1).T
    rl_wheel = (rl_wheel.T * Rot1).T

    outline[0, :] += x
    outline[1, :] += y
    fr_wheel[0, :] += x
    fr_wheel[1, :] += y
    rr_wheel[0, :] += x
    rr_wheel[1, :] += y
    fl_wheel[0, :] += x
    fl_wheel[1, :] += y
    rl_wheel[0, :] += x
    rl_wheel[1, :] += y

    plt.plot(np.array(outline[0, :]).flatten(),
             np.array(outline[1, :]).flatten(), truckcolor)
    plt.plot(np.array(fr_wheel[0, :]).flatten(),
             np.array(fr_wheel[1, :]).flatten(), truckcolor)
    plt.plot(np.array(rr_wheel[0, :]).flatten(),
             np.array(rr_wheel[1, :]).flatten(), truckcolor)
    plt.plot(np.array(fl_wheel[0, :]).flatten(),
             np.array(fl_wheel[1, :]).flatten(), truckcolor)
    plt.plot(np.array(rl_wheel[0, :]).flatten(),
             np.array(rl_wheel[1, :]).flatten(), truckcolor)
    plt.plot(x, y, "*")


def update_state(state,v,delta):

    # input check
    if delta >= MAX_STEER:
        delta = MAX_STEER
    elif delta <= -MAX_STEER:
        delta = -MAX_STEER

    state.x = state.x + v * math.cos(state.yaw) * DT
    state.y = state.y + v * math.sin(state.yaw) * DT
    state.yaw = state.yaw + v / WB_ * math.tan(delta) * DT

    return state


def get_nparray_from_matrix(x):
    return np.array(x).flatten()


def calc_nearest_index(state, cx, cy, cyaw, pind):

    dx = [state.x - icx for icx in cx[pind:(pind + N_IND_SEARCH)]]
    dy = [state.y - icy for icy in cy[pind:(pind + N_IND_SEARCH)]]

    d = [idx ** 2 + idy ** 2 for (idx, idy) in zip(dx, dy)]

    mind = min(d)

    ind = d.index(mind) + pind

    mind = math.sqrt(mind)

    dxl = cx[ind] - state.x
    dyl = cy[ind] - state.y

    angle = pi_2_pi(cyaw[ind] - math.atan2(dyl, dxl))
    if angle < 0:
        mind *= -1

    return ind, mind


def predict_motion(x0,v,od, xref):
    """ oa : list gia toc
        od: list goc lai """
    xbar = xref * 0.0
    for i in range(len(x0)):
        xbar[i, 0] = x0[i]

    state = State(x=x0[0], y=x0[1], yaw=x0[2])
    for (di, i) in zip(od, range(1, T + 1)):
        state = update_state(state,v,di)
        xbar[0, i] = state.x
        xbar[1, i] = state.y
        xbar[2, i] = state.yaw

    return xbar


def iterative_linear_mpc_control(xref, x0,v,dref, od,u_state):
    """
    MPC contorl with updating operational point iteraitvely
    """

    if od is None:
        od = [0.0] * T

    for i in range(MAX_ITER):
        xbar = predict_motion(x0, v, od, xref)# cac diem du doan
        pod = od[:]
        od, ox, oy, oyaw = linear_mpc_control(xref, xbar, x0, v, dref,u_state)
        du =sum(abs(od - pod))  # calc u change value
        if du <= DU_TH:
            break
    else:
        print("Iterative is max iter")

    return od, ox, oy, oyaw


def linear_mpc_control(xref, xbar, x0, v, dref,u_state):
    """
    linear mpc control

    xref: reference point
    xbar: operational point
    x0: initial state
    dref: reference steer angle
    """

    x = cvxpy.Variable((NX, T + 1))
    u = cvxpy.Variable(T)

    cost = 0.0
    constraints = []

    for t in range(T):
        cost += cvxpy.square(u[t])*R

        if t != 0:
            cost += cvxpy.quad_form(xref[:, t] - x[:, t], Q)

        A, B, C = get_linear_model_matrix(v,xbar[2,t],dref[0, t])
        constraints += [x[:, t + 1] == A@x[:, t] + B*u[t] + C]

        if t < (T - 1):
            cost += cvxpy.square(u[t + 1] - u[t])*Rd
            constraints += [cvxpy.abs(u[t + 1] - u[t])<= MAX_DSTEER * DT]
    cost += cvxpy.quad_form(xref[:, T] - x[:, T], Qf)

    constraints += [x[:, 0] == x0]
    constraints += [cvxpy.abs(u[0] - u_state)<= MAX_DSTEER * DT]
    #constraints += [cvxpy.minimum(cvxpy.abs(u[0]),cvxpy.abs(u_state))*cvxpy.abs(u[0] - u_state)<= MAX_DSTEER*DT]
    constraints += [cvxpy.abs(u) <= MAX_STEER]

    prob = cvxpy.Problem(cvxpy.Minimize(cost), constraints)
    prob.solve(solver=cvxpy.ECOS, verbose=False)

    if prob.status == cvxpy.OPTIMAL or prob.status == cvxpy.OPTIMAL_INACCURATE:
        ox = get_nparray_from_matrix(x.value[0, :])
        oy = get_nparray_from_matrix(x.value[1, :])
        oyaw = get_nparray_from_matrix(x.value[2, :])
        odelta = get_nparray_from_matrix(u.value[:])

    else:
        print("Error: Cannot solve mpc..")
        odelta, ox, oy, oyaw = None, None, None, None

    return odelta, ox, oy, oyaw


def calc_ref_trajectory(v,state, cx, cy, cyaw, ck, sp, dl, pind):
    xref = np.zeros((NX, T + 1))
    dref = np.zeros((1, T + 1))
    ncourse = len(cx)

    ind, _ = calc_nearest_index(state, cx, cy, cyaw, pind)

    if pind >= ind:
        ind = pind

    xref[0, 0] = cx[ind]
    xref[1, 0] = cy[ind]
    xref[2, 0] = cyaw[ind]
    dref[0, 0] = 0.0  # steer operational point should be 0

    travel = 0.0

    for i in range(T + 1):
        travel += abs(v) * DT
        dind = int(round(travel / dl))

        if (ind + dind) < ncourse:
            xref[0, i] = cx[ind + dind]
            xref[1, i] = cy[ind + dind]
            xref[2, i] = cyaw[ind + dind]
            dref[0, i] = 0.0
        else:
            xref[0, i] = cx[ncourse - 1]
            xref[1, i] = cy[ncourse - 1]
            xref[2, i] = cyaw[ncourse - 1]
            dref[0, i] = 0.0

    return xref, ind, dref


def check_goal(state, goal, tind, nind):

    # check goal
    dx = state.x - goal[0]
    dy = state.y - goal[1]
    d = math.sqrt(dx ** 2 + dy ** 2)

    if (d <= GOAL_DIS):
        isgoal = True
    else:
        isgoal = False

    if abs(tind - nind) >= 5:
        isgoal = False
    return isgoal


def do_simulation(cx, cy, cyaw, ck, sp, dl, initial_state,v):
    """
    Simulation

    cx: course x position list
    cy: course y position list
    cy: course yaw position list
    ck: course curvature list
    sp: speed profile
    dl: course tick [m]

    """

    goal = [cx[-1], cy[-1]]

    state = initial_state

    # initial yaw compensation
    if state.yaw - cyaw[0] >= math.pi:
        state.yaw -= math.pi * 2.0
    elif state.yaw - cyaw[0] <= -math.pi:
        state.yaw += math.pi * 2.0

    time = 0.0
    x = [state.x]
    y = [state.y]
    yaw = [state.yaw]
    t = [0.0]
    d = [0.0]
    target_ind, _ = calc_nearest_index(state, cx, cy, cyaw, 0)

    odelta = None
    u_state=0
    cyaw = smooth_yaw(cyaw)

    while MAX_TIME >= time:
        xref, target_ind, dref = calc_ref_trajectory(v, state, cx, cy, cyaw, ck, sp, dl, target_ind)

        x0 = [state.x, state.y, state.yaw]  # current state

        odelta, ox, oy, oyaw = iterative_linear_mpc_control(xref, x0, v, dref, odelta,u_state)

        if odelta is not None:
            di = odelta[0]

        state = update_state(state,v, di)
        time = time + DT
        u_state=di

        x.append(state.x)
        y.append(state.y)
        yaw.append(state.yaw)
        t.append(time)
        d.append(di)

        if check_goal(state, goal, target_ind, len(cx)):
            print("Goal")
            break

        if show_animation:
            plt.cla()
            if ox is not None:
                plt.plot(ox, oy, "xr", label="MPC")
            plt.plot(cx, cy, "-r", label="course")
            plt.plot(x, y, "ob", label="trajectory")
            plt.plot(xref[0, :], xref[1, :], "xk", label="xref")
            plt.plot(cx[target_ind], cy[target_ind], "xg", label="target")
            plot_car(state.x, state.y, state.yaw, steer=di)
            plt.axis("equal")
            plt.grid(True)
            plt.title("Time[s]:" + str(round(time, 2)) +
                      ", speed[km/h]:" + str(round(v * 3.6, 2)))
            plt.pause(0.0005)

    return t, x, y, yaw, d



def do_simulation_gazebo(cx, cy, cyaw, ck, sp, dl, initial_state,v):
    """
    Simulation

    cx: course x position list
    cy: course y position list
    cy: course yaw position list
    ck: course curvature list
    sp: speed profile
    dl: course tick [m]

    """
    
    goal = [cx[-1], cy[-1]]

    tractor_=Tractor_controller.TractorController()
    tm.sleep(0.5)
    x0,y0,yaw0 = tractor_.state()

    #state = State(x0,y0,yaw0)

    # ket qua tu bo loc

    x_ekf,y_ekf,yaw_ekf,v_ekf=tractor_.ekf_state()
    state = State(x_ekf,y_ekf,yaw_ekf)

    # initial yaw compensation
    if state.yaw - cyaw[0] >= math.pi:
        state.yaw -= math.pi * 2.0
    elif state.yaw - cyaw[0] <= -math.pi:
        state.yaw += math.pi * 2.0

    time = 0.0
    x = [state.x]
    y = [state.y]
    yaw = [state.yaw]
    t = [0.0]
    d = [0.0]
    
    dx=[0.0]
    dy=[0.0]
    hx_ekf=[x_ekf]
    hy_ekf=[y_ekf]
    hyaw_ekf=[yaw_ekf]
    hv_ekf=[v_ekf]
    odelta = None

    target_ind, _ = calc_nearest_index(state, cx, cy, cyaw, 0)

    u_state=tractor_.state_ang()
    cyaw = smooth_yaw(cyaw)

    while MAX_TIME >= time:
        xref, target_ind, dref = calc_ref_trajectory(v, state, cx, cy, cyaw, ck, sp, dl, target_ind)

        x0 = [state.x, state.y, state.yaw]  # current state
        t_pre=tm.perf_counter()
  
        odelta, ox, oy, oyaw = iterative_linear_mpc_control(xref, x0, v, dref, odelta,u_state)
        t_op=tm.perf_counter()-t_pre
        print("Time optimal:",t_op)
        if odelta is not None:
            di = odelta[0]
        
        tractor_.tractor(v,di)
        tm.sleep(DT-t_op*1.5)
        
        x0,y0,yaw0 = tractor_.state()
        x_ekf,y_ekf,yaw_ekf,v_ekf=tractor_.ekf_state()

        # lay tu odom
        #state = State(x0,y0,yaw0)
        # lay tu cam bien
        state = State(x_ekf,y_ekf,yaw_ekf)
        
       
        time = time + DT
        u_state=tractor_.state_ang()
        dx.append(state.x-xref[0,0])
        dy.append(state.y-xref[1,0])
        x.append(state.x)
        y.append(state.y)
        yaw.append(state.yaw)
        t.append(time)
        d.append(u_state)
        hx_ekf.append(x_ekf)
        hy_ekf.append(y_ekf)
        hyaw_ekf.append(yaw_ekf)
        hv_ekf.append(v_ekf)

        if check_goal(state, goal, target_ind, len(cx)):
            print("Goal")
            tractor_.tractor()
            break

        if show_animation:
            plt.cla()
            if ox is not None:
                plt.plot(ox, oy, "xr", label="MPC")
            plt.plot(cx, cy, "-r", label="course")
            plt.plot(x, y, "ob", label="trajectory")
            plt.plot(xref[0, :], xref[1, :], "xk", label="xref")
            plt.plot(cx[target_ind], cy[target_ind], "xg", label="target")
            plt.plot(hx_ekf,hy_ekf,"xb",label="ekf_pos")
            plot_car(state.x, state.y, state.yaw, steer=di)
            plt.axis("equal")
            plt.grid(True)
            plt.title("Time[s]:" + str(round(time, 2)) +
                      ", speed[km/h]:" + str(round(v * 3.6, 2)))
            plt.pause(0.0005)
    tractor_.tractor()

    return t, x, y, yaw, d, dx,dy



def calc_speed_profile(cx, cy, cyaw, target_speed):

    speed_profile = [target_speed] * len(cx)
    direction = 1.0  # forward

    # Set stop point
    for i in range(len(cx) - 1):
        dx = cx[i + 1] - cx[i]
        dy = cy[i + 1] - cy[i]

        move_direction = math.atan2(dy, dx)

        if dx != 0.0 and dy != 0.0:
            dangle = abs(pi_2_pi(move_direction - cyaw[i]))
            if dangle >= math.pi / 4.0:
                direction = -1.0
            else:
                direction = 1.0

        if direction != 1.0:
            speed_profile[i] = - target_speed
        else:
            speed_profile[i] = target_speed

    speed_profile[-1] = 0.0

    return speed_profile


def smooth_yaw(yaw):

    for i in range(len(yaw) - 1):
        dyaw = yaw[i + 1] - yaw[i]

        while dyaw >= math.pi / 2.0:
            yaw[i + 1] -= math.pi * 2.0
            dyaw = yaw[i + 1] - yaw[i]

        while dyaw <= -math.pi / 2.0:
            yaw[i + 1] += math.pi * 2.0
            dyaw = yaw[i + 1] - yaw[i]

    return yaw


def get_straight_course(dl):
    ax = [0.0, 5.0, 10.0, 20.0, 30.0, 40.0, 50.0]
    ay = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    cx, cy, cyaw, ck, s = cubic_spline_planner.calc_spline_course(
        ax, ay, ds=dl)

    return cx, cy, cyaw, ck


def get_straight_course2(dl):
    ax = [0.0, -10.0, -20.0, -40.0, -50.0, -60.0, -70.0]
    ay = [0.0, -1.0, 1.0, 0.0, -1.0, 1.0, 0.0]
    cx, cy, cyaw, ck, s = cubic_spline_planner.calc_spline_course(
        ax, ay, ds=dl)

    return cx, cy, cyaw, ck


def get_straight_course3(dl):
    ax = [0.0, 10.0, 20.0, 40.0, 50.0, 60.0, 70.0]
    ay = [0.0, -5.0, 5.0, 0.0, -5.0, 5.0, 0.0]
    cx, cy, cyaw, ck, s = cubic_spline_planner.calc_spline_course(ax, ay, ds=dl)

    cyaw = [i - math.pi for i in cyaw]

    return cx, cy, cyaw, ck


def get_forward_course(dl):
    ax = [0.0, 60.0, 125.0, 50.0, 75.0, 30.0, -10.0]
    ay = [0.0, 0.0, 50.0, 65.0, 30.0, 50.0, -20.0]
    cx, cy, cyaw, ck, s = cubic_spline_planner.calc_spline_course(ax, ay, ds=dl)

    return cx, cy, cyaw, ck


def get_switch_back_course(dl):
    ax = [0.0, 30.0, 6.0, 20.0, 35.0]
    ay = [0.0, 0.0, 20.0, 35.0, 20.0]
    cx, cy, cyaw, ck, s = cubic_spline_planner.calc_spline_course(ax, ay, ds=dl)
    ax = [35.0, 10.0, 0.0, 0.0]
    ay = [20.0, 30.0, 5.0, 0.0]
    cx2, cy2, cyaw2, ck2, s2 = cubic_spline_planner.calc_spline_course(ax, ay, ds=dl)
    cyaw2 = [i - math.pi for i in cyaw2]
    cx.extend(cx2)
    cy.extend(cy2)
    cyaw.extend(cyaw2)
    ck.extend(ck2)

    return cx, cy, cyaw, ck

def fillter_yaw(list_yaw):
    for i in range(len(list_yaw)):
        list_yaw[i]=list_yaw[i]-(int(list_yaw[i]/2.0/math.pi)-1)*2*math.pi-math.pi
    return list_yaw


def main():
    print(__file__ + " start!!")

    dl = 1.0  # course tick
    # cx, cy, cyaw, ck = get_straight_course(dl)
    # cx, cy, cyaw, ck = get_straight_course2(dl)
    cx, cy, cyaw, ck = get_straight_course3(dl)
    # cx, cy, cyaw, ck = get_forward_course(dl)
    # CX, cy, cyaw, ck = get_switch_back_course(dl)
    cyaw=fillter_yaw(cyaw)

    sp = calc_speed_profile(cx, cy, cyaw, TARGET_SPEED)

    initial_state = State(x=0, y=0, yaw=-0.5)

    t, x, y, yaw, d= do_simulation(cx, cy, cyaw, ck, sp, dl, initial_state,TARGET_SPEED)
    print(d[0:20])
    dd=[0.0]
    for i in range(len(d)-1):
        dd.append(np.abs(d[i+1]-d[i])/DT)

    if show_animation:
        plt.close("all")
        plt.subplots()
        plt.plot(cx, cy, "-r", label="spline")
        plt.plot(x, y, "-g", label="tracking")
        plt.grid(True)
        plt.axis("equal")
        plt.xlabel("x[m]")
        plt.ylabel("y[m]")
        plt.legend()


        plt.subplots()
        plt.plot(t, d, "-r", label="angle steer")
        plt.grid(True)
        plt.xlabel("Time [s]")
        plt.ylabel("[rad]")
        plt.title("Goc banh lai")
        plt.subplots()
        plt.plot(t, dd, "-b", label="vel steer")
        plt.grid(True)
        plt.xlabel("Time [s]")
        plt.ylabel("[rad/s]")
        plt.title("Van toc")


        plt.show()


def main3():
    print(__file__ + " start!!")

    dl = 1.0  # course tick
    # cx, cy, cyaw, ck = get_straight_course(dl)
    # cx, cy, cyaw, ck = get_straight_course2(dl)
    cx, cy, cyaw, ck = get_straight_course3(dl)
    # cx, cy, cyaw, ck = get_forward_course(dl)
    # CX, cy, cyaw, ck = get_switch_back_course(dl)
    cyaw=fillter_yaw(cyaw)

    sp = calc_speed_profile(cx, cy, cyaw, TARGET_SPEED)

    initial_state = State(x=0, y=0, yaw=-0.5)

    t, x, y, yaw, d,dx,dy= do_simulation_gazebo(cx, cy, cyaw, ck, sp, dl, initial_state,TARGET_SPEED)
    print(d[0:20])
    dd=[0.0]
    for i in range(len(d)-1):
        dd.append(np.abs(d[i+1]-d[i])/DT)

    if show_animation:
        plt.close("all")
        plt.subplots()
        plt.title("Quy dao mong muon va quy dao thuc te")
        plt.plot(cx, cy, "-r", label="mong muon")
        plt.plot(x, y, "-g", label="thuc te")
        plt.grid(True)
        plt.axis("equal")
        plt.xlabel("x[m]")
        plt.ylabel("y[m]")
        plt.legend()


        plt.subplots()
        plt.plot(t, d, "-r", label="angle steer")
        plt.grid(True)
        plt.xlabel("Time [s]")
        plt.ylabel("[rad]")

        plt.subplots()
        plt.plot(t, dd, "-b", label="vel steer")
        plt.grid(True)
        plt.xlabel("Time [s]")
        plt.ylabel("[rad/s]")
        

        plt.subplots()
        plt.plot(t[1:], dx[1:], "-b", label="x_error")
        plt.grid(True)
        plt.xlabel("Time [s]")
        plt.ylabel("m")
        
        plt.subplots()
        plt.plot(t[1:], dy[1:], "-b", label="y_error")
        plt.grid(True)
        plt.xlabel("Time [s]")
        plt.ylabel("m")
        plt.show()

def main2():
    print(__file__ + " start!!")

    dl = 1.0  # course tick
    cx, cy, cyaw, ck = get_straight_course3(dl)
    cyaw=fillter_yaw(cyaw)
    print(cyaw)
    #ahihi

if __name__ == '__main__':
    main3()
    #main2()
