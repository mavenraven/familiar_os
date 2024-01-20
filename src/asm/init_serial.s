; init_serial
; Initializes serial port. See from http://www.plantation-productions.com/Webster/www.artofasm.com/DOS/ch13/CH13-3.html

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

%ifndef PUTX
  %define PUTX
  %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

init_serial:
  prologue
  mov ah, 0
  mov dx, 0
  mov al, 0b10100011
  int 0x14

  epilogue 0
  ret
