
(cl:in-package :asdf)

(defsystem "tractor_controller-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "state_tractor" :depends-on ("_package_state_tractor"))
    (:file "_package_state_tractor" :depends-on ("_package"))
  ))