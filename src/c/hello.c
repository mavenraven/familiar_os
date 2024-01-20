int hi(void);
int main(void) {
   asm("mov $0x0E, %ah");
   asm("mov $0x64, %al");
   asm("int $0x10");

   asm("mov $0x0, %dx");
   asm("mov $0x64, %al");
   asm("mov $0x01, %ah");
   asm("int $0x14");

   return 1 + hi();
}

int hi(void) {
   return 99;
}


