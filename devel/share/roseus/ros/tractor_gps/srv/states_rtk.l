;; Auto-generated. Do not edit!


(when (boundp 'tractor_gps::states_rtk)
  (if (not (find-package "TRACTOR_GPS"))
    (make-package "TRACTOR_GPS"))
  (shadow 'states_rtk (find-package "TRACTOR_GPS")))
(unless (find-package "TRACTOR_GPS::STATES_RTK")
  (make-package "TRACTOR_GPS::STATES_RTK"))
(unless (find-package "TRACTOR_GPS::STATES_RTKREQUEST")
  (make-package "TRACTOR_GPS::STATES_RTKREQUEST"))
(unless (find-package "TRACTOR_GPS::STATES_RTKRESPONSE")
  (make-package "TRACTOR_GPS::STATES_RTKRESPONSE"))

(in-package "ROS")





(defclass tractor_gps::states_rtkRequest
  :super ros::object
  :slots ())

(defmethod tractor_gps::states_rtkRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass tractor_gps::states_rtkResponse
  :super ros::object
  :slots (_data ))

(defmethod tractor_gps::states_rtkResponse
  (:init
   (&key
    ((:data __data) (instance tractor_gps::states_hms :init))
    )
   (send-super :init)
   (setq _data __data)
   self)
  (:data
   (&rest __data)
   (if (keywordp (car __data))
       (send* _data __data)
     (progn
       (if __data (setq _data (car __data)))
       _data)))
  (:serialization-length
   ()
   (+
    ;; tractor_gps/states_hms _data
    (send _data :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; tractor_gps/states_hms _data
       (send _data :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; tractor_gps/states_hms _data
     (send _data :deserialize buf ptr-) (incf ptr- (send _data :serialization-length))
   ;;
   self)
  )

(defclass tractor_gps::states_rtk
  :super ros::object
  :slots ())

(setf (get tractor_gps::states_rtk :md5sum-) "f2b37e695a8f10e8df0555b3b2850dbe")
(setf (get tractor_gps::states_rtk :datatype-) "tractor_gps/states_rtk")
(setf (get tractor_gps::states_rtk :request) tractor_gps::states_rtkRequest)
(setf (get tractor_gps::states_rtk :response) tractor_gps::states_rtkResponse)

(defmethod tractor_gps::states_rtkRequest
  (:response () (instance tractor_gps::states_rtkResponse :init)))

(setf (get tractor_gps::states_rtkRequest :md5sum-) "f2b37e695a8f10e8df0555b3b2850dbe")
(setf (get tractor_gps::states_rtkRequest :datatype-) "tractor_gps/states_rtkRequest")
(setf (get tractor_gps::states_rtkRequest :definition-)
      "
---
states_hms data


================================================================================
MSG: tractor_gps/states_hms
Header header
uint16 year
uint8 month
uint8 day
uint8 hour
uint8 min
float64 sec
float64[3] data
float64[6] std
float64 age
uint8 Q
uint8 ns
float64 ratio
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id
")

(setf (get tractor_gps::states_rtkResponse :md5sum-) "f2b37e695a8f10e8df0555b3b2850dbe")
(setf (get tractor_gps::states_rtkResponse :datatype-) "tractor_gps/states_rtkResponse")
(setf (get tractor_gps::states_rtkResponse :definition-)
      "
---
states_hms data


================================================================================
MSG: tractor_gps/states_hms
Header header
uint16 year
uint8 month
uint8 day
uint8 hour
uint8 min
float64 sec
float64[3] data
float64[6] std
float64 age
uint8 Q
uint8 ns
float64 ratio
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id
")



(provide :tractor_gps/states_rtk "f2b37e695a8f10e8df0555b3b2850dbe")


