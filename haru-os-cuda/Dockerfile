FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# System basics
RUN apt-get update && apt-get install -y \
    lsb-release gnupg2 \
    curl wget git sudo locales \
    iproute2 net-tools iputils-ping \
    alsa-utils \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=$LANG LC_ALL=$LC_ALL

# ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros1-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt-get update && apt-get install -y \
    ros-noetic-ros-core \
    python3-rosdep python3-pip python3-dev \
    clang build-essential cmake \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init && rosdep update

ENV ROS_DISTRO=noetic

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
COPY entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

# Use the custom entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]