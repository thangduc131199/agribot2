; Auto-generated. Do not edit!


(cl:in-package tractor_gps-msg)


;//! \htmlinclude states_hms.msg.html

(cl:defclass <states_hms> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (year
    :reader year
    :initarg :year
    :type cl:fixnum
    :initform 0)
   (month
    :reader month
    :initarg :month
    :type cl:fixnum
    :initform 0)
   (day
    :reader day
    :initarg :day
    :type cl:fixnum
    :initform 0)
   (hour
    :reader hour
    :initarg :hour
    :type cl:fixnum
    :initform 0)
   (min
    :reader min
    :initarg :min
    :type cl:fixnum
    :initform 0)
   (sec
    :reader sec
    :initarg :sec
    :type cl:float
    :initform 0.0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (std
    :reader std
    :initarg :std
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0))
   (age
    :reader age
    :initarg :age
    :type cl:float
    :initform 0.0)
   (Q
    :reader Q
    :initarg :Q
    :type cl:fixnum
    :initform 0)
   (ns
    :reader ns
    :initarg :ns
    :type cl:fixnum
    :initform 0)
   (ratio
    :reader ratio
    :initarg :ratio
    :type cl:float
    :initform 0.0))
)

(cl:defclass states_hms (<states_hms>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <states_hms>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'states_hms)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tractor_gps-msg:<states_hms> is deprecated: use tractor_gps-msg:states_hms instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:header-val is deprecated.  Use tractor_gps-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'year-val :lambda-list '(m))
(cl:defmethod year-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:year-val is deprecated.  Use tractor_gps-msg:year instead.")
  (year m))

(cl:ensure-generic-function 'month-val :lambda-list '(m))
(cl:defmethod month-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:month-val is deprecated.  Use tractor_gps-msg:month instead.")
  (month m))

(cl:ensure-generic-function 'day-val :lambda-list '(m))
(cl:defmethod day-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:day-val is deprecated.  Use tractor_gps-msg:day instead.")
  (day m))

(cl:ensure-generic-function 'hour-val :lambda-list '(m))
(cl:defmethod hour-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:hour-val is deprecated.  Use tractor_gps-msg:hour instead.")
  (hour m))

(cl:ensure-generic-function 'min-val :lambda-list '(m))
(cl:defmethod min-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:min-val is deprecated.  Use tractor_gps-msg:min instead.")
  (min m))

(cl:ensure-generic-function 'sec-val :lambda-list '(m))
(cl:defmethod sec-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:sec-val is deprecated.  Use tractor_gps-msg:sec instead.")
  (sec m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:data-val is deprecated.  Use tractor_gps-msg:data instead.")
  (data m))

(cl:ensure-generic-function 'std-val :lambda-list '(m))
(cl:defmethod std-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:std-val is deprecated.  Use tractor_gps-msg:std instead.")
  (std m))

(cl:ensure-generic-function 'age-val :lambda-list '(m))
(cl:defmethod age-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:age-val is deprecated.  Use tractor_gps-msg:age instead.")
  (age m))

(cl:ensure-generic-function 'Q-val :lambda-list '(m))
(cl:defmethod Q-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:Q-val is deprecated.  Use tractor_gps-msg:Q instead.")
  (Q m))

(cl:ensure-generic-function 'ns-val :lambda-list '(m))
(cl:defmethod ns-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:ns-val is deprecated.  Use tractor_gps-msg:ns instead.")
  (ns m))

(cl:ensure-generic-function 'ratio-val :lambda-list '(m))
(cl:defmethod ratio-val ((m <states_hms>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-msg:ratio-val is deprecated.  Use tractor_gps-msg:ratio instead.")
  (ratio m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <states_hms>) ostream)
  "Serializes a message object of type '<states_hms>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'year)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'year)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'month)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'day)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'hour)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'min)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'sec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'data))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'std))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'age))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Q)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ns)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'ratio))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <states_hms>) istream)
  "Deserializes a message object of type '<states_hms>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'year)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'year)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'month)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'day)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'hour)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'min)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sec) (roslisp-utils:decode-double-float-bits bits)))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'std) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'std)))
    (cl:dotimes (i 6)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'age) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Q)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ns)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ratio) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<states_hms>)))
  "Returns string type for a message object of type '<states_hms>"
  "tractor_gps/states_hms")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'states_hms)))
  "Returns string type for a message object of type 'states_hms"
  "tractor_gps/states_hms")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<states_hms>)))
  "Returns md5sum for a message object of type '<states_hms>"
  "492fd46042199508df6dd15363fd81e6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'states_hms)))
  "Returns md5sum for a message object of type 'states_hms"
  "492fd46042199508df6dd15363fd81e6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<states_hms>)))
  "Returns full string definition for message of type '<states_hms>"
  (cl:format cl:nil "Header header~%uint16 year~%uint8 month~%uint8 day~%uint8 hour~%uint8 min~%float64 sec~%float64[3] data~%float64[6] std~%float64 age~%uint8 Q~%uint8 ns~%float64 ratio~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'states_hms)))
  "Returns full string definition for message of type 'states_hms"
  (cl:format cl:nil "Header header~%uint16 year~%uint8 month~%uint8 day~%uint8 hour~%uint8 min~%float64 sec~%float64[3] data~%float64[6] std~%float64 age~%uint8 Q~%uint8 ns~%float64 ratio~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <states_hms>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     1
     1
     1
     1
     8
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'std) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
     1
     1
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <states_hms>))
  "Converts a ROS message object to a list"
  (cl:list 'states_hms
    (cl:cons ':header (header msg))
    (cl:cons ':year (year msg))
    (cl:cons ':month (month msg))
    (cl:cons ':day (day msg))
    (cl:cons ':hour (hour msg))
    (cl:cons ':min (min msg))
    (cl:cons ':sec (sec msg))
    (cl:cons ':data (data msg))
    (cl:cons ':std (std msg))
    (cl:cons ':age (age msg))
    (cl:cons ':Q (Q msg))
    (cl:cons ':ns (ns msg))
    (cl:cons ':ratio (ratio msg))
))
