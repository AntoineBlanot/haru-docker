#!/bin/bash

# Set GUI
export LIBGL_ALWAYS_INDIRECT=${LIBGL_ALWAYS_INDIRECT:-0}
export DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-/dev/null}

# Set ROS_MASTER_URI
export ROS_MASTER_URI=${ROS_MASTER_URI}

# Dynamically determine the container's IP address
export ROS_IP=$(hostname -I | awk '{print $1}')

echo "[INFO] Using ROS_MASTER_URI: $ROS_MASTER_URI"
echo "[INFO] Using ROS_IP: $ROS_IP"

# Source ROS
source /opt/ros/$ROS_DISTRO/setup.bash

# Source workspace if it exists
if [ -f /root/catkin_ws/devel/setup.bash ]; then
    source /root/catkin_ws/devel/setup.bash
fi

# Execute whatever command was passed to the container
exec "$@"
