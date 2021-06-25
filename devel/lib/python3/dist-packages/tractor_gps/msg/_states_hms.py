# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from tractor_gps/states_hms.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import std_msgs.msg

class states_hms(genpy.Message):
  _md5sum = "492fd46042199508df6dd15363fd81e6"
  _type = "tractor_gps/states_hms"
  _has_header = True  # flag to mark the presence of a Header object
  _full_text = """Header header
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
"""
  __slots__ = ['header','year','month','day','hour','min','sec','data','std','age','Q','ns','ratio']
  _slot_types = ['std_msgs/Header','uint16','uint8','uint8','uint8','uint8','float64','float64[3]','float64[6]','float64','uint8','uint8','float64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       header,year,month,day,hour,min,sec,data,std,age,Q,ns,ratio

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(states_hms, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.header is None:
        self.header = std_msgs.msg.Header()
      if self.year is None:
        self.year = 0
      if self.month is None:
        self.month = 0
      if self.day is None:
        self.day = 0
      if self.hour is None:
        self.hour = 0
      if self.min is None:
        self.min = 0
      if self.sec is None:
        self.sec = 0.
      if self.data is None:
        self.data = [0.] * 3
      if self.std is None:
        self.std = [0.] * 6
      if self.age is None:
        self.age = 0.
      if self.Q is None:
        self.Q = 0
      if self.ns is None:
        self.ns = 0
      if self.ratio is None:
        self.ratio = 0.
    else:
      self.header = std_msgs.msg.Header()
      self.year = 0
      self.month = 0
      self.day = 0
      self.hour = 0
      self.min = 0
      self.sec = 0.
      self.data = [0.] * 3
      self.std = [0.] * 6
      self.age = 0.
      self.Q = 0
      self.ns = 0
      self.ratio = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs))
      _x = self.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_H4Bd().pack(_x.year, _x.month, _x.day, _x.hour, _x.min, _x.sec))
      buff.write(_get_struct_3d().pack(*self.data))
      buff.write(_get_struct_6d().pack(*self.std))
      _x = self
      buff.write(_get_struct_d2Bd().pack(_x.age, _x.Q, _x.ns, _x.ratio))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.header is None:
        self.header = std_msgs.msg.Header()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.header.frame_id = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 14
      (_x.year, _x.month, _x.day, _x.hour, _x.min, _x.sec,) = _get_struct_H4Bd().unpack(str[start:end])
      start = end
      end += 24
      self.data = _get_struct_3d().unpack(str[start:end])
      start = end
      end += 48
      self.std = _get_struct_6d().unpack(str[start:end])
      _x = self
      start = end
      end += 18
      (_x.age, _x.Q, _x.ns, _x.ratio,) = _get_struct_d2Bd().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs))
      _x = self.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_H4Bd().pack(_x.year, _x.month, _x.day, _x.hour, _x.min, _x.sec))
      buff.write(self.data.tostring())
      buff.write(self.std.tostring())
      _x = self
      buff.write(_get_struct_d2Bd().pack(_x.age, _x.Q, _x.ns, _x.ratio))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.header is None:
        self.header = std_msgs.msg.Header()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.header.frame_id = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 14
      (_x.year, _x.month, _x.day, _x.hour, _x.min, _x.sec,) = _get_struct_H4Bd().unpack(str[start:end])
      start = end
      end += 24
      self.data = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=3)
      start = end
      end += 48
      self.std = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=6)
      _x = self
      start = end
      end += 18
      (_x.age, _x.Q, _x.ns, _x.ratio,) = _get_struct_d2Bd().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_3I = None
def _get_struct_3I():
    global _struct_3I
    if _struct_3I is None:
        _struct_3I = struct.Struct("<3I")
    return _struct_3I
_struct_3d = None
def _get_struct_3d():
    global _struct_3d
    if _struct_3d is None:
        _struct_3d = struct.Struct("<3d")
    return _struct_3d
_struct_6d = None
def _get_struct_6d():
    global _struct_6d
    if _struct_6d is None:
        _struct_6d = struct.Struct("<6d")
    return _struct_6d
_struct_H4Bd = None
def _get_struct_H4Bd():
    global _struct_H4Bd
    if _struct_H4Bd is None:
        _struct_H4Bd = struct.Struct("<H4Bd")
    return _struct_H4Bd
_struct_d2Bd = None
def _get_struct_d2Bd():
    global _struct_d2Bd
    if _struct_d2Bd is None:
        _struct_d2Bd = struct.Struct("<d2Bd")
    return _struct_d2Bd