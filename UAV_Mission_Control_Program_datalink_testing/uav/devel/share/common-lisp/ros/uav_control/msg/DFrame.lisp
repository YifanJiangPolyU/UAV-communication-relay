; Auto-generated. Do not edit!


(cl:in-package uav_control-msg)


;//! \htmlinclude DFrame.msg.html

(cl:defclass <DFrame> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (source_id
    :reader source_id
    :initarg :source_id
    :type cl:fixnum
    :initform 0)
   (target_id
    :reader target_id
    :initarg :target_id
    :type cl:fixnum
    :initform 0)
   (route
    :reader route
    :initarg :route
    :type cl:fixnum
    :initform 0)
   (len
    :reader len
    :initarg :len
    :type cl:fixnum
    :initform 0)
   (payload
    :reader payload
    :initarg :payload
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 1024 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass DFrame (<DFrame>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DFrame>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DFrame)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_control-msg:<DFrame> is deprecated: use uav_control-msg:DFrame instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:header-val is deprecated.  Use uav_control-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'source_id-val :lambda-list '(m))
(cl:defmethod source_id-val ((m <DFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:source_id-val is deprecated.  Use uav_control-msg:source_id instead.")
  (source_id m))

(cl:ensure-generic-function 'target_id-val :lambda-list '(m))
(cl:defmethod target_id-val ((m <DFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:target_id-val is deprecated.  Use uav_control-msg:target_id instead.")
  (target_id m))

(cl:ensure-generic-function 'route-val :lambda-list '(m))
(cl:defmethod route-val ((m <DFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:route-val is deprecated.  Use uav_control-msg:route instead.")
  (route m))

(cl:ensure-generic-function 'len-val :lambda-list '(m))
(cl:defmethod len-val ((m <DFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:len-val is deprecated.  Use uav_control-msg:len instead.")
  (len m))

(cl:ensure-generic-function 'payload-val :lambda-list '(m))
(cl:defmethod payload-val ((m <DFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-msg:payload-val is deprecated.  Use uav_control-msg:payload instead.")
  (payload m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DFrame>) ostream)
  "Serializes a message object of type '<DFrame>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'route)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'len)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'payload))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DFrame>) istream)
  "Deserializes a message object of type '<DFrame>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'route)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'len)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'payload) (cl:make-array 1024))
  (cl:let ((vals (cl:slot-value msg 'payload)))
    (cl:dotimes (i 1024)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DFrame>)))
  "Returns string type for a message object of type '<DFrame>"
  "uav_control/DFrame")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DFrame)))
  "Returns string type for a message object of type 'DFrame"
  "uav_control/DFrame")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DFrame>)))
  "Returns md5sum for a message object of type '<DFrame>"
  "e0309485a009f88afe7cc96fb63e8493")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DFrame)))
  "Returns md5sum for a message object of type 'DFrame"
  "e0309485a009f88afe7cc96fb63e8493")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DFrame>)))
  "Returns full string definition for message of type '<DFrame>"
  (cl:format cl:nil "# datalink frame~%~%std_msgs/Header header~%uint8 source_id~%uint8 target_id~%uint8 route~%uint16 len~%uint8[1024] payload~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DFrame)))
  "Returns full string definition for message of type 'DFrame"
  (cl:format cl:nil "# datalink frame~%~%std_msgs/Header header~%uint8 source_id~%uint8 target_id~%uint8 route~%uint16 len~%uint8[1024] payload~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DFrame>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     2
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'payload) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DFrame>))
  "Converts a ROS message object to a list"
  (cl:list 'DFrame
    (cl:cons ':header (header msg))
    (cl:cons ':source_id (source_id msg))
    (cl:cons ':target_id (target_id msg))
    (cl:cons ':route (route msg))
    (cl:cons ':len (len msg))
    (cl:cons ':payload (payload msg))
))
