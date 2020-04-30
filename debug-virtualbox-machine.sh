#!/bin/sh
set -eu

serial_console_output="$(pwd)/console_output"
./init-virtualbox-machine.sh "$@" "$serial_console_output"

VirtualBoxVM  \
    --startvm "$1" \
    --debug
