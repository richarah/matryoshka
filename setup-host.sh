#!/bin/sh
# TODO: swap this for regex that gets the dir *the script* is located in
MATRYOSHKA_ROOT=$PWD

# TODO: build custom VM image for Matryoshka
IMGURL_DEFAULT="https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.2-x86_64.iso"
HDASIZE_DEFAULT="4G"

# Directory to be bind-mounted to VM root directory
rm -rf vm && mkdir /vm

# Alproot
cd alproot
./alproot-setup.sh

# Bind mount
alias alp="./alproot.sh -b /tmp/matryoshka.qcow2 "

# Scripts (primarily for networking)
cp -r $MATRYOSHKA_ROOT/scripts env/scripts

# QEMU + deps (STRICTLY NO KVM)
alp rm -rf /img /vm
alp mkdir /img /vm

alp setup-alpine -q
alp apk update
alp apk add qemu qemu-modules qemu-img qemu-system-x86_64 aria2 openrc libvirt-daemon openvpn openssh expect
alp rc-update add libvirtd

# Get default image
# TODO: be able to specify vdisk image size in args (-s?)
# TODO: selection of non-default images: args via -u url or -f file.iso (TBD)
alp aria2c $IMGURL_DEFAULT --out=/img/image.iso

# Setup virtual disk
# TODO: custom disk size
HDASIZE=$HDASIZE_DEFAULT
alp qemu-img create -f qcow2 /tmp/matryoshka.qcow2 $HDASIZE

# Setup VM
alp ./scripts/setup-vm.sh
