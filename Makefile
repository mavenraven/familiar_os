o ?= familiar_os

all: $(o).img

$(o).img: *.s
	nasm -f bin -o $(o).img init.s
clean:
	rm -rf $(o).img

.PHONY: run
run: all
	sudo qemu-system-x86_64 -net nic,model=pcnet -net tap,ifname=tap0,script=qemu-ifup.sh,downscript=no -m 4096 -drive file=$(o).img,format=raw -no-reboot -serial stdio
