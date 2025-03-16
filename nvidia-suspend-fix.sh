#! /bin/bash

## This script stops ollama container, if found, and reloads the nvidia driver

# CONTAINER=$(docker ps --format '{{.Names}}' | grep ollama)
# if [[ -n $CONTAINER ]]; then
#     docker stop "$CONTAINER"
# fi
cd /home/benkalmus/work/ollama || true
sleep 30
docker compose down
sleep 1
rmmod nvidia_uvm
modprobe nvidia_uvm
sleep 1
docker compose up -d
# if [[ -n $CONTAINER ]]; then
#     docker start "$CONTAINER"
# fi
