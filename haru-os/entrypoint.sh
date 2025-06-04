#!/bin/bash

# Set GUI
export LIBGL_ALWAYS_INDIRECT=${LIBGL_ALWAYS_INDIRECT:-0}
export DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-/dev/null}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/tmp/runtime-root}
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR
export QT_X11_NO_MITSHM=${QT_X11_NO_MITSHM:-1}

# Set CUDA
export NVIDIA_VISIBLE_DEVICES=${NVIDIA_VISIBLE_DEVICES:-all}
export NVIDIA_DRIVER_CAPABILITIES=${NVIDIA_DRIVER_CAPABILITIES:-compute,utility}

# Set ROS_MASTER_URI
export ROS_MASTER_URI=${ROS_MASTER_URI}

# Dynamically determine the container's IP address
export ROS_IP=$(hostname -I | awk '{print $1}')

echo "[INFO] Using ROS_MASTER_URI: $ROS_MASTER_URI"
echo "[INFO] Using ROS_IP: $ROS_IP"

# Source ROS distro environment
source /opt/ros/$ROS_DISTRO/setup.bash

# Source workspace overlay, if exists
if [ -f /root/catkin_ws/devel/setup.bash ]; then
    source /root/catkin_ws/devel/setup.bash
fi

# Execute whatever command was passed to the container
exec "$@"
