#!/bin/sh
set -eu

# see https://nasa.github.io/trick/howto_guides/How-to-dump-core-file-on-MacOS.html
sudo chmod 1777 /cores
sudo sysctl kern.coredump=1
rm segv.entitlements || true
/usr/libexec/PlistBuddy -c "Add :com.apple.security.get-task-allow bool true" segv.entitlements
codesign -s - -f --entitlements segv.entitlements `which qemu-system-x86_64` 
