# Haru Docker containers
Docker containers for Haru projects.

## Install
Install the [Docker Engine](https://docs.docker.com/engine/install/ubuntu/) and follow the [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/).

For CUDA support, also install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-the-nvidia-container-toolkit).

## Setup
Set ROS variable with:
```
export ROS_DOMAIN_ID=xxx
```

Allow Docker GUI access:
```
xhost +local:root
```

## Images and Applications

### Haru-OS
```
docker build --rm -t haru/haru-os:ros2 -f haru-os/Dockerfile ./haru-os
```

Run:
```
docker run -it --rm --name haru-os --gpus all \
  --network host --ipc host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=${DISPLAY} -e ROS_DOMAIN_ID=${ROS_DOMAIN_ID} \
  haru/haru-os:ros2
```

Or compose: (recommended)
```
docker compose -f docker-compose-haru.yaml --env-file .env up
```
