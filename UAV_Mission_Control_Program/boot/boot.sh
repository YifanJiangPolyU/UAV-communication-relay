#!/bin/bash

##
## automatic start-up script for UAV
##

UAV_NAME="son"  # name of UAV: mom or son



PATH_TO_BOOT=/home/ubuntu/uav/src/uav_control/src/boot
PATH_TO_UAVPKG=/home/ubuntu/uav
PORT_VERIFIER=/home/ubuntu/uav/devel/lib/uav_control/verify_port_assignment
BOOT_LOG=~/.uav_control_boot_log
MOM_BYPASS="no"  # yes/no : whether the PixHawk of UAV mom is connected to the system or not
PIXHAWK_USB_PORT="/dev/ttyACM0"
SERIAL_PORT_CANDIDATES="/dev/ttyUSB0 /dev/ttyUSB1 /dev/ttyUSB2 /dev/ttyUSB3 /dev/ttyACM0"
SERIAL_PORT_LIST=""

SERIAL_PORT_PX4_DEFAULT="/dev/ttyACM0"
SERIAL_PORT_PX4="n"
SERIAL_PORT_TCH1="n"
SERIAL_PORT_TCH2="n"

UAV_NAME_SON="son"
UAV_NAME_MOM="mom"

SCREEN_ROSCORE="screen_roscore"
SCREEN_MAVROS="screen_mavros"
SCREEN_NODE="screen_ros_nodes"


echo "================================================================================" | tee -a $BOOT_LOG
echo "[`date`]starting UAV $UAV_NAME ..." | tee -a $BOOT_LOG

# add a delay, waiting to other system components to boot
echo "[`date`]  waiting for full system start-up ..."
sleep 10

  PORT_NUM=0
  if [ $UAV_NAME = $UAV_NAME_SON ]
  then
    PORT_NUM=2
  else
    if [ $MOM_BYPASS = "yes" ]
    then
      PORT_NUM=2
    else
      PORT_NUM=3
    fi
  fi

# looking for serial ports
# if not found, wait 1s before retry
  echo "[`date`]  checking existence of serial ports ..." | tee -a $BOOT_LOG
  while [ 0 ]
  do
    for port in $SERIAL_PORT_CANDIDATES
    do
      if [ -e "$port" ]
      then

         echo $SERIAL_PORT_LIST | grep --quiet -c $port
         if [ $? = 1 ]
         then
           echo "[`date`]      found new serial port: $port" | tee -a $BOOT_LOG
           echo "[`date`]          adding $port to list" | tee -a $BOOT_LOG
           SERIAL_PORT_LIST="$port "$SERIAL_PORT_LIST
           echo "[`date`]          port list: $SERIAL_PORT_LIST" | tee -a $BOOT_LOG
         fi
      fi
    done

    if [ `echo $SERIAL_PORT_LIST | wc -w` = $PORT_NUM ]
    then
      echo "[`date`]      have found enough serial ports" | tee -a $BOOT_LOG
      echo "[`date`]      done" | tee -a $BOOT_LOG
      break
    fi

    sleep 1
  done


