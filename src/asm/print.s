; print
; Writes a string to the terminal and to the serial port.
; parameter 1: Pointer to the null terminated string to be printed.

%ifndef WRITE_CHAR
  %define WRITE_CHAR
  %include "write_char.s"
%endif

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

print:
  prologue
  mov bx, [param1]
  
.while:
  mov al, [bx]
  cmp al, 0x00
  je .end

  push ax
  call write_char 
  inc bx
  jmp .while

.end:
  epilogue 1
  ret
