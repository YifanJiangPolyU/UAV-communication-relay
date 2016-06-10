cmake_minimum_required(VERSION 2.8.3)
project(uav_control)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs message_generation)



## Custom messages
 add_message_files(
   DIRECTORY msg
   FILES
   DFrame.msg
   channel_stat.msg
 )

## Custom services
add_service_files(
   DIRECTORY srv
   FILES
   datalink_send.srv
 )
## Generate added messages and services
generate_messages(DEPENDENCIES std_msgs )

## Declare a catkin package
catkin_package( CATKIN_DEPENDS message_runtime)

## Include path
include_directories(include ${catkin_INCLUDE_DIRS})
include_directories(/home/yifan/git/mavros/devel/include)
include_directories(/home/yifan/git/uav-control-mavros/src/uav_control/src)


##
## Build the packet
##

add_executable(listener src/listener.cpp)
target_link_libraries(listener ${catkin_LIBRARIES})
add_dependencies(listener  ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})


## datalink, channel 1
add_executable(datalink_ch1 src/datalink_ch1.cpp)
target_link_libraries(datalink_ch1 ${catkin_LIBRARIES})
add_dependencies(datalink_ch1  ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## datalink, channel 2
add_executable(datalink_ch2 src/datalink_ch2.cpp)
target_link_libraries(datalink_ch2 ${catkin_LIBRARIES})
add_dependencies(datalink_ch2 ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## datalink msg router
add_executable(datalink_route src/datalink_route.cpp)
target_link_libraries(datalink_route ${catkin_LIBRARIES})
add_dependencies(datalink_route ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## send heartbeat every 1 sec
#add_executable(heartbeat src/heartbeat.cpp)
#target_link_libraries(heartbeat ${catkin_LIBRARIES})
#add_dependencies(heartbeat  ${catkin_EXPORTED_TARGETS})

## monitor UAV state
add_executable(uav_stat_monitor src/uav_stat_monitor.cpp)
target_link_libraries(uav_stat_monitor ${catkin_LIBRARIES})
add_dependencies(uav_stat_monitor ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## commands from GCS
add_executable(cmd src/cmd.cpp)
target_link_libraries(cmd ${catkin_LIBRARIES})
add_dependencies(cmd ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## a small program to verify port assignment
add_executable(verify_port_assignment src/verify_port_assignment.cpp)
target_link_libraries(verify_port_assignment ${catkin_LIBRARIES})
add_dependencies(verify_port_assignment ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
