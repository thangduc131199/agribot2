// Auto-generated. Do not edit!

// (in-package tractor_gps.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let states_hms = require('../msg/states_hms.js');

//-----------------------------------------------------------

class states_rtkRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type states_rtkRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type states_rtkRequest
    let len;
    let data = new states_rtkRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tractor_gps/states_rtkRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new states_rtkRequest(null);
    return resolved;
    }
};

class states_rtkResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.data = null;
    }
    else {
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = new states_hms();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type states_rtkResponse
    // Serialize message field [data]
    bufferOffset = states_hms.serialize(obj.data, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type states_rtkResponse
    let len;
    let data = new states_rtkResponse(null);
    // Deserialize message field [data]
    data.data = states_hms.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += states_hms.getMessageSize(object.data);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tractor_gps/states_rtkResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f2b37e695a8f10e8df0555b3b2850dbe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    states_hms data
    
    
    ================================================================================
    MSG: tractor_gps/states_hms
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
    const resolved = new states_rtkResponse(null);
    if (msg.data !== undefined) {
      resolved.data = states_hms.Resolve(msg.data)
    }
    else {
      resolved.data = new states_hms()
    }

    return resolved;
    }
};

module.exports = {
  Request: states_rtkRequest,
  Response: states_rtkResponse,
  md5sum() { return 'f2b37e695a8f10e8df0555b3b2850dbe'; },
  datatype() { return 'tractor_gps/states_rtk'; }
};
