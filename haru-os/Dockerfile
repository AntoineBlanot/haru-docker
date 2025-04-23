FROM ros:noetic-ros-core

ENV DEBIAN_FRONTEND=noninteractive

# System basics
RUN apt-get update && apt-get install -y \
    curl wget git sudo locales \
    iproute2 net-tools iputils-ping \
    alsa-utils \
    clang build-essential cmake \
    && rm -rf /var/lib/apt/lists/*

# ROS basics
RUN apt-get update && apt-get install -y \
    ros-noetic-rqt ros-noetic-rqt-common-plugins ros-noetic-rqt-robot-plugins \
    && rm -rf /var/lib/apt/lists/*

# Haru basics
RUN wget -O - http://robotics.upo.es/repos/focal_apt/debian/conf/harurepo.gpg.key | apt-key add -
RUN wget -nc -P /etc/apt/sources.list.d/ http://robotics.upo.es/repos/focal_apt/debian/conf/harufocal.list
RUN apt-get update && apt-get install -y \
    ros-noetic-idmind-tabletop-msgs \
    ros-noetic-strawberry-ros-msgs \
    && rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]