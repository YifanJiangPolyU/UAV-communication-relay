#include "ros/ros.h"
#include "std_msgs/String.h"
#include "math.h"


#include <mavros_msgs/PositionTarget.h>

#include <uav_control/DFrame.h>
#include <uav_control/datalink_send.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/StreamRate.h>
#include <mavros_msgs/VFR_HUD.h>
#include <mavros_msgs/Mavlink.h>
#include <sensor_msgs/Imu.h>

/**
 * This tutorial demonstrates simple receipt of messages over the ROS system.
 */
void chatterCallback(const mavros_msgs::PositionTarget msg)
{
    ROS_INFO("received setpoint_raw local loopback.");
}




int main(int argc, char **argv)
{
  /**
   * Initialize　ROS system
   */
  ros::init(argc, argv, "listener");

  /**
   * Create ROS access point
   */
  ros::NodeHandle n;

  
  ros::Subscriber sub_ch2 = n.subscribe("/mavros/setpoint_raw/target_local", 50, chatterCallback);
  
  ros::spin();

  return 0;
}
