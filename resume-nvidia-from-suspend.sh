#!/bin/sh

# ollama - systemd suspend/resume hook

case $1 in
# before suspend
# pre)  ;;
# after resume
post)
    docker ollama stop
    rmmod nvidia_uvm && modprobe nvidia_uvm
    docker ollama start
    ;;
esac
