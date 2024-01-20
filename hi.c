int hi3(void);
int main3(void) {
   asm("mov $0x0E, %ah");
   asm("mov $0x63, %al");
   asm("int $0x10");

   asm("mov $0x0, %dx");
   asm("mov $0x63, %al");
   asm("mov $0x01, %ah");
   asm("int $0x14");

   return 1 + hi3();
}

int hi3(void) {
   return 99;
}


