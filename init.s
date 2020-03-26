org 0x7c00
jmp init

%include "putx.s"
%include "puts.s"
%include "init_serial.s"

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
  hello: db 'hello world', 0
  carry_flag: db 'carry flag:', 0
  return_code: db 'return code:', 0
  number_drives: db 'number of hard disk drives: ', 0
  logical_last_head: db 'last index of heads: ', 0
  logical_last_cylinder: db 'last index of cylinders: ', 0
  logical_last_sector: db 'last index of sectors: ', 0
  sectors_read: db 'sctrs read ', 0

output_drive_info:
  mov ah, 0x8
  mov dl, 0
  
  int 0x13
   
  pushf
  pop bx
  and bx, 0x0001
  push bx
  push carry_flag

  and ax, 0xff00
  shr ax, 8
  push ax
  push return_code

  mov bx, dx
  and bx, 0x00ff
  push bx
  push number_drives

  mov bx, dx
  and bx, 0xff00
  shr bx, 8
  push bx
  push logical_last_head
  
  mov bx, cx
  and bx, 0b0000000000111111
  push bx
  push logical_last_sector

  mov bx, cx
  and bx, 0b1111111100000000
  shr bx, 8
  and cx, 0b0000000011000000
  shl cx, 2
  or bx, cx
  push bx
  push logical_last_cylinder

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  ret

main:
  push hello
  call puts

  push sp
  call putx

times 2048 - ($ - $$) dw 0xface
