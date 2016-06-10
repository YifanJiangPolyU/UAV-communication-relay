
(cl:in-package :asdf)

(defsystem "uav_control-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "channel_stat" :depends-on ("_package_channel_stat"))
    (:file "_package_channel_stat" :depends-on ("_package"))
    (:file "DFrame" :depends-on ("_package_DFrame"))
    (:file "_package_DFrame" :depends-on ("_package"))
  ))