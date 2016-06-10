#!/bin/bash

# starting ROS nodes of UAV son
# param: 
#        $1 path to node pkg
#        S2 path to port datalink ch1

PATH_TO_UAVPKG=$1
SERIAL_PORT_TCH1=$2

source $PATH_TO_UAVPKG/devel/setup.bash
rosrun uav_control uav_stat_monitor
