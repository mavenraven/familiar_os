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
  mov di, 0x00
  mov es, ax

  mov ax, [param1]

.while:
  mov bl, [ax]
  cmp bl, 0
  je .end


  mov bh, 0x07
  mov es:[di], bx

  inc ax
  add di, 2
  jmp .while

.end:
  epilogue 1
  ret
