; puts_vga
; Writes a string to the terminal, with a new line.
; parameter 1: Pointer to the null terminated string to be printed.


%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

puts_vga:
  prologue

  mov ax, 0xB800
  mov ds, ax
  mov di, 0x00
  mov bx, 0x0748
  mov [ds:di], bx

  mov ds, ax
  mov di, 0x02
  mov bx, 0x0765
  mov [ds:di], bx

  mov ds, ax
  mov di, 0x04
  mov bx, 0x076c
  mov [ds:di], bx

  mov ax, 0xB800
  mov ds, ax
  mov di, 0x06
  mov bx, 0x076c
  mov [ds:di], bx

  epilogue 0
  ret
