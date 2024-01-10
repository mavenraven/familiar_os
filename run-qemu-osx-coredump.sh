#!/bin/sh
set -eu
ulimit -c unlimited
killall -SIGKILL qemu-system-x86_64 || true
qemu-system-x86_64 -drive file="$1",format=raw -serial stdio  -m 128 -display none -netdev user,id=net0,hostfwd=tcp::19920-:19920 -device e1000,netdev=net0 -object filter-dump,id=f1,netdev=net0,file="$HOME"/dump.pcap &
QEMU_PID="$!"
echo 'helloworld' | nc 127.0.0.1 19920 &
sleep 1
/bin/kill -s SIGABRT "$QEMU_PID"
