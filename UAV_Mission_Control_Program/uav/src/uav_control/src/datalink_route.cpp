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
#include <uav_control/datalink_send.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/StreamRate.h>
#include <mavros_msgs/VFR_HUD.h>
#include <mavros_msgs/Mavlink.h>

#include <uav_control/channel_stat.h>


/**
 * @brief Callback functions for datalink routing 
 */
void sub1_callback(const uav_control::DFrame msg);
void sub2_callback(const uav_control::DFrame msg);
void stat_callback(const uav_control::channel_stat msg);


/**
 * UART port handles
 */
int uartFd_ch1;
int uartFd_ch2;

/**
 * Service clients
 */
ros::ServiceClient client_sub1;
ros::ServiceClient client_sub2;

// Publishes datalink frames targeted at local machine (not to be forwarded)
ros::Publisher datalink_for_local;




int main(int argc, char **argv)
{
  uartFd_ch1 = -1;
  uartFd_ch2 = -1;

  /**
   * Initializing this function in ROS
   */
  ros::init(argc, argv, "datalink_send");

  // Create ROS access point
  ros::NodeHandle n;

  /**
   * Subscribe datalink statistics
   */
  ros::Subscriber sub_stat = n.subscribe("uav_control/datalink_stat_ch1", 1, stat_callback);
  
  /**
   * Subscribers for datalink message, all channels
   */
  ros::Subscriber sub1 = n.subscribe("uav_control/datalink_in_ch1", 300, sub1_callback);
  ros::Subscriber sub2 = n.subscribe("uav_control/datalink_in_ch2", 300, sub2_callback);

  /**
   * Initialize service clients
   */
  client_sub1 = n.serviceClient<uav_control::datalink_send>("datalink_send_ch2");
  client_sub2 = n.serviceClient<uav_control::datalink_send>("datalink_send_ch1");


  ros::spin();

  return 0;

}// end of main


void stat_callback(const uav_control::channel_stat msg)
{
  ROS_INFO("total: %d, CRC error: %d", msg.msg_received, msg.msg_crc_error);
}

/**
 * @brief Callback functions for datalink routing, channel 1 
 *        
 */
void sub1_callback(const uav_control::DFrame msg)
{
  // message from GCS, to be relayed to quadcopter
  if(msg.target_id != SYSID){
    uav_control::datalink_send ss;
    ss.request.source_id = msg.source_id;
    ss.request.target_id = msg.target_id;
    ss.request.route = msg.route;
    ss.request.len = msg.len;
    int i;
    for(i=0; i<msg.len; i++)
      ss.request.payload[i] = msg.payload[i];

    if(client_sub1.call(ss)){
      switch(ss.response.err){
        case 0: //ROS_INFO("successful");
                break;
        case 1: ROS_ERROR("relay error: invalid channel");
                break;
        case 2: ROS_ERROR("relay error: channel not initialized");
                break;
        case 3: ROS_ERROR("relay error: sending failed");
                break;
        default: ROS_ERROR("relay error: unknown failure");
                break;
      }
    }
  }

}

/**
 * @brief Callback functions for datalink routing, channel 2
 *        
 */
void sub2_callback(const uav_control::DFrame msg)
{
  if(msg.target_id != SYSID){
    uav_control::datalink_send ss;
    ss.request.source_id = msg.source_id;
    ss.request.target_id = msg.target_id;
    ss.request.route = msg.route;
    ss.request.len = msg.len;
    int i;
    for(i=0; i<msg.len; i++)
      ss.request.payload[i] = msg.payload[i];

    if(client_sub2.call(ss)){
      switch(ss.response.err){
        case 0: //ROS_INFO("successful");
                break;
        case 1: ROS_ERROR("relay error: invalid channel");
                break;
        case 2: ROS_ERROR("relay error: channel not initialized");
                break;
        case 3: ROS_ERROR("relay error: sending failed");
                break;
        default: ROS_ERROR("relay error: unknown failure");
                break;
      }
    }
  }

}

