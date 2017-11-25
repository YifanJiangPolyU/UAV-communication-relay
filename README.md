This is a set of ROS nodes and programs that implements a radio communication relay system for 2 UAVs.
This branch contains a testing feature: logging 3DR radio rssi.

## Dependencies
  1. ROS
  2. mavros
  3. mavlink

## Structure
  UAV_Mission_Control_Program/boot: contains scripts to automatically boot the nodes
  UAV_Mission_Control_Program/msg: contains ROS message definitions
  UAV_Mission_Control_Program/srv: contains ROS service definitions
  UAV_Mission_Control_Program/src: contains source code and header files
  UAV_Mission_Control_Program/include: contains additional header files

## Installation
  1. System requirements: Ubuntu 14.04 or above
  2. Pull from git repository
  3. Link UAV_Mission_Control_Program/ to your local catkin workspace
  4. Open sysid.h, change system id as needed (depending on whether this node is configures as mom or as son
  5. Build
  6. Open file UAV_Mission_Control_Program/boot/boot.sh, update PATH_TO_BOOT, PATH_TO_UAVPKG and PORT_VERIFIER to match your local directory names (use absolute path)
  7. Open file UAV_Mission_Control_Program/boot/uavboot, update the absolute path to the boot.sh script, and update USER and HOME variables to match your own user name and home directory.
  8. Copy UAV_Mission_Control_Program/boot/uavboot to /etc/init.d, so you can start is using service
  9. Add the path to PATH_TO_BOOT/boot.sh to /etc/rc.local, so the system starts itself when booting

## Possible improvements
  1. Possibility to replace boot.sh with roslaunch?
  2. Remove or at least centralize the use of hard-coded absolute paths.
