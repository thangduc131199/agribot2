;; Auto-generated. Do not edit!


(when (boundp 'tractor_controller::state_tractor)
  (if (not (find-package "TRACTOR_CONTROLLER"))
    (make-package "TRACTOR_CONTROLLER"))
  (shadow 'state_tractor (find-package "TRACTOR_CONTROLLER")))
(unless (find-package "TRACTOR_CONTROLLER::STATE_TRACTOR")
  (make-package "TRACTOR_CONTROLLER::STATE_TRACTOR"))

(in-package "ROS")
;;//! \htmlinclude state_tractor.msg.html


(defclass tractor_controller::state_tractor
  :super ros::object
  :slots (_x _y _yaw _v ))

(defmethod tractor_controller::state_tractor
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:yaw __yaw) 0.0)
    ((:v __v) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _yaw (float __yaw))
   (setq _v (float __v))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:v
   (&optional __v)
   (if __v (setq _v __v)) _v)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _yaw
    8
    ;; float64 _v
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _v
       (sys::poke _v (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _v
     (setq _v (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get tractor_controller::state_tractor :md5sum-) "8d02065475d2208fe262b04f47261a35")
(setf (get tractor_controller::state_tractor :datatype-) "tractor_controller/state_tractor")
(setf (get tractor_controller::state_tractor :definition-)
      "float64 x
float64 y
float64 yaw
float64 v
")



(provide :tractor_controller/state_tractor "8d02065475d2208fe262b04f47261a35")


