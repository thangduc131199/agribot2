# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "tractor_gps: 1 messages, 1 services")

set(MSG_I_FLAGS "-Itractor_gps:/home/ducthang/agribot2/src/tractor/tractor_gps/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(tractor_gps_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" NAME_WE)
add_custom_target(_tractor_gps_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tractor_gps" "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" NAME_WE)
add_custom_target(_tractor_gps_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tractor_gps" "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" "std_msgs/Header:tractor_gps/states_hms"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tractor_gps
)

### Generating Services
_generate_srv_cpp(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tractor_gps
)

### Generating Module File
_generate_module_cpp(tractor_gps
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tractor_gps
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(tractor_gps_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(tractor_gps_generate_messages tractor_gps_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" NAME_WE)
add_dependencies(tractor_gps_generate_messages_cpp _tractor_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" NAME_WE)
add_dependencies(tractor_gps_generate_messages_cpp _tractor_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tractor_gps_gencpp)
add_dependencies(tractor_gps_gencpp tractor_gps_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tractor_gps_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tractor_gps
)

### Generating Services
_generate_srv_eus(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tractor_gps
)

### Generating Module File
_generate_module_eus(tractor_gps
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tractor_gps
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(tractor_gps_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(tractor_gps_generate_messages tractor_gps_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" NAME_WE)
add_dependencies(tractor_gps_generate_messages_eus _tractor_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" NAME_WE)
add_dependencies(tractor_gps_generate_messages_eus _tractor_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tractor_gps_geneus)
add_dependencies(tractor_gps_geneus tractor_gps_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tractor_gps_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tractor_gps
)

### Generating Services
_generate_srv_lisp(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tractor_gps
)

### Generating Module File
_generate_module_lisp(tractor_gps
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tractor_gps
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(tractor_gps_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(tractor_gps_generate_messages tractor_gps_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" NAME_WE)
add_dependencies(tractor_gps_generate_messages_lisp _tractor_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" NAME_WE)
add_dependencies(tractor_gps_generate_messages_lisp _tractor_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tractor_gps_genlisp)
add_dependencies(tractor_gps_genlisp tractor_gps_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tractor_gps_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tractor_gps
)

### Generating Services
_generate_srv_nodejs(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tractor_gps
)

### Generating Module File
_generate_module_nodejs(tractor_gps
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tractor_gps
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(tractor_gps_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(tractor_gps_generate_messages tractor_gps_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" NAME_WE)
add_dependencies(tractor_gps_generate_messages_nodejs _tractor_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" NAME_WE)
add_dependencies(tractor_gps_generate_messages_nodejs _tractor_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tractor_gps_gennodejs)
add_dependencies(tractor_gps_gennodejs tractor_gps_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tractor_gps_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tractor_gps
)

### Generating Services
_generate_srv_py(tractor_gps
  "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tractor_gps
)

### Generating Module File
_generate_module_py(tractor_gps
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tractor_gps
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(tractor_gps_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(tractor_gps_generate_messages tractor_gps_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/msg/states_hms.msg" NAME_WE)
add_dependencies(tractor_gps_generate_messages_py _tractor_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ducthang/agribot2/src/tractor/tractor_gps/srv/states_rtk.srv" NAME_WE)
add_dependencies(tractor_gps_generate_messages_py _tractor_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tractor_gps_genpy)
add_dependencies(tractor_gps_genpy tractor_gps_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tractor_gps_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tractor_gps)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tractor_gps
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(tractor_gps_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tractor_gps)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tractor_gps
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(tractor_gps_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tractor_gps)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tractor_gps
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(tractor_gps_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tractor_gps)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tractor_gps
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(tractor_gps_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tractor_gps)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tractor_gps\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tractor_gps
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(tractor_gps_generate_messages_py std_msgs_generate_messages_py)
endif()
