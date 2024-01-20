o ?= familiar_os

all: boot.img,


bootloader: src/asm/*.s
	mkdir -p build
	cd src/asm && nasm -f bin -o ../../build/boot.img init.s

unikernal: src/c/*.c:
	mkdir -p build
	cd src/c && nasm -f bin -o ../../build/boot.img init.s


link: build/*:
     # This is super hacky, but it works at least on OS X.
     # The linker man page has this to say:
     #
     # The object files are loaded in the order in which they are specified on
     # the command line.  The segments and the sections in those segments will
     # appear in the output
     #
     # I would expect that, in practice, this is true of GNU ld as well as the BSD ld.
     #
     # So, what we do is take take our two built images and smush them together. The
     # jump at the end of the bootloader lines up with the location where the unikernal
     # begins, so it all works out...as long as main is always first in the text segment.
     #
     # You can verify this by running objdump -D on the unikernal, and checking the order
     # of the symbols. If main isn't first, that's why nothing is working.
     




clean:
	rm -rf $(o).img

.PHONY: run-osx
run-osx: all
	./run-qemu-osx.sh $(o).img

.PHONY: run-osx-coredump
run-osx-coredump: all
	./setup-qemu-for-osx-core-dumps.sh
	./run-qemu-osx-coredump.sh $(o).img
