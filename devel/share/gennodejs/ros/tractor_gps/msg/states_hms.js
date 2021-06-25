// Auto-generated. Do not edit!

// (in-package tractor_gps.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class states_hms {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.year = null;
      this.month = null;
      this.day = null;
      this.hour = null;
      this.min = null;
      this.sec = null;
      this.data = null;
      this.std = null;
      this.age = null;
      this.Q = null;
      this.ns = null;
      this.ratio = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('year')) {
        this.year = initObj.year
      }
      else {
        this.year = 0;
      }
      if (initObj.hasOwnProperty('month')) {
        this.month = initObj.month
      }
      else {
        this.month = 0;
      }
      if (initObj.hasOwnProperty('day')) {
        this.day = initObj.day
      }
      else {
        this.day = 0;
      }
      if (initObj.hasOwnProperty('hour')) {
        this.hour = initObj.hour
      }
      else {
        this.hour = 0;
      }
      if (initObj.hasOwnProperty('min')) {
        this.min = initObj.min
      }
      else {
        this.min = 0;
      }
      if (initObj.hasOwnProperty('sec')) {
        this.sec = initObj.sec
      }
      else {
        this.sec = 0.0;
      }
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('std')) {
        this.std = initObj.std
      }
      else {
        this.std = new Array(6).fill(0);
      }
      if (initObj.hasOwnProperty('age')) {
        this.age = initObj.age
      }
      else {
        this.age = 0.0;
      }
      if (initObj.hasOwnProperty('Q')) {
        this.Q = initObj.Q
      }
      else {
        this.Q = 0;
      }
      if (initObj.hasOwnProperty('ns')) {
        this.ns = initObj.ns
      }
      else {
        this.ns = 0;
      }
      if (initObj.hasOwnProperty('ratio')) {
        this.ratio = initObj.ratio
      }
      else {
        this.ratio = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type states_hms
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [year]
    bufferOffset = _serializer.uint16(obj.year, buffer, bufferOffset);
    // Serialize message field [month]
    bufferOffset = _serializer.uint8(obj.month, buffer, bufferOffset);
    // Serialize message field [day]
    bufferOffset = _serializer.uint8(obj.day, buffer, bufferOffset);
    // Serialize message field [hour]
    bufferOffset = _serializer.uint8(obj.hour, buffer, bufferOffset);
    // Serialize message field [min]
    bufferOffset = _serializer.uint8(obj.min, buffer, bufferOffset);
    // Serialize message field [sec]
    bufferOffset = _serializer.float64(obj.sec, buffer, bufferOffset);
    // Check that the constant length array field [data] has the right length
    if (obj.data.length !== 3) {
      throw new Error('Unable to serialize array field data - length must be 3')
    }
    // Serialize message field [data]
    bufferOffset = _arraySerializer.float64(obj.data, buffer, bufferOffset, 3);
    // Check that the constant length array field [std] has the right length
    if (obj.std.length !== 6) {
      throw new Error('Unable to serialize array field std - length must be 6')
    }
    // Serialize message field [std]
    bufferOffset = _arraySerializer.float64(obj.std, buffer, bufferOffset, 6);
    // Serialize message field [age]
    bufferOffset = _serializer.float64(obj.age, buffer, bufferOffset);
    // Serialize message field [Q]
    bufferOffset = _serializer.uint8(obj.Q, buffer, bufferOffset);
    // Serialize message field [ns]
    bufferOffset = _serializer.uint8(obj.ns, buffer, bufferOffset);
    // Serialize message field [ratio]
    bufferOffset = _serializer.float64(obj.ratio, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type states_hms
    let len;
    let data = new states_hms(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [year]
    data.year = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [month]
    data.month = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [day]
    data.day = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [hour]
    data.hour = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [min]
    data.min = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [sec]
    data.sec = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.float64(buffer, bufferOffset, 3)
    // Deserialize message field [std]
    data.std = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    // Deserialize message field [age]
    data.age = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Q]
    data.Q = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ns]
    data.ns = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ratio]
    data.ratio = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 104;
  }

  static datatype() {
    // Returns string type for a message object
    return 'tractor_gps/states_hms';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '492fd46042199508df6dd15363fd81e6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    uint16 year
    uint8 month
    uint8 day
    uint8 hour
    uint8 min
    float64 sec
    float64[3] data
    float64[6] std
    float64 age
    uint8 Q
    uint8 ns
    float64 ratio
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new states_hms(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.year !== undefined) {
      resolved.year = msg.year;
    }
    else {
      resolved.year = 0
    }

    if (msg.month !== undefined) {
      resolved.month = msg.month;
    }
    else {
      resolved.month = 0
    }

    if (msg.day !== undefined) {
      resolved.day = msg.day;
    }
    else {
      resolved.day = 0
    }

    if (msg.hour !== undefined) {
      resolved.hour = msg.hour;
    }
    else {
      resolved.hour = 0
    }

    if (msg.min !== undefined) {
      resolved.min = msg.min;
    }
    else {
      resolved.min = 0
    }

    if (msg.sec !== undefined) {
      resolved.sec = msg.sec;
    }
    else {
      resolved.sec = 0.0
    }

    if (msg.data !== undefined) {
      resolved.data = msg.data;
    }
    else {
      resolved.data = new Array(3).fill(0)
    }

    if (msg.std !== undefined) {
      resolved.std = msg.std;
    }
    else {
      resolved.std = new Array(6).fill(0)
    }

    if (msg.age !== undefined) {
      resolved.age = msg.age;
    }
    else {
      resolved.age = 0.0
    }

    if (msg.Q !== undefined) {
      resolved.Q = msg.Q;
    }
    else {
      resolved.Q = 0
    }

    if (msg.ns !== undefined) {
      resolved.ns = msg.ns;
    }
    else {
      resolved.ns = 0
    }

    if (msg.ratio !== undefined) {
      resolved.ratio = msg.ratio;
    }
    else {
      resolved.ratio = 0.0
    }

    return resolved;
    }
};

module.exports = states_hms;
