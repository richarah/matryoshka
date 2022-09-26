#!/bin/bash

mkdir vm ; exit 0
rm -rf vm/* ; exit 0

cd alproot

./alproot-setup.sh
./alproot.sh apk update
./alproot.sh apk add qemu qemu-img qemu-system-x86_64
