org 0x7c00
jmp main

hello: db 'hello world', 0x00
puts:
  pop cx
  pop bx
  push cx
  mov ah, 0x0e
.begin:
  mov al, [bx]
  cmp al, 0x00
  je .end
  int 0x10
  inc bx
  jmp .begin
.end:
  ret

putx:
  pop cx
  pop bx
  push cx
  mov cx, 0
.convert_nibble_loop:
  shr bx, cl
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
  add cx, 4
  cmp cx, 16
  jl .convert_nibble_loop
  mov cx, 0
.print_loop:
  mov ah, 0x0e
  pop bx
  mov al, bl
  int 0x10
  add cx, 1
  cmp cx, 4
  jl .print_loop
  ret
  
main:
  push hello
  call puts

.loop:
  mov al, [putx]
  push ax
  call putx
  jmp .loop

times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0
