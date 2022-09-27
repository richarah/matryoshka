#!/bin/sh

service docker stop
service containerd stop
service containerd start
service docker start

