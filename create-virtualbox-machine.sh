#!/bin/sh
set -eu

get_default_interface() {
    netstat -nr | grep -i Destination -A 1 | head -n 2 | tail -n 1 | awk '{print $6}'
}

serial_console_output="$(pwd)/console_output"

VBoxManage controlvm "$1" poweroff || true

rm "$serial_console_output" || true

VBoxManage unregistervm --delete "$1" || true


VBoxManage createvm --name "$1" --register

VBoxManage modifyvm "$1" \
    --nic1 bridged \
    --nictype1 Am79C970A \
    --bridgeadapter1 "$(get_default_interface)" \
    --uart1 0x3F8 4 \
    --uartmode1 file "$serial_console_output" \
    --bioslogodisplaytime 1


VBoxManage storagectl "$1" \
    --name "$1" \
    --add floppy \
    --bootable on

VBoxManage storageattach "$1" \
    --storagectl "$1" \
    --type fdd \
    --medium "$1.img" \
    --device 0

VBoxManage startvm "$1" \
    --type headless

tail -f "$serial_console_output"
