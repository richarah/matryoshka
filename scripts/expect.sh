#!/usr/bin/expect -f

#starts guest vm, run benchmarks, poweroff
set timeout -1

#Start the guest VM
spawn qemu -nographic -hda guest.disk

expect "login: "
#Enter username
send "root\r"

expect "Password: "
send "\r"

send "setup-alpine -q && echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && apk update && apk add docker openrc && poweroff\r"

