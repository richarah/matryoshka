#!/usr/bin/expect -f

# 15 mins timeout
set timeout 900

#Start the guest VM
#spawn qemu -nographic -hda guest.disk
qemu-system-x86_64 -m 4096 -netdev user,id=vm0 -device e1000,netdev=vm0 -boot d -cdrom /img/image.iso -hda /tmp/matryoshka/hda.qcow2 -nographic

expect "login: "
send "root\r"

expect "Password: "
send "\r"

send "setup-alpine -q && echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && apk update && apk add docker openrc && poweroff\r"

