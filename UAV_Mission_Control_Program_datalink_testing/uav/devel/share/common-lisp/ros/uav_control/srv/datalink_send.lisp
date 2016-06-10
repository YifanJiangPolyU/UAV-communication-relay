; Auto-generated. Do not edit!


(cl:in-package uav_control-srv)


;//! \htmlinclude datalink_send-request.msg.html

(cl:defclass <datalink_send-request> (roslisp-msg-protocol:ros-message)
  ((source_id
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

(cl:defclass datalink_send-request (<datalink_send-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <datalink_send-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'datalink_send-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_control-srv:<datalink_send-request> is deprecated: use uav_control-srv:datalink_send-request instead.")))

(cl:ensure-generic-function 'source_id-val :lambda-list '(m))
(cl:defmethod source_id-val ((m <datalink_send-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-srv:source_id-val is deprecated.  Use uav_control-srv:source_id instead.")
  (source_id m))

(cl:ensure-generic-function 'target_id-val :lambda-list '(m))
(cl:defmethod target_id-val ((m <datalink_send-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-srv:target_id-val is deprecated.  Use uav_control-srv:target_id instead.")
  (target_id m))

(cl:ensure-generic-function 'route-val :lambda-list '(m))
(cl:defmethod route-val ((m <datalink_send-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-srv:route-val is deprecated.  Use uav_control-srv:route instead.")
  (route m))

(cl:ensure-generic-function 'len-val :lambda-list '(m))
(cl:defmethod len-val ((m <datalink_send-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-srv:len-val is deprecated.  Use uav_control-srv:len instead.")
  (len m))

(cl:ensure-generic-function 'payload-val :lambda-list '(m))
(cl:defmethod payload-val ((m <datalink_send-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-srv:payload-val is deprecated.  Use uav_control-srv:payload instead.")
  (payload m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <datalink_send-request>) ostream)
  "Serializes a message object of type '<datalink_send-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'route)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'len)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'payload))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <datalink_send-request>) istream)
  "Deserializes a message object of type '<datalink_send-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<datalink_send-request>)))
  "Returns string type for a service object of type '<datalink_send-request>"
  "uav_control/datalink_sendRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'datalink_send-request)))
  "Returns string type for a service object of type 'datalink_send-request"
  "uav_control/datalink_sendRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<datalink_send-request>)))
  "Returns md5sum for a message object of type '<datalink_send-request>"
  "c59b12dd2dff876a39a7e4b90f940b75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'datalink_send-request)))
  "Returns md5sum for a message object of type 'datalink_send-request"
  "c59b12dd2dff876a39a7e4b90f940b75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<datalink_send-request>)))
  "Returns full string definition for message of type '<datalink_send-request>"
  (cl:format cl:nil "~%~%uint8 source_id~%uint8 target_id~%uint8 route~%uint16 len~%uint8[1024] payload~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'datalink_send-request)))
  "Returns full string definition for message of type 'datalink_send-request"
  (cl:format cl:nil "~%~%uint8 source_id~%uint8 target_id~%uint8 route~%uint16 len~%uint8[1024] payload~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <datalink_send-request>))
  (cl:+ 0
     1
     1
     1
     2
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'payload) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <datalink_send-request>))
  "Converts a ROS message object to a list"
  (cl:list 'datalink_send-request
    (cl:cons ':source_id (source_id msg))
    (cl:cons ':target_id (target_id msg))
    (cl:cons ':route (route msg))
    (cl:cons ':len (len msg))
    (cl:cons ':payload (payload msg))
))
;//! \htmlinclude datalink_send-response.msg.html

(cl:defclass <datalink_send-response> (roslisp-msg-protocol:ros-message)
  ((err
    :reader err
    :initarg :err
    :type cl:fixnum
    :initform 0))
)

(cl:defclass datalink_send-response (<datalink_send-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <datalink_send-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'datalink_send-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_control-srv:<datalink_send-response> is deprecated: use uav_control-srv:datalink_send-response instead.")))

(cl:ensure-generic-function 'err-val :lambda-list '(m))
(cl:defmethod err-val ((m <datalink_send-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_control-srv:err-val is deprecated.  Use uav_control-srv:err instead.")
  (err m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <datalink_send-response>) ostream)
  "Serializes a message object of type '<datalink_send-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'err)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <datalink_send-response>) istream)
  "Deserializes a message object of type '<datalink_send-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'err)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<datalink_send-response>)))
  "Returns string type for a service object of type '<datalink_send-response>"
  "uav_control/datalink_sendResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'datalink_send-response)))
  "Returns string type for a service object of type 'datalink_send-response"
  "uav_control/datalink_sendResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<datalink_send-response>)))
  "Returns md5sum for a message object of type '<datalink_send-response>"
  "c59b12dd2dff876a39a7e4b90f940b75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'datalink_send-response)))
  "Returns md5sum for a message object of type 'datalink_send-response"
  "c59b12dd2dff876a39a7e4b90f940b75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<datalink_send-response>)))
  "Returns full string definition for message of type '<datalink_send-response>"
  (cl:format cl:nil "uint8 err~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'datalink_send-response)))
  "Returns full string definition for message of type 'datalink_send-response"
  (cl:format cl:nil "uint8 err~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <datalink_send-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <datalink_send-response>))
  "Converts a ROS message object to a list"
  (cl:list 'datalink_send-response
    (cl:cons ':err (err msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'datalink_send)))
  'datalink_send-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'datalink_send)))
  'datalink_send-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'datalink_send)))
  "Returns string type for a service object of type '<datalink_send>"
  "uav_control/datalink_send")