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

## Build images

### Haru-OS
```
docker build --rm -t haru-os -f haru-os/Dockerfile ./haru-os
```

Run it with:
```
docker run -it --rm --name haru-os \
  --network host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=${DISPLAY} \
  haru-os
```

### Haru-OS-CUDA
```
docker pull nvidia/cuda:12.4.1-cudnn-runtime-ubuntu20.04
docker build --rm -t haru-os-cuda -f haru-os-cuda/Dockerfile ./haru-os-cuda
```

Run it with:
```
docker run -it --rm --name haru-os-cuda --gpus all \
  --network host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=${DISPLAY} -e ROS_MASTER_URI=${ROS_MASTER_URI} \
  haru-os-cuda
```

### Haru-Simulator
```
docker build --rm -t haru-simulator -f haru-simulator/Dockerfile ./haru-simulator
```

Run it with:
```
docker run -it --rm --name haru-simulator --gpus all \
  --network host \
  --device /dev/snd \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=${DISPLAY} -e NVIDIA_DRIVER_CAPABILITIES=all \
  haru-simulator
```

## Compose applications

### With a Haru
```
docker compose -f docker-compose-haru.yaml --env-file .env up
```

### With a virtual Haru
```
docker compose -f docker-compose-simulator.yaml --env-file .env up
# docker compose -f docker-compose-virtual.yaml --env-file .env up
```
