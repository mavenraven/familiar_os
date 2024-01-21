SECTIONS
{
    . = 0x7E00; /* Start of C code after the bootloader which is 512 (0x200) bytes long */

    .text : AT(ADDR(.text)) {
        *(.text.main) /* The symbol for your main function */
        *(.text)      /* All other code */
    }

    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    .bss : { *(.bss*) }
}
