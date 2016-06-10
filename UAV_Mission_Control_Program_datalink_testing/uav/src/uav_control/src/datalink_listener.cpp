#include "unistd.h"
#include "stdio.h"
#include "sys/types.h"
#include "sys/stat.h"
#include "errno.h"
#include "fcntl.h"
#include "pthread.h"
#include "string.h"
#include "termios.h"
#include "stdint.h"

#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Int32.h"
#include "sysid.h"
#include <uav_control/DFrame.h>
#include <uav_control/channel_stat.h>
#include <uav_control/datalink_send.h>
/**
 * This tutorial demonstrates simple receipt of messages over the ROS system.
 */
void ch1_callback(const uav_control::channel_stat msg)
{
    ROS_INFO("ch1 stat update");
    ROS_INFO("    # msg received: %d", msg.msg_received);
    ROS_INFO("    # msg received: %d", msg.msg_crc_error);

}

void ch2_callback(const uav_control::channel_stat msg)
{
    ROS_INFO("ch2 stat update");
    ROS_INFO("    # msg received: %d", msg.msg_received);
    ROS_INFO("    # msg received: %d", msg.msg_crc_error);

}


int main(int argc, char **argv)
{
  /**
   * Initialize　ROS system
   */
  ros::init(argc, argv, "datalink_listener");

  /**
   * Create ROS access point
   */
  ros::NodeHandle n;
  
  ros::Subscriber sub_ch1 = n.subscribe("uav_control/datalink_stat_ch1", 15, ch1_callback);
  ros::Subscriber sub_ch2 = n.subscribe("uav_control/datalink_stat_ch2", 15, ch2_callback);
  
  ros::spin();

  return 0;
}
