#!/bin/sh

# TODO: build custom VM image for Matryoshka
IMGURL_DEFAULT="https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.2-x86_64.iso"
HDASIZE_DEFAULT="1G"

rm -rf vm && mkdir vm
cd alproot


# Alproot

./alproot-setup.sh

# Cleanup
# TODO: bind mount Alproot /vm to contents of VM
./alproot.sh rm -rf /vm /hda /img
./alproot.sh mkdir /vm /hda /img

# QEMU + deps (STRICTLY NO KVM)
./alproot.sh apk update
./alproot.sh apk add qemu qemu-img qemu-system-x86_64 aria2


# QEMU

# Get default image
# TODO: be able to specify vdisk image size in args (-s?)
# TODO: selection of non-default images: args via -u url or -f file.iso (TBD)
./alproot.sh aria2c $IMGURL_DEFAULT --dir=/img
IMG=$(./alproot.sh ls -AU /img | head -1)

HDA=/hda/hda.qcow2
HDASIZE=$HDASIZE_DEFAULT

./alproot.sh qemu-img create -f $HDA $HDASIZE
./alproot.sh qemu-system-x86_64 -m 512 -nic user -boot d -cdrom $IMG -hda $HDA -nographic
