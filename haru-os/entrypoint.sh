#!/bin/bash

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
