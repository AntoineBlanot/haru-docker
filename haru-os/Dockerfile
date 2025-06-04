FROM ros:noetic-ros-base

ENV DEBIAN_FRONTEND=noninteractive

# Fix ROS invalid apt key (tmp)
RUN rm /etc/apt/sources.list.d/ros1-latest.list \
    && rm /usr/share/keyrings/ros1-latest-archive-keyring.gpg

RUN apt-get update \
    && apt-get install -y ca-certificates curl

RUN export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}') ;\
    curl -L -s -o /tmp/ros-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" \
    && apt-get update \
    && apt-get install /tmp/ros-apt-source.deb \
    && rm -f /tmp/ros-apt-source.deb

# System basics
RUN apt-get update && apt-get install -y \
    curl wget git sudo locales \
    iproute2 net-tools iputils-ping \
    alsa-utils \
    clang build-essential cmake \
    python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# ROS basics
RUN apt-get update && apt-get install -y \
    ros-noetic-rqt ros-noetic-rqt-common-plugins ros-noetic-rqt-robot-plugins \
    && rm -rf /var/lib/apt/lists/*

# Haru basics
RUN wget -O - http://robotics.upo.es/repos/focal_apt/debian/conf/harurepo.gpg.key | apt-key add -
RUN wget -nc -P /etc/apt/sources.list.d/ http://robotics.upo.es/repos/focal_apt/debian/conf/harufocal.list

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]