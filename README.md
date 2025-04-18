# Haru Docker containers
Docker containers for Haru projects.


## Setup
Set ROS variable with:
```
export HARU_IP=xxx.xxx.xx.xxx
export ROS_MASTER_URI=http://${HARU_IP}:11311
export ROS_IP=$(hostname -I | awk '{print $1}')
```

Build Haru-OS image with:
```
cd haru-os
docker build -t haru-os -f Dockerfile .
```

Run it with:
```
docker run --name haru-os -it --rm \
  --network=host \
  -e ROS_MASTER_URI=${ROS_MASTER_URI} \
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
  --network=host \
  -e ROS_MASTER_URI=${ROS_MASTER_URI} \
  haru-os-cuda
```

## Compose applications

### With a Haru
```
docker compose -f docker-compose-haru.yaml up
# docker compose -f docker-compose-haru-cuda.yaml up
```

### With a virtual Haru
```
docker compose -f docker-compose-virtual.yaml up
# docker compose -f docker-compose-virtual-cuda.yaml up
```