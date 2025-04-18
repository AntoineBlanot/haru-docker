FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# System basics
RUN apt-get update && apt-get install -y \
    lsb-release gnupg2 curl wget git sudo locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=$LANG LC_ALL=$LC_ALL

# ROS Noetic core setup
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros1-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt-get update && apt-get install -y \
    ros-noetic-ros-core \
    python3-rosdep python3-pip \
    && rosdep init && rosdep update

ENV ROS_DISTRO=noetic

# Install necessary dependencies, including compilers, build tools, and catkin tools
RUN apt-get update && \
    apt-get install -y \
    build-essential cmake \
    curl git \
    ca-certificates wget \
    iproute2 net-tools iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Install Haru debian packages
RUN wget -O - http://robotics.upo.es/repos/focal_apt/debian/conf/harurepo.gpg.key | apt-key add -
RUN wget -nc -P /etc/apt/sources.list.d/ http://robotics.upo.es/repos/focal_apt/debian/conf/harufocal.list
RUN apt-get update && \
    apt-get install -y \
    ros-noetic-idmind-tabletop-msgs \
    && rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script into the container
COPY entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

# Use the custom entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]