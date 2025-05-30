#!/bin/bash
set -e

# Set GUI
export LIBGL_ALWAYS_INDIRECT=${LIBGL_ALWAYS_INDIRECT:-0}
export DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-/dev/null}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/tmp/runtime-root}
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR
export QT_X11_NO_MITSHM=${QT_X11_NO_MITSHM:-1}

# Source ROS 2 distro environment
source "/opt/ros/$ROS_DISTRO/setup.bash"

# Source workspace overlay, if exists
if [ -f "/root/ros2_ws/install/setup.bash" ]; then
    source "/root/ros2_ws/install/setup.bash"
fi

# Execute whatever command was passed to the container
exec "$@"
