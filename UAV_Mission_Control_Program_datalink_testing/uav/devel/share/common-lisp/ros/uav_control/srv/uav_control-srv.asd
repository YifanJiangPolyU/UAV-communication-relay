
(cl:in-package :asdf)

(defsystem "uav_control-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "datalink_send" :depends-on ("_package_datalink_send"))
    (:file "_package_datalink_send" :depends-on ("_package"))
  ))