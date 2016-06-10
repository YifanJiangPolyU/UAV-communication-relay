; Auto-generated. Do not edit!


(cl:in-package uav_control-msg)


;//! \htmlinclude channel_stat.msg.html

(cl:defclass <channel_stat> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (msg_received
    :reader msg_received
    :initarg :msg_received
    :type cl:integer
    :initform 0)
   (msg_crc_error
    :reader msg_crc_error
    :initarg :msg_crc_error
    :type cl:integer
    :initform 0)
   (msg_sent
    :reader msg_sent
    :initarg :msg_sent
    :type cl:integer
    :initform 0))
)

(cl:defclass channel_stat (<channel_stat>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <channel_stat>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'channel_stat)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_control-msg:<channel_stat> is deprecated: use uav_control-msg:channel_stat instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <channel_stat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:header-val is deprecated.  Use uav_control-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'msg_received-val :lambda-list '(m))
(cl:defmethod msg_received-val ((m <channel_stat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:msg_received-val is deprecated.  Use uav_control-msg:msg_received instead.")
  (msg_received m))

(cl:ensure-generic-function 'msg_crc_error-val :lambda-list '(m))
(cl:defmethod msg_crc_error-val ((m <channel_stat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:msg_crc_error-val is deprecated.  Use uav_control-msg:msg_crc_error instead.")
  (msg_crc_error m))

(cl:ensure-generic-function 'msg_sent-val :lambda-list '(m))
(cl:defmethod msg_sent-val ((m <channel_stat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:msg_sent-val is deprecated.  Use uav_control-msg:msg_sent instead.")
  (msg_sent m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <channel_stat>) ostream)
  "Serializes a message object of type '<channel_stat>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'msg_received)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'msg_crc_error)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'msg_sent)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <channel_stat>) istream)
  "Deserializes a message object of type '<channel_stat>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'msg_received) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'msg_crc_error) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'msg_sent) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<channel_stat>)))
  "Returns string type for a message object of type '<channel_stat>"
  "uav_control/channel_stat")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'channel_stat)))
  "Returns string type for a message object of type 'channel_stat"
  "uav_control/channel_stat")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<channel_stat>)))
  "Returns md5sum for a message object of type '<channel_stat>"
  "2dcae45f0eee8715910fd5d20620cc55")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'channel_stat)))
  "Returns md5sum for a message object of type 'channel_stat"
  "2dcae45f0eee8715910fd5d20620cc55")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<channel_stat>)))
  "Returns full string definition for message of type '<channel_stat>"
  (cl:format cl:nil "# channel statistics~%~%std_msgs/Header header~%int32  msg_received   # total number of msgs received over this channel~%int32  msg_crc_error  # number of msgs with CRC failure~%int32  msg_sent       # total number of msgs sent over this channel~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'channel_stat)))
  "Returns full string definition for message of type 'channel_stat"
  (cl:format cl:nil "# channel statistics~%~%std_msgs/Header header~%int32  msg_received   # total number of msgs received over this channel~%int32  msg_crc_error  # number of msgs with CRC failure~%int32  msg_sent       # total number of msgs sent over this channel~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <channel_stat>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <channel_stat>))
  "Converts a ROS message object to a list"
  (cl:list 'channel_stat
    (cl:cons ':header (header msg))
    (cl:cons ':msg_received (msg_received msg))
    (cl:cons ':msg_crc_error (msg_crc_error msg))
    (cl:cons ':msg_sent (msg_sent msg))
))
