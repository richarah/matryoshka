#!/usr/bin/expect -f
set timeout -1

# Setup VM
spawn qemu-system-x86_64 -m 4096  -netdev user,id=vm0 -device e1000,netdev=vm0 -boot d -cdrom /img/image.iso -hda /tmp/matryoshka.qcow2 -nographic

expect "localhost login: "
send "root\r"

expect "localhost:~# "
send "setup-alpine -q && echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && apk update && apk add docker openrc && poweroff\r"

