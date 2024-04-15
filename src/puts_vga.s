; puts_vga
; Writes a string to the terminal, with a new line.
; parameter 1: Pointer to the null terminated string to be printed.


%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

puts_vga:
; don't forget to add a note that DS is implictliy used for [], I'll definitely ; forget that in 3 monts
  prologue

  mov ax, 0xB800
  mov es, ax
  mov di, 0x00
  mov bx, 0x0748
  mov [es:di], bx

  mov es, ax
  mov di, 0x02
  mov bx, 0x0765
  mov es:[di], bx

  mov es, ax
  mov di, 0x04
  mov bx, 0x076c
  mov [es:di], bx

  mov ax, 0xB800
  mov es, ax
  mov di, 0x06
  mov bx, 0x076c
  mov [es:di], bx

  epilogue 0
  ret