# finds out which port is connected to which hardware, PixHawk, or telemetry
# by listening to serial port data stream
  echo "[`date`]  verifying port assignment ..." | tee -a $BOOT_LOG
  PORT_ARRAY=(${SERIAL_PORT_LIST// / })
  while [ 0 ]
  do
    if [ $UAV_NAME = $UAV_NAME_SON ]
    then
      echo "[`date`]      examining ${PORT_ARRAY[0]} ..." | tee -a $BOOT_LOG
      timeout 4 $PORT_VERIFIER ${PORT_ARRAY[0]}
      RES=$?
      if [ $RES = 0 ]
      then
        echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
        echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
        SERIAL_PORT_PX4=${PORT_ARRAY[0]}
        SERIAL_PORT_TCH1=${PORT_ARRAY[1]}
        break
      elif [ $RES = 1 ]
      then
        echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
        echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
        SERIAL_PORT_PX4=${PORT_ARRAY[1]}
        SERIAL_PORT_TCH1=${PORT_ARRAY[0]}
        break
      fi

      echo "[`date`]      examining ${PORT_ARRAY[1]} ..." | tee -a $BOOT_LOG
      timeout 4 $PORT_VERIFIER ${PORT_ARRAY[1]}
      RES=$?
      if [ $RES = 1 ]
      then
        echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
        echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
        SERIAL_PORT_PX4=${PORT_ARRAY[0]}
        SERIAL_PORT_TCH1=${PORT_ARRAY[1]}
        break
      elif [ $RES = 0 ]
      then
        echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
        echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
        SERIAL_PORT_PX4=${PORT_ARRAY[1]}
        SERIAL_PORT_TCH1=${PORT_ARRAY[0]}
        break
      fi
    fi

    if [ $UAV_NAME = $UAV_NAME_MOM ]
    then
      if [ $MOM_BYPASS = "yes" ] #bypass mom
      then
        echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
        echo "[`date`]      verified datalink ch2 port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
        SERIAL_PORT_TCH1=${PORT_ARRAY[0]}
        SERIAL_PORT_TCH2=${PORT_ARRAY[1]}
        break
      elif [ $MOM_BYPASS = "no" ] # don't bypass mom
      then
        echo "[`date`]      examining ${PORT_ARRAY[0]} ..." | tee -a $BOOT_LOG
        timeout 4 $PORT_VERIFIER ${PORT_ARRAY[0]}
        RES=$?
        if [ $RES = 0 ]
        then
          echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
          SERIAL_PORT_PX4=${PORT_ARRAY[0]}
        elif [ $RES = 1 ]
        then
          echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
          SERIAL_PORT_TCH1=${PORT_ARRAY[0]}
        elif [ $RES = 2 ]
        then
          echo "[`date`]      verified datalink ch2 port: ${PORT_ARRAY[0]}" | tee -a $BOOT_LOG
          SERIAL_PORT_TCH2=${PORT_ARRAY[0]}
        fi


        echo "[`date`]      examining ${PORT_ARRAY[1]} ..." | tee -a $BOOT_LOG
        timeout 4 $PORT_VERIFIER ${PORT_ARRAY[1]}
        RES=$?
        if [ $RES = 0 ]
        then
          echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
          SERIAL_PORT_PX4=${PORT_ARRAY[1]}
        elif [ $RES = 1 ]
        then
          echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
          SERIAL_PORT_TCH1=${PORT_ARRAY[1]}
        elif [ $RES = 2 ]
        then
          echo "[`date`]      verified datalink ch2 port: ${PORT_ARRAY[1]}" | tee -a $BOOT_LOG
          SERIAL_PORT_TCH2=${PORT_ARRAY[1]}
        fi


        echo "[`date`]      examining ${PORT_ARRAY[2]} ..." | tee -a $BOOT_LOG
        timeout 4 $PORT_VERIFIER ${PORT_ARRAY[2]}
        RES=$?
        if [ $RES = 0 ]
        then
          echo "[`date`]      verified PixHawk port: ${PORT_ARRAY[2]}" | tee -a $BOOT_LOG
          SERIAL_PORT_PX4=${PORT_ARRAY[2]}
        elif [ $RES = 1 ]
        then
          echo "[`date`]      verified datalink ch1 port: ${PORT_ARRAY[2]}" | tee -a $BOOT_LOG
          SERIAL_PORT_TCH1=${PORT_ARRAY[2]}
        elif [ $RES = 2 ]
        then
          echo "[`date`]      verified datalink ch2 port: ${PORT_ARRAY[2]}" | tee -a $BOOT_LOG
          SERIAL_PORT_TCH2=${PORT_ARRAY[2]}
        fi

        # check whether all ports are erified
        if [ $SERIAL_PORT_PX4 != "n" ] && [ $SERIAL_PORT_TCH1 != "n" ] && [ $SERIAL_PORT_TCH2 != "n" ]
        then
           break
        fi

      fi
    fi

    sleep 0.5
  done

  echo "[`date`]      all ports verified" | tee -a $BOOT_LOG
  echo "[`date`]      done" | tee -a $BOOT_LOG


# starting ROS Core
  if [ $UAV_NAME = $UAV_NAME_MOM ] && [ $MOM_BYPASS = "yes" ]
  then
    echo "[`date`]  starting ROS core ..." | tee -a $BOOT_LOG

    screen -d -m -S $SCREEN_ROSCORE ${PATH_TO_BOOT}/roscore_autostart.sh
    sleep 2
    echo "[`date`]      done" | tee -a $BOOT_LOG
  fi


# starting MAVROS
  if [ $UAV_NAME = $UAV_NAME_SON ] || [ $UAV_NAME = $UAV_NAME_MOM ]
  then
    echo "[`date`]  starting MAVROS ..." | tee -a $BOOT_LOG
    screen -d -m -S $SCREEN_MAVROS ${PATH_TO_BOOT}/mavros_autostart.sh $SERIAL_PORT_PX4
    sleep 15
    echo "[`date`]      done" | tee -a $BOOT_LOG

  fi

# starting necessary ROS nodes
  echo "[`date`]  starting ROS nodes ..." | tee -a $BOOT_LOG

  if [ $UAV_NAME = $UAV_NAME_SON ]
  then
    screen -d -m -S $SCREEN_NODE ${PATH_TO_BOOT}/son_node_autostart.sh $PATH_TO_UAVPKG $SERIAL_PORT_TCH1
    sleep 2

    screen -d -m -S screen_stat_monitor ${PATH_TO_BOOT}/uav_stat_monitor_autostart.sh $PATH_TO_UAVPKG
    sleep 2

  elif [ $UAV_NAME = $UAV_NAME_MOM ] && [ $MOM_BYPASS = "yes" ]
  then
    screen -d -m -S $SCREEN_NODE ${PATH_TO_BOOT}/mom_node_autostart.sh $PATH_TO_UAVPKG $SERIAL_PORT_TCH1 $SERIAL_PORT_TCH2 $MOM_BYPASS
    sleep 2

  elif [ $UAV_NAME = $UAV_NAME_MOM ] && [ $MOM_BYPASS = "no" ]
  then
    screen -d -m -S $SCREEN_NODE ${PATH_TO_BOOT}/mom_node_autostart.sh $PATH_TO_UAVPKG $SERIAL_PORT_TCH1 $SERIAL_PORT_TCH2 $MOM_BYPASS
    sleep 2

    screen -d -m -S screen_uav_stat  ${PATH_TO_BOOT}/uav_stat_monitor_autostart.sh $PATH_TO_UAVPKG
    sleep 2
  fi

  echo "[`date`]      done" | tee -a $BOOT_LOG

# everything finished
  echo "[`date`]  UAV $UAV_NAME system started and running ..." | tee -a $BOOT_LOG


# end of start-up script
echo "the end"
