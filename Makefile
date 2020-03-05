o ?= familiar_os

all: $(o).img

$(o).img: hello.s
	nasm -f bin -o $(o).img $<
clean:
	rm -rf $(o).img

