org 0x7c00
jmp init

%include "putx.s"
%include "puts.s"
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

  push sp
  call putx

times 2048 - ($ - $$) dw 0xface
