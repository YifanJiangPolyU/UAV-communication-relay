// Generated by gencpp from file uav_control/channel_stat.msg
// DO NOT EDIT!


#ifndef UAV_CONTROL_MESSAGE_CHANNEL_STAT_H
#define UAV_CONTROL_MESSAGE_CHANNEL_STAT_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace uav_control
{
template <class ContainerAllocator>
struct channel_stat_
{
  typedef channel_stat_<ContainerAllocator> Type;

  channel_stat_()
    : header()
    , msg_received(0)
    , msg_crc_error(0)
    , msg_sent(0)  {
    }
  channel_stat_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , msg_received(0)
    , msg_crc_error(0)
    , msg_sent(0)  {
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef int32_t _msg_received_type;
  _msg_received_type msg_received;

   typedef int32_t _msg_crc_error_type;
  _msg_crc_error_type msg_crc_error;

   typedef int32_t _msg_sent_type;
  _msg_sent_type msg_sent;




  typedef boost::shared_ptr< ::uav_control::channel_stat_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::uav_control::channel_stat_<ContainerAllocator> const> ConstPtr;

}; // struct channel_stat_

typedef ::uav_control::channel_stat_<std::allocator<void> > channel_stat;

typedef boost::shared_ptr< ::uav_control::channel_stat > channel_statPtr;
typedef boost::shared_ptr< ::uav_control::channel_stat const> channel_statConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::uav_control::channel_stat_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::uav_control::channel_stat_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace uav_control

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'std_msgs': ['/opt/ros/jade/share/std_msgs/cmake/../msg'], 'uav_control': ['/home/yifan/Desktop/FYP Material/FYP Program/Raspberry_Pi_Program/uav/src/uav_control/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::uav_control::channel_stat_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::uav_control::channel_stat_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::uav_control::channel_stat_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::uav_control::channel_stat_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::uav_control::channel_stat_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::uav_control::channel_stat_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::uav_control::channel_stat_<ContainerAllocator> >
{
  static const char* value()
  {
    return "2dcae45f0eee8715910fd5d20620cc55";
  }

  static const char* value(const ::uav_control::channel_stat_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x2dcae45f0eee8715ULL;
  static const uint64_t static_value2 = 0x910fd5d20620cc55ULL;
};

template<class ContainerAllocator>
struct DataType< ::uav_control::channel_stat_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uav_control/channel_stat";
  }

  static const char* value(const ::uav_control::channel_stat_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::uav_control::channel_stat_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# channel statistics\n\
\n\
std_msgs/Header header\n\
int32  msg_received   # total number of msgs received over this channel\n\
int32  msg_crc_error  # number of msgs with CRC failure\n\
int32  msg_sent       # total number of msgs sent over this channel\n\
\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::uav_control::channel_stat_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::uav_control::channel_stat_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.msg_received);
      stream.next(m.msg_crc_error);
      stream.next(m.msg_sent);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct channel_stat_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::uav_control::channel_stat_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::uav_control::channel_stat_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "msg_received: ";
    Printer<int32_t>::stream(s, indent + "  ", v.msg_received);
    s << indent << "msg_crc_error: ";
    Printer<int32_t>::stream(s, indent + "  ", v.msg_crc_error);
    s << indent << "msg_sent: ";
    Printer<int32_t>::stream(s, indent + "  ", v.msg_sent);
  }
};

} // namespace message_operations
} // namespace ros

#endif // UAV_CONTROL_MESSAGE_CHANNEL_STAT_H
