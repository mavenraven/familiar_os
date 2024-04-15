; puts_vga
; Writes a string to the terminal, with a new line.
; parameter 1: Pointer to the null terminated string to be printed.


%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

puts_vga:
  prologue
  mov ax, 0xB810
  mov di, 0xFE
  mov es, ax

  mov bx, [param1]

.while:
  mov al, [bx]
  cmp al, 0
  je .end

  mov ah, 0x07
  mov es:[di], ax

  inc bx
  add di, 2
  jmp .while

.end:
  epilogue 1
  ret
