int hi(void);
int main(void) {
   asm("mov $0x0E, %ah");
   asm("mov $0x63, %al");
   asm("int $0x10");
   return 1 + hi();
}

int hi(void) {
   return 99;
}


