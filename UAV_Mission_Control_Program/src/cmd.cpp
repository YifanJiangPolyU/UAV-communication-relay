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
#include "math.h"

#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Int32.h"
#include "mavlink/v1.0/common/mavlink.h"
#include "sysid.h"

#include <uav_control/DFrame.h>
#include <uav_control/datalink_send.h>

#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/Point.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/PositionTarget.h>
#include <mavros_msgs/CommandInt.h>
#include <mavros_msgs/CommandLong.h>
#include <mavros_msgs/CommandTOL.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/StreamRate.h>
#include <mavros_msgs/BatteryStatus.h>
#include <mavros_msgs/Mavlink.h>

/**
 *  subscriber callbacks
 */
void gcs_callback(const uav_control::DFrame msg);
void state_callback(const mavros_msgs::State msg);
void mavlink_callback(const mavros_msgs::Mavlink msg);

/**
 *  List of valid commands
 */
static const int cmd_num = 7;
static const char* cmd_list[7] = {
  "takeoff",		// 0 (action)
  "land",		// 1 (action)
  "goto",		// 2 go to a specific GPS location (action)
  "mission_start",	// 3 (action)
  "mission_abort",	// 4 (action)
  "rtl",		// 5 return to launch (action)
  "arm"                 // 6 arm/disarm the aircraft
};   


/**
 *  command execution status flag
 *  avoid execution of contradicting commands (i.e. landing during takeoff)
 */
static int cmd_current;
static bool cmd_running;
static bool rtl_running;

// current heading
static uint16_t heading;

ros::ServiceClient client_sendack;
ros::ServiceClient client_arm;
ros::ServiceClient client_takeoff;
ros::ServiceClient client_land;
ros::ServiceClient client_cmdlong;
ros::ServiceClient client_setmode;
ros::Publisher pub_setpoint_raw_local_ned;

/**
 *  current uav state
 */
mavros_msgs::State state;

/**
 *  system id
 */
const uint8_t sysid = SYSID;

int main(int argc, char **argv)
{

  ros::init(argc, argv, "gcs_monitor");
  ros::NodeHandle n;
  
  cmd_current = -1;
  cmd_running = false;
  rtl_running = false;

  state.connected = true;
  state.armed = false;
  state.guided = false;

  heading = 0;

  /**
   * subscribes to msgs from GCS
   */
  ros::Subscriber sub_gcs = n.subscribe("/uav_control/datalink_in_ch1", 10, gcs_callback);
  ros::Subscriber sub_state = n.subscribe("/mavros/state", 3, state_callback);
  ros::Subscriber sub_mavlink = n.subscribe("/mavlink/from", 5, mavlink_callback);

  pub_setpoint_raw_local_ned = n.advertise<mavros_msgs::PositionTarget>("/mavros/setpoint_raw/local", 10);

  // initialize service
  client_sendack = n.serviceClient<uav_control::datalink_send>("datalink_send_ch1");
  client_arm = n.serviceClient<mavros_msgs::CommandBool>("/mavros/cmd/arming");
  client_takeoff = n.serviceClient<mavros_msgs::CommandTOL>("/mavros/cmd/takeoff");
  client_land = n.serviceClient<mavros_msgs::CommandTOL>("/mavros/cmd/land");
  client_cmdlong = n.serviceClient<mavros_msgs::CommandLong>("/mavros/cmd/command");
  client_setmode = n.serviceClient<mavros_msgs::SetMode>("/mavros/set_mode");
  
  ros::MultiThreadedSpinner spinner(2);
  spinner.spin();

  return 0;
}


/**
 *  @brief update the current arming / disarming state of the uav
 */
void state_callback(const mavros_msgs::State msg){
  state = msg;
}


/**
 *  @brief  callback function, mavlink msg from uav
 */
