o ?= familiar_os

all: $(o).img


$(o).img: src/*.s
	cd src && nasm -f bin -o ../$(o).img init.s
clean:
	rm -rf $(o).img

.PHONY: run-osx
run-osx: all
	./run-qemu-osx.sh $(o).img

.PHONY: run-osx-coredump
run-osx-coredump: all
	./setup-qemu-for-osx-core-dumps.sh
	./run-qemu-osx-coredump.sh $(o).img
