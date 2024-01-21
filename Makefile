o ?= familiar_os

all: build/$(o).img

build/$(o).img: src/*.s
	mkdir -p build
	cd src && nasm -f bin -o ../$(o).img init.s

.PHONY: clean
clean:
	rm -rf build/$(o).img

.PHONY: run
run: all
	
	./run-qemu.sh $(o).img
