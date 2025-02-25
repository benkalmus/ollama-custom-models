#!/bin/sh

# ollama - systemd suspend/resume hook

case $1 in
# before suspend
# pre)  ;;
# after resume
post)
    rmmod nvidia_uvm &&
        modprobe nvidia_uvm &&
        docker compose restart
    ;;
esac
