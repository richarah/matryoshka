#!/bin/sh
# cd alproot && ./alproot.sh -b /tmp/matryoshka qemu-system-x86_64 -m 512 -netdev user,id=vm0 -device e1000,netdev=vm0 -boot d -cdrom /img/image.iso -hda /tmp/matryoshka/hda.qcow2 -nographic -smp $(nproc)

cd alproot && ./alproot.sh /scripts/do-live.exp $@
