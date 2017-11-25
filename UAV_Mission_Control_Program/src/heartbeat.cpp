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
#include "ros/time.h"
#include "std_msgs/String.h"
#include "std_msgs/Int32.h"
#include "mavlink/v1.0/common/mavlink.h"

#include <uav_control/DFrame.h>
#include <uav_control/datalink_send.h>

#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/StreamRate.h>
#include <mavros_msgs/BatteryStatus.h>
#include <mavros_msgs/Mavlink.h>


const uint8_t sysid = 0x03;

int main(int argc, char **argv)
{

  ros::init(argc, argv, "heartbeat-server");
  ros::NodeHandle n;


  /**
   * ROS service sending datalink frames to GCS
   */
  ros::ServiceClient client_ch1 = n.serviceClient<uav_control::datalink_send>("datalink_send_ch1");
  ros::ServiceClient client_ch2 = n.serviceClient<uav_control::datalink_send>("datalink_send_ch2");


  // start monitoring everything
  // send heartbeat once a second
  // check connection status once a second
  ros::Rate loop_rate(1);


  while(ros::ok()){

    // send heartbeat every second
    uav_control::datalink_send ss;
    ss.request.source_id = sysid;
    ss.request.target_id = 0x01;
    ss.request.route = 0;
    ss.request.payload[0] = 0;
    ss.request.len = 1;
    client_ch1.call(ss);
    client_ch2.call(ss);

    ros::spinOnce();
    loop_rate.sleep();
  }

}// end of main
