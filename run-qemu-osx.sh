#!/bin/sh
set -eu
killall -SIGKILL qemu-system-x86_64 || true
~/qemu/build/qemu-system-x86_64 -drive file="$1",format=raw -serial stdio  -m 128 -display none -netdev user,id=net0,hostfwd=tcp::19920-:19920 -device rtl8139,netdev=net0 -object filter-dump,id=f1,netdev=net0,file="$HOME"/dump.pcap &
QEMU_PID="$!"
echo '295985df-c7e6-45fd-b1da-c3de476ad8d5' | nc 127.0.0.1 19920 &
sleep 1
/bin/kill -9 "$QEMU_PID"
