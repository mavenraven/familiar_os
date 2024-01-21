o ?= familiar_os

all: build/$(o).img

build/$(o).img: src/*.s
	mkdir -p build
	cd src && nasm -f bin -o ../build/$(o).img init.s

.PHONY: clean
clean:
	rm -rf build/$(o).img

.PHONY: run
run: all
	PATH="${HOME}/qemu/build:${PATH}" ./scripts/run-qemu.sh build/$(o).img
