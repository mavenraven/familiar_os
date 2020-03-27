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

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

putx:
  prologue
  
  mov bx, [param1]
  mov cx, bx

  sub sp, 2
  mov bx, sp
  push bx
  push cx
  call hex_to_str

  push bx
  call puts

  add sp, 2
  epilogue 1
  ret
