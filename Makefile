all: build/unikernel.img

build/boot.img: src/asm/*.s
	mkdir -p build
	cd src/asm && nasm -f bin -o ../../build/boot.img init.s

build/post_boot.o: src/c/*.c
	mkdir -p build
	cd src/c && clang -ffreestanding -nostdlib *.c  -arch x86_64 -o ../../build/post_boot.o

build/post_boot_stripped.img: build/post_boot.o
	export PATH="$PATH":"/opt/homebrew/opt/binutils/bin"
	cd build && objcopy --remove-section '__TEXT.__unwind_info' -O binary post_boot.o post_boot_stripped.img

build/unikernel.img: build/boot.img build/post_boot_stripped.img
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
# 
# So why not just use a section directive either in the c code, or write the 
# the bootloader in AT&T syntax? The problem is the LLVM assembler has this:
#
# https://github.com/llvm/llvm-project/blob/02232307ce18c095ef0bf26b5cef23e4efbc1e4b/llvm/lib/MC/MCParser/DarwinAsmParser.cpp#L672-L675
#
# If I add a comma in the directive, it works as expected, but that actually makes the project
# MORE platform dependent than just depending on whatever linker we use doesn't do weird things
# with reordering the functions.
	cat build/boot.img build/post_boot_stripped.img > build/unikernel.img

clean:
	rm -rf build/*

.PHONY: run-osx
run-osx: all
	./run-qemu-osx.sh build/unikernel.img
