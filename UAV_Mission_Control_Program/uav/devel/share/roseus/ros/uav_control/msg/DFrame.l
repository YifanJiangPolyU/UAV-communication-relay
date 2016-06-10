;; Auto-generated. Do not edit!


(when (boundp 'uav_control::DFrame)
  (if (not (find-package "UAV_CONTROL"))
    (make-package "UAV_CONTROL"))
  (shadow 'DFrame (find-package "UAV_CONTROL")))
(unless (find-package "UAV_CONTROL::DFRAME")
  (make-package "UAV_CONTROL::DFRAME"))

(in-package "ROS")
;;//! \htmlinclude DFrame.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uav_control::DFrame
  :super ros::object
  :slots (_header _source_id _target_id _route _len _payload ))

(defmethod uav_control::DFrame
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:source_id __source_id) 0)
    ((:target_id __target_id) 0)
    ((:route __route) 0)
    ((:len __len) 0)
    ((:payload __payload) (make-array 1024 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _header __header)
   (setq _source_id (round __source_id))
   (setq _target_id (round __target_id))
   (setq _route (round __route))
   (setq _len (round __len))
   (setq _payload __payload)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:source_id
   (&optional __source_id)
   (if __source_id (setq _source_id __source_id)) _source_id)
  (:target_id
   (&optional __target_id)
   (if __target_id (setq _target_id __target_id)) _target_id)
  (:route
   (&optional __route)
   (if __route (setq _route __route)) _route)
  (:len
   (&optional __len)
   (if __len (setq _len __len)) _len)
  (:payload
   (&optional __payload)
   (if __payload (setq _payload __payload)) _payload)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _source_id
    1
    ;; uint8 _target_id
    1
    ;; uint8 _route
    1
    ;; uint16 _len
    2
    ;; uint8[1024] _payload
    (* 1    1024)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _source_id
       (write-byte _source_id s)
     ;; uint8 _target_id
       (write-byte _target_id s)
     ;; uint8 _route
       (write-byte _route s)
     ;; uint16 _len
       (write-word _len s)
     ;; uint8[1024] _payload
     (princ _payload s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _source_id
     (setq _source_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _target_id
     (setq _target_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _route
     (setq _route (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _len
     (setq _len (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8[1024] _payload
   (setq _payload (make-array 1024 :element-type :char))
   (replace _payload buf :start2 ptr-) (incf ptr- 1024)
   ;;
   self)
  )

(setf (get uav_control::DFrame :md5sum-) "e0309485a009f88afe7cc96fb63e8493")
(setf (get uav_control::DFrame :datatype-) "uav_control/DFrame")
(setf (get uav_control::DFrame :definition-)
      "# datalink frame

std_msgs/Header header
uint8 source_id
uint8 target_id
uint8 route
uint16 len
uint8[1024] payload

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
# 0: no frame
# 1: global frame
string frame_id

")



(provide :uav_control/DFrame "e0309485a009f88afe7cc96fb63e8493")


