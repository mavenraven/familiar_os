all: build/final_product.img
build_image_name=familiar_os_build_image

build/shellcheck_marker:scripts/*
	shellcheck scripts/*
	
build/build_image_marker: Dockerfile
	docker build -t ${build_image_name} .
	touch build/build_image_marker

build/mbr.img: src/mbr/* build/build_image_marker
	cd src/mbr && nasm -f bin -o ../../build/mbr.img init.s

build/unikernel.o: src/unikernel/* build/build_image_marker scripts/run-build-container.sh build/shellcheck_marker
	./scripts/run-build-container.sh ${build_image_name} ls /src/unikernel
	./scripts/run-build-container.sh ${build_image_name} gcc -Os -m16 -march=i386 -ffreestanding -nostdlib /src/unikernel/main.c -o /build/hello
	docker run --rm -v "${PWD}/src/unikernel:/src/unikernel" -v "${PWD}/build:/build" ${build_image_name} gcc --version
	cd src/unikernel && clang -ffreestanding -nostdlib -arch x86_64 main.c bios/write_char.c -o ../../build/unikernel.o

build/unikernel_stripped.img: build/unikernel.o
#homebrew doesn't put objcopy on the path. 
	cd build && PATH="${PATH}":"/opt/homebrew/opt/binutils/bin" objcopy --remove-section '__TEXT.__unwind_info' -O binary unikernel.o unikernel_stripped.img

build/final_product.img: build/mbr.img build/unikernel_stripped.img
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
	cat build/mbr.img build/unikernel_stripped.img > build/final_product.img

.PHONY: clean
clean:
	rm -rf build/*

run: build/final_product.img scripts/run-qemu.sh
# If you have your own source tree of QEMU in your home directory, this will pick up the binaries
# for you automatically.
	PATH="${HOME}/qemu/build:${PATH}" ./scripts/run-qemu.sh build/final_product.img
