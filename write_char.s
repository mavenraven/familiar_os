; write_char
; Writes a character to the terminal and to the serial port.
; parameter 1: The character to be printed.

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

write_char:
  prologue

  mov bx, [param1]

  mov ah, 0x0e
  mov al, bl
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  epilogue 1
  ret
