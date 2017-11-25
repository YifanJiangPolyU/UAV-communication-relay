
#ifndef DATA_FORMAT_H
#define DATA_FORMAT_H


typedef struct __mavlink_global_position_int_t
{
 int32_t lat; ///< Latitude, expressed as * 1E7
 int32_t lon; ///< Longitude, expressed as * 1E7
 int32_t alt; ///< Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)
 int16_t vx; ///< Ground X Speed (Latitude), expressed as m/s * 100
 int16_t vy; ///< Ground Y Speed (Longitude), expressed as m/s * 100
 int16_t vz; ///< Ground Z Speed (Altitude), expressed as m/s * 100
} uav_global_position;


typedef struct __mavlink_attitude_t
{
 float roll; ///< Roll angle (rad, -pi..+pi)
 float pitch; ///< Pitch angle (rad, -pi..+pi)
 float yaw; ///< Yaw angle (rad, -pi..+pi)
} uav_orientation;


typedef struct __mavlink_vfr_hud_t
{
 float airspeed; ///< Current airspeed in m/s
 float groundspeed; ///< Current ground speed in m/s
 float alt; ///< Current altitude (MSL), in meters
 float climb; ///< Current climb rate in meters/second
 int16_t heading; ///< Current heading in degrees, in compass units (0..360, 0=north)
 uint16_t throttle; ///< Current throttle setting in integer percent, 0 to 100
} uav_vfr_hud;


typedef struct __uav_battery_t
{
  int16_t voltage; ///< expressed in V/100
  int16_t current; ///< expressed in A/100
  int16_t remaining; ///< expressed by a number from 0 (empty) to 100 (full)
} uav_battery;


#endif
