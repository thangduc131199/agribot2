;; Auto-generated. Do not edit!


(when (boundp 'tractor_gps::states_hms)
  (if (not (find-package "TRACTOR_GPS"))
    (make-package "TRACTOR_GPS"))
  (shadow 'states_hms (find-package "TRACTOR_GPS")))
(unless (find-package "TRACTOR_GPS::STATES_HMS")
  (make-package "TRACTOR_GPS::STATES_HMS"))

(in-package "ROS")
;;//! \htmlinclude states_hms.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tractor_gps::states_hms
  :super ros::object
  :slots (_header _year _month _day _hour _min _sec _data _std _age _Q _ns _ratio ))

(defmethod tractor_gps::states_hms
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:year __year) 0)
    ((:month __month) 0)
    ((:day __day) 0)
    ((:hour __hour) 0)
    ((:min __min) 0)
    ((:sec __sec) 0.0)
    ((:data __data) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:std __std) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:age __age) 0.0)
    ((:Q __Q) 0)
    ((:ns __ns) 0)
    ((:ratio __ratio) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _year (round __year))
   (setq _month (round __month))
   (setq _day (round __day))
   (setq _hour (round __hour))
   (setq _min (round __min))
   (setq _sec (float __sec))
   (setq _data __data)
   (setq _std __std)
   (setq _age (float __age))
   (setq _Q (round __Q))
   (setq _ns (round __ns))
   (setq _ratio (float __ratio))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:year
   (&optional __year)
   (if __year (setq _year __year)) _year)
  (:month
   (&optional __month)
   (if __month (setq _month __month)) _month)
  (:day
   (&optional __day)
   (if __day (setq _day __day)) _day)
  (:hour
   (&optional __hour)
   (if __hour (setq _hour __hour)) _hour)
  (:min
   (&optional __min)
   (if __min (setq _min __min)) _min)
  (:sec
   (&optional __sec)
   (if __sec (setq _sec __sec)) _sec)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:std
   (&optional __std)
   (if __std (setq _std __std)) _std)
  (:age
   (&optional __age)
   (if __age (setq _age __age)) _age)
  (:Q
   (&optional __Q)
   (if __Q (setq _Q __Q)) _Q)
  (:ns
   (&optional __ns)
   (if __ns (setq _ns __ns)) _ns)
  (:ratio
   (&optional __ratio)
   (if __ratio (setq _ratio __ratio)) _ratio)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint16 _year
    2
    ;; uint8 _month
    1
    ;; uint8 _day
    1
    ;; uint8 _hour
    1
    ;; uint8 _min
    1
    ;; float64 _sec
    8
    ;; float64[3] _data
    (* 8    3)
    ;; float64[6] _std
    (* 8    6)
    ;; float64 _age
    8
    ;; uint8 _Q
    1
    ;; uint8 _ns
    1
    ;; float64 _ratio
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint16 _year
       (write-word _year s)
     ;; uint8 _month
       (write-byte _month s)
     ;; uint8 _day
       (write-byte _day s)
     ;; uint8 _hour
       (write-byte _hour s)
     ;; uint8 _min
       (write-byte _min s)
     ;; float64 _sec
       (sys::poke _sec (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[3] _data
     (dotimes (i 3)
       (sys::poke (elt _data i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[6] _std
     (dotimes (i 6)
       (sys::poke (elt _std i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64 _age
       (sys::poke _age (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint8 _Q
       (write-byte _Q s)
     ;; uint8 _ns
       (write-byte _ns s)
     ;; float64 _ratio
       (sys::poke _ratio (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint16 _year
     (setq _year (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _month
     (setq _month (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _day
     (setq _day (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _hour
     (setq _hour (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _min
     (setq _min (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _sec
     (setq _sec (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[3] _data
   (dotimes (i (length _data))
     (setf (elt _data i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[6] _std
   (dotimes (i (length _std))
     (setf (elt _std i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64 _age
     (setq _age (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint8 _Q
     (setq _Q (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ns
     (setq _ns (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _ratio
     (setq _ratio (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get tractor_gps::states_hms :md5sum-) "492fd46042199508df6dd15363fd81e6")
(setf (get tractor_gps::states_hms :datatype-) "tractor_gps/states_hms")
(setf (get tractor_gps::states_hms :definition-)
      "Header header
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



(provide :tractor_gps/states_hms "492fd46042199508df6dd15363fd81e6")


