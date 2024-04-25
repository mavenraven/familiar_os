o ?= familiar_os

all: build/$(o).img qemu/build/qemu-system-x86_64

qemu/build/qemu-system-x86_64: qemu/*
	mkdir -p qemu/build
	cd qemu/build && ../configure && make

build/$(o).img: src/*.s
	mkdir -p build
	cd src && nasm -f bin -o ../build/$(o).img init.s

.PHONY: clean
clean:
	rm -rf build/$(o).img

.PHONY: run
run: all
	PATH="${HOME}/qemu/build:${PATH}" ./scripts/run-qemu.sh build/$(o).img
