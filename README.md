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
cd haru-os
docker build -t haru-os -f Dockerfile .
```

Run it with:
```
docker run --name haru-os -it --rm \
  --network host \
  -e DISPLAY=${DISPLAY} \
  -e ROS_MASTER_URI=${ROS_MASTER_URI} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  haru-os
```

### Haru-OS-CUDA
```
cd haru-os-cuda
docker pull nvidia/cuda:12.4.1-cudnn-runtime-ubuntu20.04
docker build -t haru-os-cuda -f Dockerfile .
```

Run it with:
```
docker run --name haru-os-cuda --gpus all -it --rm \
  --network host \
  -e DISPLAY=${DISPLAY} \
  -e ROS_MASTER_URI=${ROS_MASTER_URI} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  haru-os-cuda
```

## Compose applications

### With a Haru
```
docker compose -f docker-compose-haru.yaml --env-file haru-os/.env up
# docker compose -f docker-compose-haru-cuda.yaml --env-file haru-os-cuda/.env up
```

### With a virtual Haru
```
docker compose -f docker-compose-virtual.yaml --env-file haru-os/.env up
# docker compose -f docker-compose-virtual-cuda.yaml --env-file haru-os-cuda/.env up
```