void mavlink_callback(const mavros_msgs::Mavlink rmsg)
{
  // get current heading
  if(rmsg.msgid == 74){
    int64_t payload64[33];
    std::copy(rmsg.payload64.begin(), rmsg.payload64.end(), payload64);

    float * fff = (float*)payload64;
    uint16_t * uuu = (uint16_t*)(fff+4);
    memcpy(&heading, uuu, 2);   // heading
  }
}


/**
 *  @brief Analyze msgs received from GCS
 *         definition of msg_id, please refer to msg_id.txt
 */
void gcs_callback(const uav_control::DFrame msg)
{
  // do work only when the msg is actually targeted at us
  if(msg.target_id == SYSID){
    
    uint8_t msg_id = msg.payload[0];

    // emergency message, take care!
    if(msg_id == 1){
      
    }

    /**
     *  command from GCS
     */
    if(msg_id == 2){


      int i = 0;
      /**
       *  look for command
       */
      i = msg.payload[1];

      // construct common parts of cmd reply
      uav_control::datalink_send reply;
          reply.request.source_id = sysid;
          reply.request.target_id = GCS_ID;
          reply.request.route = 2;
          reply.request.payload[0] = 3;

      /**
       *  execute command
       */
      int cmd_prev = cmd_current;
      cmd_current = i;
        // take_off
        if(i==0){
          ROS_INFO("takeoff command received");

          float target_alt;
          memcpy(&target_alt, &(msg.payload[2]), sizeof(float));
          ROS_INFO("target altitude: %f", target_alt);

          mavros_msgs::CommandTOL sss;
          sss.request.min_pitch = 0;  // ignored by copter
          sss.request.yaw = 0;        // ignored by copter
          sss.request.latitude = 0;   // ignored by copter
          sss.request.longitude = 0;  // ignored by copter
          sss.request.altitude = target_alt;
          
          // send takeoff command to uav
          if(client_takeoff.call(sss))
             if(sss.response.success){
                 ROS_INFO("takeoff cmd accepted: %d", (int)sss.response.result);
                 reply.request.payload[1] = 0; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
             else{
                 ROS_INFO("takeoff cmd rejected: %d", (int)sss.response.result);
                 reply.request.payload[1] = 0; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
          

        }
        // land
        else if(i==1){
          ROS_INFO("land command received");

          mavros_msgs::CommandTOL sss;
          // land where it is
          sss.request.min_pitch = 0;
          sss.request.yaw = 0;
          sss.request.latitude = 0;
          sss.request.longitude = 0;
          sss.request.altitude = 0;
          
          // send land command to uav
          if(client_land.call(sss))
             if(sss.response.success){
                 ROS_INFO("land cmd accepted: %d", (int)sss.response.result);
                 reply.request.payload[1] = 1; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code;
                 reply.request.len = 4;
             }
             else{
                 // end execution if cmd is rejected
                 ROS_INFO("land cmd rejected: %d", (int)sss.response.result);
                 reply.request.payload[1] = 1; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
             }
             client_sendack.call(reply);
        }
        // goto
        else if(i==2){
          ROS_INFO("goto command received");

          double x, y, z, vx, vy, vz;
          // frame of reference: MAV_FRAME_LOCAL_NED
          memcpy(&x, &(msg.payload[2]), sizeof(double));
          memcpy(&y, &(msg.payload[10]), sizeof(double));
          memcpy(&z, &(msg.payload[18]), sizeof(double));
          memcpy(&vx, &(msg.payload[26]), sizeof(double));
          memcpy(&vy, &(msg.payload[34]), sizeof(double));
          memcpy(&vz, &(msg.payload[42]), sizeof(double));
          ROS_INFO("x: %f, y: %f, z: %f, vx: %f, vy: %f, vz: %f", x, y, z, vx, vy, vz);

          mavros_msgs::PositionTarget sss;
          sss.type_mask = 64+128+256;
          sss.position.x = x;
          sss.position.y = y;
          sss.position.z = z;
          sss.velocity.x = vx;
          sss.velocity.y = vy;
          sss.velocity.z = vz;
          
          // publish this msg to send a the cmd to uav via mavros
          pub_setpoint_raw_local_ned.publish(sss);
          
        }
        // mission_start
        else if(i==3){

        }
        // mission_abort
        else if(i==4){

        }
        // rtl
        else if(i==5){
          ROS_INFO("rtl (return to launch) command received");

          mavros_msgs::CommandLong sss;
          sss.request.broadcast = false;
          sss.request.command = MAV_CMD_NAV_RETURN_TO_LAUNCH;
          sss.request.confirmation = 0;
          // no param needed for RTL command
          sss.request.param1 = 0;  sss.request.param2 = 0;
          sss.request.param3 = 0;  sss.request.param4 = 0;
          sss.request.param5 = 0;  sss.request.param6 = 0;
          sss.request.param7 = 0;

          
          // send rtl command to uav
          if(client_cmdlong.call(sss))
             if(sss.response.success){
                 ROS_INFO("rtl cmd accepted: %d", (int)sss.response.result);
                 reply.request.payload[1] = 5; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
             else{
                 // end execution if cmd is rejected
                 ROS_INFO("rtl cmd rejected: %d", (int)sss.response.result);
                 reply.request.payload[1] = 5; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
                 goto end_of_execution;
             }
        }
        // arm
        else if(i==6){

          ROS_INFO("arm command received");

          mavros_msgs::CommandBool sss;
          if(msg.payload[2]=='T')
              sss.request.value = true;
          else 
              sss.request.value = false;
         
          if(client_arm.call(sss))
             if(sss.response.success){
                 ROS_INFO("action %s success: %d", (msg.payload[5]=='T')?"arm":"disarm", (int)sss.response.result);
                 reply.request.payload[1] = 6; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 10;
             }
             else{
                 ROS_INFO("action %s failed: %d", (msg.payload[5]=='T')?"arm":"disarm", (int)sss.response.result);
                 reply.request.payload[1] = 6; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 10;
             }
             ros::Duration(0.1).sleep();
             client_sendack.call(reply);
        }     
        // set mode
        else if(i==7){

          ROS_INFO("setmode command received");

          mavros_msgs::SetMode sss;
          sss.request.base_mode = 0;
          ROS_INFO("mode %d", (int)msg.payload[2]);
          if(msg.payload[2] == 0 )
              sss.request.custom_mode = "STABILIZE";
          else if(msg.payload[2] == 2 )
              sss.request.custom_mode = "ALT_HOLD";
          else if(msg.payload[2] == 3 )
              sss.request.custom_mode = "AUTO";
          else if(msg.payload[2] == 4 )
              sss.request.custom_mode = "GUIDED"; 
          else if(msg.payload[2] == 5 )
              sss.request.custom_mode = "LOITER";
          else if(msg.payload[2] == 6 )
              sss.request.custom_mode = "RTL";
          else if(msg.payload[2] == 9 )
              sss.request.custom_mode = "LAND";
          else if(msg.payload[2] == 16 )
              sss.request.custom_mode = "POSHOLD";
          else
              sss.request.custom_mode = "";

          if(client_setmode.call(sss))
             if(sss.response.success){
                 ROS_INFO("set mode success");
                 reply.request.payload[1] = 7; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.len = 3;
             }
             else{
                 ROS_INFO("set mode failed");
                 reply.request.payload[1] = 7; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.len = 3;
             }
           client_sendack.call(reply);
        }     
        // request home location
        else if(i==8){
          ROS_INFO("gethome command received");
          
          mavros_msgs::CommandLong sss;
          sss.request.broadcast = false;
          sss.request.command = MAV_CMD_GET_HOME_POSITION; // request home location
          sss.request.confirmation = 0;
          // no param needed
          sss.request.param1 = 0;  sss.request.param2 = 0;
          sss.request.param3 = 0;  sss.request.param4 = 0;
          sss.request.param5 = 0;  sss.request.param6 = 0;
          sss.request.param7 = 0;

          // send MAV_CMD_GET_HOME_POSITION to uav
          if(client_cmdlong.call(sss))
             if(sss.response.success){
                 ROS_INFO("gethome cmd accepted: %d", (int)sss.response.result);
                 reply.request.payload[1] = 8; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
             else{
                 // end execution if cmd is rejected
                 ROS_INFO("gethome cmd rejected: %d", (int)sss.response.result);
                 reply.request.payload[1] = 8; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
        }
        // set home location to current location
        else if(i==9){
          ROS_INFO("sethome command received");
          
          mavros_msgs::CommandLong sss;
          sss.request.broadcast = false;
          sss.request.command = MAV_CMD_DO_SET_HOME; // set (update) home location
          sss.request.confirmation = 0;

          sss.request.param1 = 1;  // 1: set current location as home
          sss.request.param2 = 0;
          sss.request.param3 = 0;  sss.request.param4 = 0;
          sss.request.param5 = 0;  sss.request.param6 = 0;
          sss.request.param7 = 0;

          // send MAV_CMD_GET_HOME_POSITION to uav
          if(client_cmdlong.call(sss))
             if(sss.response.success){
                 ROS_INFO("sethome cmd accepted: %d", (int)sss.response.result);
                 reply.request.payload[1] = 9; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
             else{
                 // cmd is rejected
                 ROS_INFO("sethome cmd rejected: %d", (int)sss.response.result);
                 reply.request.payload[1] = 9; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
        }
        // set yaw angle
        else if(i==10){
          ROS_INFO("turn command received");

          mavros_msgs::CommandLong sss;
          sss.request.broadcast = false; 
          sss.request.command = MAV_CMD_CONDITION_YAW; // set yaw angle
          sss.request.confirmation = 0;
          // useless params
          sss.request.param2 = 0;  sss.request.param5 = 0;
          sss.request.param6 = 0;  sss.request.param7 = 0;

          /* direction of turning
           *   0: absolute (0~360, 0 = north)
           *   1: cw
           *   2: ccw
           */
          int8_t direction = msg.payload[2];
          
          // number of degrees to turn
          uint16_t deg;
          memcpy(&deg, &(msg.payload[3]), sizeof(uint16_t));

          if(direction == 0){
            sss.request.param4 = 0; // abs
          }
          else if(direction == 1){
            sss.request.param4 = 1; // CW
            sss.request.param3 = 1;
          }
          else if(direction == 2){
            sss.request.param4 = 1; // CCW
            sss.request.param3 = -1;
          }

          sss.request.param1 = (float)deg;

          ROS_INFO("angle: %f", (float)deg);

          // send MAV_CMD_GET_HOME_POSITION to uav
          if(client_cmdlong.call(sss))
             if(sss.response.success){
                 ROS_INFO("turn cmd accepted: %d", (int)sss.response.result);
                 reply.request.payload[1] = 10; // cmd_id
                 reply.request.payload[2] = 'T'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
             else{
                 // cmd is rejected
                 ROS_INFO("turn cmd rejected: %d", (int)sss.response.result);
                 reply.request.payload[1] = 10; // cmd_id
                 reply.request.payload[2] = 'F'; // T = success, F = fail
                 reply.request.payload[3] = sss.response.result; // return code
                 reply.request.len = 4;
                 client_sendack.call(reply);
             }
        }
        // move forward at current heading
        else if(i==12){

          ROS_INFO("received setpoint_raw cmd");
          
          float vel;
          memcpy(&vel, &(msg.payload[2]), sizeof(float)); // valocity given in m/s

          mavros_msgs::PositionTarget sss;
          sss.type_mask = 0b0000111111000111;
          sss.velocity.x = vel * cos(heading * 3.14159 / 180);
          sss.velocity.y = vel * sin(heading * 3.14159 / 180);
          sss.velocity.z = 0;
          
          // publish this msg to send a the cmd to uav via mavros
          pub_setpoint_raw_local_ned.publish(sss);

        }
        // invalid cmd
        else{
          
        }
        
        end_of_execution:
          cmd_current = -1;   
    }

  }
}

