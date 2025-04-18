FROM ros:noetic-ros-core

ENV DEBIAN_FRONTEND=noninteractive

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