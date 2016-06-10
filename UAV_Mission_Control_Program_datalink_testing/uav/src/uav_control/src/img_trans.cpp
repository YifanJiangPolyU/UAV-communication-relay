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

#include "opencv2/opencv.hpp"

#include "sysid.h"
#include <uav_control/DFrame.h>
#include <uav_control/datalink_send.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/StreamRate.h>
#include <mavros_msgs/BatteryStatus.h>
#include <mavros_msgs/Mavlink.h>

#include <iostream>
#include <fstream>

using namespace cv;
using namespace std;

#define IMG_BLOCK_SIZE 128

const uint8_t sysid = SYSID;

ros::ServiceClient client;

void img_request_callback(const uav_control::DFrame msg);

int main(int argc, char **argv)
{ 
  
  ros::init(argc, argv, "img_trans");
  ros::NodeHandle n;

  /**
   * subscribes to msgs from GCS
   */
  ros::Subscriber sub_gcs = n.subscribe("/uav_control/datalink_in_ch1", 10, img_request_callback);

  /**
   * ROS service sending datalink frames to GCS
   */
  client = n.serviceClient<uav_control::datalink_send>("datalink_send_ch1");


  Mat src = imread("/home/yifan/git/uav-control-mavros/src/uav_control/uav_img.jpg");
  vector<uchar> buff;//buffer for coding
  vector<int> param = vector<int>(2);
  param[0]=CV_IMWRITE_JPEG_QUALITY;
  param[1]=100;//default(95) 0-100

  imencode(".jpg",src,buff,param);
  ROS_INFO("size: %d", (int)buff.size());

      int pkg_num = (int)ceil((double)(buff.size())/IMG_BLOCK_SIZE);
      int last_pkg_size = buff.size() % IMG_BLOCK_SIZE;
  ROS_INFO("pkg num: %d, last pkg: %d", pkg_num, last_pkg_size);

  ros::spin();


}// end of main



void img_request_callback(const uav_control::DFrame msg)
{
  // analyze msg
  if(msg.payload[0] == 10){

    uav_control::datalink_send ss;
    ss.request.source_id = sysid;
    ss.request.target_id = 0x01;
    ss.request.route = 0;

    static vector<uchar> buff;//buffer for coding
    static int16_t pkg_num;
    static int16_t last_pkg_size;
    
    // request new img
    if(msg.payload[1] == 'N'){

      ROS_INFO("img request received");

      // extract img information 
      Mat src = imread("/home/yifan/git/uav-control-mavros/src/uav_control/uav_img.jpg");
      
      vector<int> param = vector<int>(2);
      param[0]=CV_IMWRITE_JPEG_QUALITY;
      param[1]=90;//default(95) 0-100
      int img_size = -1;
      int16_t block_size = IMG_BLOCK_SIZE;
      imencode(".jpg",src,buff,param);
      img_size = (int)buff.size();
      ROS_INFO("size: %d", img_size);
      
      pkg_num = (uint16_t)ceil((double)(buff.size())/IMG_BLOCK_SIZE);
      last_pkg_size = buff.size() % IMG_BLOCK_SIZE;

      // first, report the number of pkgs
      ss.request.payload[0] = 11;   // img reply msg_id
      ss.request.payload[1] = 0xFF; // 2 bytes uint16_t, pkg_cnt
      ss.request.payload[2] = 0xFF; // ==0xFFFF for reporting total pkg number
      memcpy((char*)(&(ss.request.payload[3])), &pkg_num, 2);
      memcpy((char*)(&(ss.request.payload[5])), &img_size, 4);
      memcpy((char*)(&(ss.request.payload[9])), &block_size, 2);
      
      ss.request.len = 11;
      client.call(ss);

      // ofstream myfile;
      // myfile.open ("/home/yifan/git/uav-control-mavros/src/uav_control/example.jpg", ios::out | ios::binary);
      // myfile.write ( (char*)(&(buff[0])), img_size);
    }
    // request retransmission 
    else if(msg.payload[1] == 'R'){
      int16_t pkg_cnt;
      memcpy(&pkg_cnt, (char*)(&(msg.payload[2])), 2);
      ROS_INFO("requested pkg: %d", (int)pkg_cnt);

      // construct pkg
      int i;
      uint8_t split_buff [512];
      int16_t split_buff_len;
      if(pkg_cnt != pkg_num-1){
        for(i=0; i<IMG_BLOCK_SIZE; i++)
          ss.request.payload[i+3] = buff[pkg_cnt*IMG_BLOCK_SIZE + i];
        split_buff_len = IMG_BLOCK_SIZE;
      }
      else{
        for(i=0; i<last_pkg_size; i++)
          ss.request.payload[i+3] = buff[pkg_cnt*IMG_BLOCK_SIZE + i];
        split_buff_len = last_pkg_size;
      }

      // send pkg
      ss.request.payload[0] = 11;
      memcpy((char*)(&(ss.request.payload[1])), &pkg_cnt, 2);   // pkg cnt
      ss.request.len = split_buff_len+3;
      //ros::Duration(0.02).sleep();
      client.call(ss);

    }
    // end transmission
    else if(msg.payload[1] == 'E'){

    }
  }
}

