int write_char(int character) {
	__asm__(
		"mov $0x0E, %%ah\n"
		"mov $0x64, %%al\n"
		"int $0x10\n"

		: 
		:
		: "%ah", "%al"
	);

	__asm__(
		"mov $0x0, %%dx\n"
		"mov $0x64, %%al\n"
		"mov $0x01, %%ah\n"
		"int $0x14\n"

		: 
		:
		: "%dx", "%al", "%ah"
	);

   return 0;
}
