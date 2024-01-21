#!/bin/sh
set -eu
ulimit -c unlimited
killall -SIGKILL qemu-system-x86_64 || true
qemu-system-x86_64 -drive file="$1",format=raw -serial stdio  -m 128 -display none -netdev user,id=net0,hostfwd=tcp::19920-:19920 -device rtl8139,netdev=net0 -object filter-dump,id=f1,netdev=net0,file="$HOME"/dump.pcap &
