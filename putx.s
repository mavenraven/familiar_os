; putx
; Writes a hex value to the terminal and to serial port, with a new line.
; parameter 1: 16 bit hex value to be printed.

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

%ifndef HEX_TO_STR
  %define HEX_TO_STR
  %include "hex_to_str.s"
%endif


putx:
  prologue
  
  push 0x90
  mov bx, [esp + 10 + 2 + 20 + 4]
  push bx
  call hex_to_str

  push 0x90
  call puts

  epilogue 1
  ret
