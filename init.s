%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

org 0x7c00
jmp init

%include "puts.s"
%include "putx.s"
%include "init_serial.s"
%include "output_drive_info.s"

init:
  mov sp, 0x7c00

  push dx

  mov ax, 0
  mov es, ax
  mov bx, load

  mov ah, 0x2
  mov al, 1
  mov ch, 0
  mov cl, 2
  mov dh, 0
  pop dx
  and dx, 0x00ff

  int 0x13

  jmp main

times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0

load:
  %include "string_constants.s"

main:
  push hello
  call puts

  push hello
  call puts

  push 0xec00
  push 0xface
  call hex_to_str

  push 0xec00
  call puts
 
  mov bx, sp
  push 0xf700
  push bx
  call hex_to_str

  push 0xf700
  call puts

  push 0xcafe
  call putx

  push 0xeeee
  call putx

  mov bx, sp
  push bx
  call putx

times 2049 - ($ - $$) dw 0xdddd
