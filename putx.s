putx:
  push ax
  push bx
  push cx
  push dx

  mov bx, sp
  add bx, 4
  mov bx, [bx]
  
  mov cx, 0
.convert_nibble_loop:
  mov dx, bx
  and dx, 0x000f
  cmp dx, 0x000a
  jl  .zero_to_nine
  jge .a_to_f
.zero_to_nine:
  add dx, 0x30
  push dx
  jmp .continue
.a_to_f:
  add dx, 87
  push dx
  jmp .continue
.continue:
  shr bx, 4
  add cx, 1
  cmp cx, 4
  jl .convert_nibble_loop
  mov cx, 0
.print_loop:
  mov ah, 0x0e
  pop bx
  mov al, bl
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  add cx, 1
  cmp cx, 4
  jl .print_loop

  mov al, 0x0a
  mov ah, 0x0e
  int 0x10

  mov al, 0x0d
  int 0x10

  mov al, 0x0a
  mov dx, 0

  mov dx, 0
  mov ah, 1
  int 0x14

  pop dx
  pop cx
  pop bx
  pop ax

  ret
