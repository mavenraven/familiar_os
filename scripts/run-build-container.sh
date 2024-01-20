#!/bin/sh
set -eu

SRC_DIR=$(cd src/unikernel && pwd)
BUILD_DIR=$(cd build && pwd)

docker run --rm -v "$SRC_DIR:/src/unikernel" -v "$BUILD_DIR:/build" "$@"
