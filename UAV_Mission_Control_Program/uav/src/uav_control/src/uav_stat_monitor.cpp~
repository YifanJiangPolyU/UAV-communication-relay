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
#include "mavlink2.0/common/mavlink.h"

#include "sysid.h"
#include <uav_control/DFrame.h>
#include <uav_control/datalink_send.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/StreamRate.h>
#include <mavros_msgs/BatteryStatus.h>
#include <mavros_msgs/Mavlink.h>


const uint8_t sysid = SYSID;



/**
 * ROS service sending datalink frames
 */
ros::ServiceClient client;
ros::ServiceClient client_ch2;

/**
 * Quadcopter and GCS connection status
 */
double time_last_msg_gcs = 0;
double time_last_msg_quad = 0;

/**
 *  subscriber callbacks
 */
void mav_callback(const mavros_msgs::Mavlink msg);
void battery_callback(const mavros_msgs::BatteryStatus msg);
void gcs_callback(const uav_control::DFrame msg);
void quad_callback(const uav_control::DFrame msg);
void state_callback(const mavros_msgs::State msg);

int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "uav_stat_monitor");
  ros::NodeHandle n;

  /**
   * Quadcopter and GCS connection status
   */
  time_last_msg_gcs = ros::Time::now().toSec();
  time_last_msg_quad = ros::Time::now().toSec();

  /**
   * ROS subscriber to MAVLink messages, to receive UAV status
   */
  ros::Subscriber sub_mav = n.subscribe("/mavlink/from", 10, mav_callback);
  ros::Subscriber sub_bat = n.subscribe("/mavros/battery", 10, battery_callback);
  ros::Subscriber sub_state = n.subscribe("/mavros/battery", 10, battery_callback);

  /**
   * subscribes to msgs from GCS and quadcopter
   */
  ros::Subscriber sub_gcs = n.subscribe("/uav_control/datalink_in_ch1", 10, gcs_callback);
  ros::Subscriber sub_quad = n.subscribe("/uav_control/datalink_in_ch2", 10, quad_callback);

  /**
   * ROS service sending datalink frames to GCS
   */
  client = n.serviceClient<uav_control::datalink_send>("datalink_send_ch1");
  client_ch2 = n.serviceClient<uav_control::datalink_send>("datalink_send_ch2");

  /**
   * Use MAVROS to set autopilot data stream rate to 3/sec (3 Hz)
   */
  ros::ServiceClient client_set_rate = n.serviceClient<mavros_msgs::StreamRate>("/mavros/set_stream_rate");
  mavros_msgs::StreamRate ss_set_rate;
  ss_set_rate.request.stream_id = 0;
  ss_set_rate.request.message_rate = 1;
  ss_set_rate.request.on_off = true;
  client_set_rate.call(ss_set_rate);

  // start monitoring everything
  // send heartbeat once a second
  // check connection status once a second
  ros::Rate loop_rate(1);

  ros::spin();


}// end of main


/**
 *  @brief Reporting to GCS the status of UAV
 *         when reporting to GCS, payload has the same format as the corresponding MAVLink message.
 */
void mav_callback(const mavros_msgs::Mavlink rmsg)
{
  int64_t payload64[33];
  std::copy(rmsg.payload64.begin(), rmsg.payload64.end(), payload64);

  uav_control::datalink_send ss;
  ss.request.source_id = sysid;
  ss.request.target_id = 0x00;
  ss.request.route = 2;

  bool call_stat = false;

  static uint8_t fix_type = 0;

  // UAV system status
  // GPS raw, get fix type
  if(rmsg.msgid == 24){
    fix_type = *((uint8_t*)payload64 + 28);
  }
  // attitude
  else if(rmsg.msgid == 30){
    ss.request.payload[0] = 30;
    float * fff = (float*)payload64;
    memcpy((char*)(&(ss.request.payload[1])), fff+1, 4);
    memcpy((char*)(&(ss.request.payload[5])), fff+2, 4);
    memcpy((char*)(&(ss.request.payload[9])), fff+3, 4);
    ss.request.len = 13;
    call_stat = client.call(ss);
  }
  // global_position_int
  else if(rmsg.msgid == 33){
    ss.request.payload[0] = 33;
    int32_t * uuu = (int32_t*)payload64;
    memcpy((char*)(&(ss.request.payload[1])), uuu+1, 4);  // lat
    memcpy((char*)(&(ss.request.payload[5])), uuu+2, 4);  // lon
    memcpy((char*)(&(ss.request.payload[9])), uuu+3, 4);  // alt
    int16_t * uuu2 = (int16_t*)(uuu+5);
    memcpy((char*)(&(ss.request.payload[13])), uuu2+1, 2); // vx
    memcpy((char*)(&(ss.request.payload[15])), uuu2+1, 2); // vy
    memcpy((char*)(&(ss.request.payload[17])), uuu2+1, 2); // vz
    ss.request.len = 19;
    ROS_INFO(" got GPS ");
    call_stat = client.call(ss);
  }
  // UAV VFR hud
  else if(rmsg.msgid == 74){
    ss.request.payload[0] = 74;

    float * fff = (float*)payload64;
    uint16_t * uuu = (uint16_t*)(fff+4);
    memcpy((char*)(&(ss.request.payload[1])), fff, 4);  // air speed
    memcpy((char*)(&(ss.request.payload[5])), fff+1, 4);  // ground speed
    memcpy((char*)(&(ss.request.payload[9])), uuu, 2);   // heading
    memcpy((char*)(&(ss.request.payload[11])), uuu+1, 2);   // throttle
    //memcpy((char*)(&(ss.request.payload[1])), payload64, MAVLINK_MSG_ID_VFR_HUD_LEN /*20*/);  
    //ROS_INFO("heading: %hu", *(uuu));
    ss.request.len = 13;
    call_stat = client.call(ss);
  }
  // heartbeat from autopilot
  else if(rmsg.msgid == 0){
    ss.request.payload[0] = 0;

    uint8_t * u8 = (uint8_t*)payload64;
    uint32_t cusm = (uint32_t)(*u8);
    ROS_INFO("base mode: %d, custom mode: %d, status: %d", *(u8+6), cusm,*(u8+7));
    ss.request.payload[0] = 0;
    memcpy((char*)(&(ss.request.payload[1])), &cusm, 4); // custom mode
    memcpy((char*)(&(ss.request.payload[5])), u8+6, 1);  // MAV_MODE_FLAG
    memcpy((char*)(&(ss.request.payload[6])), u8+7, 1);  // MAV_STATE
    memcpy((char*)(&(ss.request.payload[7])), &fix_type, 1);  // GPS fix type 
                                                              // (0-1: no fix, 2: 2D fix, 3: 3D fix, 4: DGPS, 5: RTK)
    ss.request.len = 8;

    // broadcasd heartbeat
    ss.request.target_id = 0x00;
    call_stat = client.call(ss);
    call_stat = client_ch2.call(ss);
  }

  if(call_stat){
    switch(ss.response.err){
      case 0: 
              break;
      case 1: ROS_ERROR("uav_stat_monitor sending failed: invalid channel");
              break;
      case 2: ROS_ERROR("uav_stat_monitor sending failed: channel not initialized");
              break;
      case 3: ROS_ERROR("uav_stat_monitor sending failed: sending failed");
              break;
      default: ROS_ERROR("uav_stat_monitor sending failed: unknown failure");
              break;
      }
  }
}

