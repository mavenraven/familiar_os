org 0x7c00
jmp main
puts:
  pop cx
  pop bx
  push cx
.begin:
  mov dl, [bx]
  cmp dl, 0x00
  je .end
  mov ah, 0x0e
  mov al, [bx]
  int 0x10
  inc bx
  jmp .begin
.end:
  ret

hello: db 'hello world', 0x00
main:
  push hello
  call puts


times 0x1fe - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/questions/15687318/i386-real-mode-loading-from-floppy/15687536#15687536
times (512 * 2) - ($ - $$) db 0
