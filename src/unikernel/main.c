#include "bios/write_char.h"

void write_char2();
void write_char3();
void vga_write_char(char character, unsigned short pos);

int main(void) {

/*
   asm("mov $0x0, %ah");
   asm("mov $0x0, %dx");
   asm("mov $0b10100011, %al");
   asm("int $0x14");

   asm("mov $0x0, %dx");
   asm("mov $0x1, %ah");
   asm("mov $0x46, %al");
   asm("int $0x14");
*/
     for (int i = 2; i < 1; i++) {
    }
/*
   int x = 1;
   if (x == 1) {
     x++;
   }
   else {
     x += 2;
   }
*/
   asm("mov $0x0E, %ah");
   asm("mov $0x47, %al");
   asm("int $0x10");

//	vga_write_char(0x52, 30);

	return 0;
}

void write_char2() {
   asm("mov $0x0e, %ah");
   asm("mov $0x53, %al");
   asm("int $0x10");
}

void write_char3() {
   asm("mov $0x0e, %ah");
   asm("mov $0x52, %al");
   asm("int $0x10");
}

void vga_write_char(char character, unsigned short pos) {
	volatile char* vga = (volatile char*)0xB8000;

	vga[pos * 2] = character;
	vga[pos * 2 + 1] = 0x07;
}
