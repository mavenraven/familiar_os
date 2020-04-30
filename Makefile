o ?= familiar_os

all: $(o).img


$(o).img: src/*.s
	cd src && nasm -f bin -o ../$(o).img init.s
clean:
	rm -rf $(o).img

.PHONY: run
run: all
	./run-virtualbox-machine.sh $(o)

.PHONY: debug
debug: all
	./debug-virtualbox-machine.sh $(o)