/**
 * @brief Report battery status to GCS
 */
void battery_callback(const mavros_msgs::BatteryStatus msg)
{
  static uint8_t cnt = 0;
  cnt += 1;
  // don't report battery too often
  if(cnt == 4){
    cnt = 0;
    uav_control::datalink_send ss;
    ss.request.source_id = sysid;
    ss.request.target_id = 0x00;
    ss.request.route = 2;
  
    ss.request.len = 7;
    ss.request.payload[0] = 75;
    int16_t vol, cur, rem;
    vol = (int16_t)(msg.voltage * 100);   // voltage, in centivolt
    cur = (int16_t)(msg.current * 100);   // current, in centiiamp
    rem = (int16_t)(msg.remaining * 100); // remainning, in percentage
    memcpy((char*)(&(ss.request.payload[1])), &(vol), 2);
    memcpy((char*)(&(ss.request.payload[3])), &(cur), 2);
    memcpy((char*)(&(ss.request.payload[5])), &(rem), 2);
    if(client.call(ss)){
      switch(ss.response.err){
        case 0: 
                break;
        case 1: ROS_ERROR("uav_stat_monitor sending failed: invalid channel");
                break;
        case 2: ROS_ERROR("uav_stat_monitor sending failed: channel not initialized");
                break;
        case 3: ROS_ERROR("uav_stat_monitor sending failed: sending failed");
                break;
        default: ROS_ERROR("uav_stat_monitor sending failed: unknown failure");
                break;
      }
    }
  }
}


/**
 *  @brief Report to GCS arming / disarming state of the uav
 */
void state_callback(const mavros_msgs::State msg){
  uav_control::datalink_send ss;
  ss.request.source_id = sysid;
  ss.request.target_id = 0x00;
  ss.request.route = 2;

  ss.request.len = 4 + msg.mode.length() + 1;
  ss.request.payload[0] = 29;
  ss.request.payload[1] = msg.connected ? 'T' : 'F';
  ss.request.payload[2] = msg.armed ? 'T' : 'F';
  ss.request.payload[3] = msg.guided ? 'T' : 'F';
  sprintf((char*)&(ss.request.payload[4]), "%s", msg.mode.c_str());
  
  if(client.call(ss)){
    switch(ss.response.err){
      case 0: 
              break;
      case 1: ROS_ERROR("uav_stat_monitor sending failed: invalid channel");
              break;
      case 2: ROS_ERROR("uav_stat_monitor sending failed: channel not initialized");
              break;
      case 3: ROS_ERROR("uav_stat_monitor sending failed: sending failed");
              break;
      default: ROS_ERROR("uav_stat_monitor sending failed: unknown failure");
              break;
    }
  }
}


/**
 * @brief Monitor heartbeat signals from GCS
 *        used to check whether connection with GCS is still healthy
 */
void gcs_callback(const uav_control::DFrame msg)
{
  // update connection status
  time_last_msg_gcs = ros::Time::now().toSec();
}


/**
 * @brief Monitor status of quadcopter
 *        record current status (loaction, etc) of quadcopter
 *        check whether connection with quadcopter is still healthy
 */
void quad_callback(const uav_control::DFrame msg)
{
  // update connection status
  time_last_msg_quad = ros::Time::now().toSec();

}

