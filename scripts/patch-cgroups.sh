#!/bin/sh

# Fix cgroup error when trying to run Docker

service docker stop
service containerd stop
./cgroupfs/cgroupfs-umount.sh
./cgroupfs/cgroupfs-mount.sh
service containerd start
service docker start

