#!/bin/sh
cd alproot && ./alproot.sh qemu-system-x86_64 -m 512 -netdev user,id=vm0 -device e1000,netdev=vm0 -boot d -cdrom /img/image.iso -hda /hda/hda.qcow2 -nographic
