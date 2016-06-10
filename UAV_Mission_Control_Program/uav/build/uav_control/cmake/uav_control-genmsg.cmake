# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "uav_control: 2 messages, 1 services")

set(MSG_I_FLAGS "-Iuav_control:/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg;-Istd_msgs:/opt/ros/jade/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(uav_control_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg" NAME_WE)
add_custom_target(_uav_control_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_control" "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv" NAME_WE)
add_custom_target(_uav_control_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_control" "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv" ""
)

get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg" NAME_WE)
add_custom_target(_uav_control_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_control" "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg" "std_msgs/Header"
)

#
#  langs = gencpp;geneus;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_control
)
_generate_msg_cpp(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_control
)

### Generating Services
_generate_srv_cpp(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_control
)

### Generating Module File
_generate_module_cpp(uav_control
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_control
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(uav_control_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(uav_control_generate_messages uav_control_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_cpp _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv" NAME_WE)
add_dependencies(uav_control_generate_messages_cpp _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_cpp _uav_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_control_gencpp)
add_dependencies(uav_control_gencpp uav_control_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_control_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_control
)
_generate_msg_eus(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_control
)

### Generating Services
_generate_srv_eus(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_control
)

### Generating Module File
_generate_module_eus(uav_control
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_control
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(uav_control_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(uav_control_generate_messages uav_control_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_eus _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv" NAME_WE)
add_dependencies(uav_control_generate_messages_eus _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_eus _uav_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_control_geneus)
add_dependencies(uav_control_geneus uav_control_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_control_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_control
)
_generate_msg_lisp(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_control
)

### Generating Services
_generate_srv_lisp(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_control
)

### Generating Module File
_generate_module_lisp(uav_control
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_control
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(uav_control_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(uav_control_generate_messages uav_control_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_lisp _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv" NAME_WE)
add_dependencies(uav_control_generate_messages_lisp _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_lisp _uav_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_control_genlisp)
add_dependencies(uav_control_genlisp uav_control_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_control_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control
)
_generate_msg_py(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/jade/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control
)

### Generating Services
_generate_srv_py(uav_control
  "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control
)

### Generating Module File
_generate_module_py(uav_control
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(uav_control_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(uav_control_generate_messages uav_control_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/DFrame.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_py _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/srv/datalink_send.srv" NAME_WE)
add_dependencies(uav_control_generate_messages_py _uav_control_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg/channel_stat.msg" NAME_WE)
add_dependencies(uav_control_generate_messages_py _uav_control_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_control_genpy)
add_dependencies(uav_control_genpy uav_control_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_control_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_control
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(uav_control_generate_messages_cpp std_msgs_generate_messages_cpp)

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_control
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
add_dependencies(uav_control_generate_messages_eus std_msgs_generate_messages_eus)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_control)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_control
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(uav_control_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_control
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(uav_control_generate_messages_py std_msgs_generate_messages_py)
