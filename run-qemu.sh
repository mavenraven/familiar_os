#!/bin/sh
set -eu

qemu-system-x86_64 -drive file="$1",format=raw -serial stdio -display none & 
QEMU_PID=$!
sleep .5
kill -9 "$QEMU_PID"
