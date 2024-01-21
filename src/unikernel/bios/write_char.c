int write_char(char character) {
   asm("mov $0x0E, %ah");
   asm("mov $0x46, %al");
   asm("int $0x10");

/*
	__asm__(
		"mov $0x0E, %ah\n"
		"movb $0x46, %al\n"
		"int $0x10\n"

//		: 
//		: //"r"(character)
//		: // "%ah", "%al"
	);

	__asm__(
		"mov $0x0, %%dx\n"
		"movb %0, %%al\n"
		"mov $0x01, %%ah\n"
		"int $0x14\n"

		: 
		: "r"(character)
		: // "%dx", "%al", "%ah"
	);
*/

   return 0;
}
