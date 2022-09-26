#!/bin/sh

# TODO: build custom VM image for Matryoshka
IMGURL_DEFAULT="https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.2-x86_64.iso"
HDASIZE_DEFAULT="1G"

rm -rf vm && mkdir vm
cd alproot


# Alproot
./alproot-setup.sh
alias alp="./alproot.sh"

# QEMU + deps (STRICTLY NO KVM)
alp rm -rf /hda /img /vm
alp mkdir /hda /img /vm

alp apk update
alp apk add qemu qemu-img qemu-system-x86_64 aria2

# Get default image
# TODO: be able to specify vdisk image size in args (-s?)
# TODO: selection of non-default images: args via -u url or -f file.iso (TBD)
alp aria2c $IMGURL_DEFAULT --out=/img/image.iso

# Setup virtual disk
HDASIZE=$HDASIZE_DEFAULT
alp qemu-img create -f qcow2 /hda/hda.qcow2 $HDASIZE

# Setup VM
# TODO: headless setup-alpine
alp qemu-system-x86_64 -m 512 -nic user -boot d -cdrom /img/image.iso -hda /hda/hda.qcow2 -nographic
