
(cl:in-package :asdf)

(defsystem "tractor_gps-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :tractor_gps-msg
)
  :components ((:file "_package")
    (:file "states_rtk" :depends-on ("_package_states_rtk"))
    (:file "_package_states_rtk" :depends-on ("_package"))
  ))