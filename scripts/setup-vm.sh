#!/usr/bin/expect -f
set timeout -1


# Setup VM
spawn qemu-system-x86_64 -m 4096  -netdev user,id=vm0 -device e1000,netdev=vm0 -boot d -cdrom /img/image.iso -hda /tmp/matryoshka/hda.qcow2 -nographic


# Root and headless install
expect "localhost login: "
send "root\r"
expect "localhost:~# "
send "setup-alpine -q\r"


# Fix repositories not being setup correctly by default
expect "alpine:~# "
send "echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories\r"

expect "alpine:~# "
send "echo 'https://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories\r"

expect "alpine:~# "
send "apk update\r"

expect "alpine:~# "
send "apk add docker openrc sfdisk syslinux\r"


# Setup data disk
expect "alpine:~# "
send "setup-disk -q -m data /dev/sda\r"

expect "alpine:~# "
send "poweroff\r"

