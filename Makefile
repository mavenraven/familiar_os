o ?= familiar_os

all: $(o).img

$(o).img: hello.s
	nasm -f bin -o $(o).img $<
clean:
	rm -rf $(o).img

.PHONY: run
run: all
	qemu-system-x86_64 -m 4096 -drive file=$(o).img,format=raw -no-reboot
