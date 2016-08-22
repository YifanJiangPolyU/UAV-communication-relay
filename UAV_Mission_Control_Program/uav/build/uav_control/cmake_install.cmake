# Install script for directory: /home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/src/uav_control

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uav_control/msg" TYPE FILE FILES
    "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/src/uav_control/msg/DFrame.msg"
    "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/src/uav_control/msg/channel_stat.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uav_control/srv" TYPE FILE FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/src/uav_control/srv/datalink_send.srv")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uav_control/cmake" TYPE FILE FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/build/uav_control/catkin_generated/installspace/uav_control-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/devel/include/uav_control")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/devel/share/roseus/ros/uav_control")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/devel/share/common-lisp/ros/uav_control")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/devel/lib/python2.7/dist-packages/uav_control")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/devel/lib/python2.7/dist-packages/uav_control")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/build/uav_control/catkin_generated/installspace/uav_control.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uav_control/cmake" TYPE FILE FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/build/uav_control/catkin_generated/installspace/uav_control-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uav_control/cmake" TYPE FILE FILES
    "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/build/uav_control/catkin_generated/installspace/uav_controlConfig.cmake"
    "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/build/uav_control/catkin_generated/installspace/uav_controlConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uav_control" TYPE FILE FILES "/home/yifan/git/UAV-communication-relay/UAV_Mission_Control_Program/uav/src/uav_control/package.xml")
endif()

