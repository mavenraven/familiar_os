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

main:
  push hello
  call puts

times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0
