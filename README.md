# Haru Docker containers
Docker containers for Haru projects.


## Setup
Set ROS variable with:
```
export HARU_IP=xxx.xxx.xx.xxx
export ROS_MASTER_URI=http://${HARU_IP}:11311
```

Build Haru-OS image with:
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

If you need CUDA:
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