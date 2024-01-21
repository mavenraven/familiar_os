#!/bin/sh
set -eu

serial_console_output="$(pwd)/console_output"
./init-virtualbox-machine.sh "$@" "$serial_console_output"

VBoxManage startvm "$1" \
    --type headless

tail -f "$serial_console_output"
