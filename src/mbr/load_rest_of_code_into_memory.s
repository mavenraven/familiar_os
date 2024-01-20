; load_rest_of_code_into_memory
; Loads code past boot sector into memory, starting at 0x7c00 + 512.
; parameter 2: Address to read from. Should be a label that points at the first byte past the boot sector.
; parameter 1: Drive to read from. This is set in dx by the BIOS before handing control to us.

%ifndef PRINT
  %define PRINT
  %include "print.s"
%endif

%ifndef PUTX
  %define PUTX
  %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

drive: db 'drive: ', 0
load_location: db 'load location: ', 0
sectors_read: db 'sectors read: ', 0
disk_load_return_code: db 'return code ', 0

load_rest_of_code_into_memory:
  prologue

  mov bx, [param1]
  mov dx, bx
  
  push drive
  call print
  
  push dx
  call putx

  mov ax, 0
  mov es, ax
  mov bx, [param2]

  push load_location
  call print
  
  push bx
  call putx


  mov ah, 0x2
  mov al, 2 ; This will need to be adjusted as our program gets bigger.
  mov ch, 0
  mov cl, 2 
  mov dh, 0
  
  int 0x13
  mov bx, ax

  push disk_load_return_code
  call print

  and bx, 0xff00
  shr bx, 8
  push bx
  call putx

  push sectors_read
  call print
  
  and ax, 0x00ff
  push ax
  call putx

  epilogue 2
  ret
