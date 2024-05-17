#!/bin/bash
set -ue
IMAGE_NAME=pnc:latest
NET_NAME=host
MODULE_NAME=pnc

docker run -it --rm \
  --privileged \
  --net ${NET_NAME} \
  --name ${MODULE_NAME} \
  --env="DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v /home/:/home/ \
  -v /tmp/:/tmp/ \
  ${IMAGE_NAME} \
  bash
