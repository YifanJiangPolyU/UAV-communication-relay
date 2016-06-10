;; Auto-generated. Do not edit!


(when (boundp 'uav_control::channel_stat)
  (if (not (find-package "UAV_CONTROL"))
    (make-package "UAV_CONTROL"))
  (shadow 'channel_stat (find-package "UAV_CONTROL")))
(unless (find-package "UAV_CONTROL::CHANNEL_STAT")
  (make-package "UAV_CONTROL::CHANNEL_STAT"))

(in-package "ROS")
;;//! \htmlinclude channel_stat.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uav_control::channel_stat
  :super ros::object
  :slots (_header _msg_received _msg_crc_error _msg_sent ))

(defmethod uav_control::channel_stat
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:msg_received __msg_received) 0)
    ((:msg_crc_error __msg_crc_error) 0)
    ((:msg_sent __msg_sent) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _msg_received (round __msg_received))
   (setq _msg_crc_error (round __msg_crc_error))
   (setq _msg_sent (round __msg_sent))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:msg_received
   (&optional __msg_received)
   (if __msg_received (setq _msg_received __msg_received)) _msg_received)
  (:msg_crc_error
   (&optional __msg_crc_error)
   (if __msg_crc_error (setq _msg_crc_error __msg_crc_error)) _msg_crc_error)
  (:msg_sent
   (&optional __msg_sent)
   (if __msg_sent (setq _msg_sent __msg_sent)) _msg_sent)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _msg_received
    4
    ;; int32 _msg_crc_error
    4
    ;; int32 _msg_sent
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _msg_received
       (write-long _msg_received s)
     ;; int32 _msg_crc_error
       (write-long _msg_crc_error s)
     ;; int32 _msg_sent
       (write-long _msg_sent s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _msg_received
     (setq _msg_received (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _msg_crc_error
     (setq _msg_crc_error (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _msg_sent
     (setq _msg_sent (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uav_control::channel_stat :md5sum-) "2dcae45f0eee8715910fd5d20620cc55")
(setf (get uav_control::channel_stat :datatype-) "uav_control/channel_stat")
(setf (get uav_control::channel_stat :definition-)
      "# channel statistics

std_msgs/Header header
int32  msg_received   # total number of msgs received over this channel
int32  msg_crc_error  # number of msgs with CRC failure
int32  msg_sent       # total number of msgs sent over this channel

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



(provide :uav_control/channel_stat "2dcae45f0eee8715910fd5d20620cc55")


