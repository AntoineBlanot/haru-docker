# Haru Docker containers
Docker containers for Haru projects.

## Install
Install the [Docker Engine](https://docs.docker.com/engine/install/ubuntu/) and follow the [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/).

For CUDA support, also install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-the-nvidia-container-toolkit).

## Setup
Set ROS variable with:
```
export HARU_IP=xxx.xxx.xx.xxx
export ROS_MASTER_URI=http://${HARU_IP}:11311
```

Allow Docker GUI access:
```
xhost +local:root
```

## Images and Applications

### Haru-OS
```
docker build --rm -t haru/haru-os:ros1 -f haru-os/Dockerfile ./haru-os
```

Run:
```
docker run -it --rm --name haru-os --gpus all \
  --network host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=${DISPLAY} -e ROS_MASTER_URI=${ROS_MASTER_URI} \
  haru/haru-os:ros1
```

Or compose: (recommended)
```
docker compose -f docker-compose-haru.yaml --env-file .env up
```

### Haru Simulator
```
docker build --rm -t haru/haru-simulator:ros1 -f haru-simulator/Dockerfile ./haru-simulator
```

Run:
```
docker run -it --rm --name haru-simulator --gpus all \
  --network host \
  --device /dev/snd \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=${DISPLAY} -e NVIDIA_DRIVER_CAPABILITIES=all \
  haru/haru-simulator:ros1
```

Or compose: (recommended)
```
docker compose -f docker-compose-simulator.yaml --env-file .env up
```

### Haru Virtual
```
docker compose -f docker-compose-virtual.yaml --env-file .env up
```
