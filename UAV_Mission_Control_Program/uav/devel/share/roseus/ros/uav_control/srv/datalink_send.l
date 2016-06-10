;; Auto-generated. Do not edit!


(when (boundp 'uav_control::datalink_send)
  (if (not (find-package "UAV_CONTROL"))
    (make-package "UAV_CONTROL"))
  (shadow 'datalink_send (find-package "UAV_CONTROL")))
(unless (find-package "UAV_CONTROL::DATALINK_SEND")
  (make-package "UAV_CONTROL::DATALINK_SEND"))
(unless (find-package "UAV_CONTROL::DATALINK_SENDREQUEST")
  (make-package "UAV_CONTROL::DATALINK_SENDREQUEST"))
(unless (find-package "UAV_CONTROL::DATALINK_SENDRESPONSE")
  (make-package "UAV_CONTROL::DATALINK_SENDRESPONSE"))

(in-package "ROS")





(defclass uav_control::datalink_sendRequest
  :super ros::object
  :slots (_source_id _target_id _route _len _payload ))

(defmethod uav_control::datalink_sendRequest
  (:init
   (&key
    ((:source_id __source_id) 0)
    ((:target_id __target_id) 0)
    ((:route __route) 0)
    ((:len __len) 0)
    ((:payload __payload) (make-array 1024 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _source_id (round __source_id))
   (setq _target_id (round __target_id))
   (setq _route (round __route))
   (setq _len (round __len))
   (setq _payload __payload)
   self)
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

(defclass uav_control::datalink_sendResponse
  :super ros::object
  :slots (_err ))

(defmethod uav_control::datalink_sendResponse
  (:init
   (&key
    ((:err __err) 0)
    )
   (send-super :init)
   (setq _err (round __err))
   self)
  (:err
   (&optional __err)
   (if __err (setq _err __err)) _err)
  (:serialization-length
   ()
   (+
    ;; uint8 _err
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _err
       (write-byte _err s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _err
     (setq _err (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass uav_control::datalink_send
  :super ros::object
  :slots ())

(setf (get uav_control::datalink_send :md5sum-) "c59b12dd2dff876a39a7e4b90f940b75")
(setf (get uav_control::datalink_send :datatype-) "uav_control/datalink_send")
(setf (get uav_control::datalink_send :request) uav_control::datalink_sendRequest)
(setf (get uav_control::datalink_send :response) uav_control::datalink_sendResponse)

(defmethod uav_control::datalink_sendRequest
  (:response () (instance uav_control::datalink_sendResponse :init)))

(setf (get uav_control::datalink_sendRequest :md5sum-) "c59b12dd2dff876a39a7e4b90f940b75")
(setf (get uav_control::datalink_sendRequest :datatype-) "uav_control/datalink_sendRequest")
(setf (get uav_control::datalink_sendRequest :definition-)
      "

uint8 source_id
uint8 target_id
uint8 route
uint16 len
uint8[1024] payload
---
uint8 err

")

(setf (get uav_control::datalink_sendResponse :md5sum-) "c59b12dd2dff876a39a7e4b90f940b75")
(setf (get uav_control::datalink_sendResponse :datatype-) "uav_control/datalink_sendResponse")
(setf (get uav_control::datalink_sendResponse :definition-)
      "

uint8 source_id
uint8 target_id
uint8 route
uint16 len
uint8[1024] payload
---
uint8 err

")



(provide :uav_control/datalink_send "c59b12dd2dff876a39a7e4b90f940b75")


