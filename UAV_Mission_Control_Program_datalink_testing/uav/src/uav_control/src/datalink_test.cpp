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



int main(int argc, char **argv)
{

  /**
   * Initialize　ROS system
   */
  ros::init(argc, argv, "datalink_test");

  /**
   * Create ROS access point
   */
  ros::NodeHandle n;

  ros::ServiceClient client = n.serviceClient<uav_control::datalink_send>("datalink_send_ch1");

  uav_control::datalink_send ss;
  ss.request.source_id = 0x00;  // send from GCS
  ss.request.target_id = 0x03;  // send to uav SON
  ss.request.route = 2;

  char test_msg1[30];
  char test_msg2[103];
  strcpy( &(test_msg1[0]), "this is a test message");
  strcpy( &(test_msg2[0]), "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890");


  while (ros::ok()){

    std::string inputString;
    std::cout << "enter 1 to perform delay test\n";
    std::cout << "enter 2 to perform datalink quality test\n";
    std::cout << "enter 9 to quit\n";
    std::cout << "Plese enter options: ";
    std::getline(std::cin, inputString);

    std::cout << "\n";

    if(inputString == "1"){
      std::cout << "your option is 1\n";
      std::cout << "1 DFrame will be transmitted, please use osciloscope to measure delay \n";
      std::cout << "press enter when ready: \n";
      std::getline(std::cin, inputString);
 
      // send testing messages
      memcpy((char*)(&(ss.request.payload[0])), &(test_msg1[0]), strlen(test_msg1));
      ss.request.len = strlen(test_msg1);
      bool call_res = client.call(ss);
      if(call_res)
        std::cout << "   success\n";
      else
        std::cout << "   fail\n";
    }
    else if( inputString == "2" ){
      std::cout << "your option is 2\n";
      std::cout << "your option is 1\n";
      std::cout << "500 DFrames of length 100 bytes will be transmitted (10 frames per second)\n";
      std::cout << "please examine CRC error rate at UAV Mom and Son using \"datalink_listener\" node \n";
      std::cout << "press enter when ready: \n";
      std::getline(std::cin, inputString);

      // send testing messages
      memcpy((char*)(&(ss.request.payload[0])), &(test_msg2[0]), strlen(test_msg2));
      ss.request.len = strlen(test_msg2);

      ros::Rate rate(10);

      int i = 0;
      for (i=0; i<500; i++){
          bool call_res = client.call(ss);
/*          if(call_res)
            std::cout << "   success\n";
          else
            std::cout << "   fail\n";
*/
         rate.sleep();
      }
      
      std::cout << "completed. \n";

    }
    else if( inputString == "9" ){
      std::cout << "quiting... \n";
      break;
    }
    else
      std::cout << "unknown option\n";

    std::cout << "\n";

  }// end of while loop

  return 0;
}
