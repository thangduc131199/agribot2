
(cl:in-package :asdf)

(defsystem "tractor_gps-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "states_hms" :depends-on ("_package_states_hms"))
    (:file "_package_states_hms" :depends-on ("_package"))
  ))