#! /bin/bash

## This script stops ollama container, if found, and reloads the nvidia driver

# for some reason, the only way this works is if we can cd into the directory containing the docker compose file.
cd /home/benkalmus/work/ollama || true
sleep 30
docker compose down
sleep 1
rmmod nvidia_uvm
modprobe nvidia_uvm
sleep 1
docker compose up -d
