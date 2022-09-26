#!/usr/bin/expect -f
set timeout -1

# Setup VM
spawn qemu-system-x86_64 -m 4096  -netdev user,id=vm0 -device e1000,netdev=vm0 -boot d -cdrom /img/image.iso -hda /tmp/matryoshka/hda.qcow2 -nographic

expect "localhost login: "
send "root\r"

expect "localhost:~# "
send "setup-alpine -f scripts/setup-alpine.txt\r"

expect "alpine:~# "
send "echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories\r"

expect "alpine:~# "
send "apk update\r"

expect "alpine:~# "
send "apk add docker openrc\r"

expect "alpine:~# "
send "poweroff\r"

