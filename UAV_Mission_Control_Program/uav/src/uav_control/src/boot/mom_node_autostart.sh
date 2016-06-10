#!/bin/bash

# starting ROS nodes of UAV son
# param: 
#        $1 path to node pkg
#        $2 path to port datalink ch1
#        $3 path to port datalink ch2
#        $4 whether to bypass pixhawk of mom

PATH_TO_UAVPKG=$1
SERIAL_PORT_TCH1=$2
SERIAL_PORT_TCH2=$3
MOM_BYPASS=$4

source $PATH_TO_UAVPKG/devel/setup.bash

if [ $MOM_BYPASS = "yes" ]
then
  rosrun uav_control datalink_ch1 $SERIAL_PORT_TCH1 | rosrun uav_control datalink_ch2 $SERIAL_PORT_TCH2 | rosrun uav_control datalink_route
elif [ $MOM_BYPASS = "no" ]
then
  rosrun uav_control datalink_ch1 $SERIAL_PORT_TCH1 | rosrun uav_control datalink_ch2 $SERIAL_PORT_TCH2 | rosrun uav_control datalink_route | rosrun uav_control cmd | rosrun uav_control uav_stat_monitor
fi

