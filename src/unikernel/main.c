#include "bios/write_char.h"

int main(void) {
   asm("mov $0x0E, %ah");
   asm("mov $0x46, %al");
   asm("int $0x10");
   asm("mov $0x0E, %ah");
   asm("mov $0x49, %al");
   asm("int $0x10");
	write_char('a');
	write_char('b');
	write_char('c');
	write_char('c');
	return 0;
}
