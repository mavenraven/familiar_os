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
  push bx
  mov cx, 0

.loop:
  ;nibble 1
  pop bx
  shr bx, cl
  push bx
  and bx, 0x000F
  cmp bx, 0x000a
  jl  .zero_to_nine
  jge .a_to_f

.zero_to_nine:
  add bx, 0x30
  jmp .next

.a_to_f:
  add bx, 87
  jmp .next

.next:
  mov ah, 0x0e
  mov al, bl
  int 0x10
  add cx, 4
  cmp cx, 16
  jl .loop
  ret
  
main:
  push hello
  call puts

  push 0x6a
  call putx

times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0
