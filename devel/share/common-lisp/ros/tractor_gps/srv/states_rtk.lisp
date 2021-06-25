; Auto-generated. Do not edit!


(cl:in-package tractor_gps-srv)


;//! \htmlinclude states_rtk-request.msg.html

(cl:defclass <states_rtk-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass states_rtk-request (<states_rtk-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <states_rtk-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'states_rtk-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tractor_gps-srv:<states_rtk-request> is deprecated: use tractor_gps-srv:states_rtk-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <states_rtk-request>) ostream)
  "Serializes a message object of type '<states_rtk-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <states_rtk-request>) istream)
  "Deserializes a message object of type '<states_rtk-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<states_rtk-request>)))
  "Returns string type for a service object of type '<states_rtk-request>"
  "tractor_gps/states_rtkRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'states_rtk-request)))
  "Returns string type for a service object of type 'states_rtk-request"
  "tractor_gps/states_rtkRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<states_rtk-request>)))
  "Returns md5sum for a message object of type '<states_rtk-request>"
  "f2b37e695a8f10e8df0555b3b2850dbe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'states_rtk-request)))
  "Returns md5sum for a message object of type 'states_rtk-request"
  "f2b37e695a8f10e8df0555b3b2850dbe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<states_rtk-request>)))
  "Returns full string definition for message of type '<states_rtk-request>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'states_rtk-request)))
  "Returns full string definition for message of type 'states_rtk-request"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <states_rtk-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <states_rtk-request>))
  "Converts a ROS message object to a list"
  (cl:list 'states_rtk-request
))
;//! \htmlinclude states_rtk-response.msg.html

(cl:defclass <states_rtk-response> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type tractor_gps-msg:states_hms
    :initform (cl:make-instance 'tractor_gps-msg:states_hms)))
)

(cl:defclass states_rtk-response (<states_rtk-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <states_rtk-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'states_rtk-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tractor_gps-srv:<states_rtk-response> is deprecated: use tractor_gps-srv:states_rtk-response instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <states_rtk-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tractor_gps-srv:data-val is deprecated.  Use tractor_gps-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <states_rtk-response>) ostream)
  "Serializes a message object of type '<states_rtk-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'data) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <states_rtk-response>) istream)
  "Deserializes a message object of type '<states_rtk-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'data) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<states_rtk-response>)))
  "Returns string type for a service object of type '<states_rtk-response>"
  "tractor_gps/states_rtkResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'states_rtk-response)))
  "Returns string type for a service object of type 'states_rtk-response"
  "tractor_gps/states_rtkResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<states_rtk-response>)))
  "Returns md5sum for a message object of type '<states_rtk-response>"
  "f2b37e695a8f10e8df0555b3b2850dbe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'states_rtk-response)))
  "Returns md5sum for a message object of type 'states_rtk-response"
  "f2b37e695a8f10e8df0555b3b2850dbe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<states_rtk-response>)))
  "Returns full string definition for message of type '<states_rtk-response>"
  (cl:format cl:nil "states_hms data~%~%~%================================================================================~%MSG: tractor_gps/states_hms~%Header header~%uint16 year~%uint8 month~%uint8 day~%uint8 hour~%uint8 min~%float64 sec~%float64[3] data~%float64[6] std~%float64 age~%uint8 Q~%uint8 ns~%float64 ratio~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'states_rtk-response)))
  "Returns full string definition for message of type 'states_rtk-response"
  (cl:format cl:nil "states_hms data~%~%~%================================================================================~%MSG: tractor_gps/states_hms~%Header header~%uint16 year~%uint8 month~%uint8 day~%uint8 hour~%uint8 min~%float64 sec~%float64[3] data~%float64[6] std~%float64 age~%uint8 Q~%uint8 ns~%float64 ratio~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <states_rtk-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'data))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <states_rtk-response>))
  "Converts a ROS message object to a list"
  (cl:list 'states_rtk-response
    (cl:cons ':data (data msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'states_rtk)))
  'states_rtk-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'states_rtk)))
  'states_rtk-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'states_rtk)))
  "Returns string type for a service object of type '<states_rtk>"
  "tractor_gps/states_rtk")