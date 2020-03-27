%ifndef PUTX
  %define PUTX
  %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

hello: db 'hello world', 0

main:
  sub sp, 8
  push sp
  push 0xface
  call hex_to_str

  push sp
  call puts
  add sp, 8

  mov ah, 0xb1
  mov al, 0x2

  mov cx, 0x2000
  mov dx, 0x1022
  mov si, 0
  
  int 0x1a

  and ax, 0xff00
  shr ax, 8
  push ax
  call putx
