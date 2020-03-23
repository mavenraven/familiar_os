org 0x7c00
jmp main

hello: db 'hello world', 0x00

; from http://www.plantation-productions.com/Webster/www.artofasm.com/DOS/ch13/CH13-3.html
init_serial:
  mov ah, 0
  mov dx, 0
  mov al, 0b10100011
  int 0x14
  ret

; prints a null terminated string to the terminal and to COM1
puts:
  pop cx
  pop bx
  push cx
.begin:
  mov al, [bx]
  cmp al, 0x00
  je .end

  mov ah, 0x0e
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  inc bx
  jmp .begin
.end:
  ret

; prints a 16 bit hex value to the terminal and to COM1
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
  jle .convert_nibble_loop
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
  ret
  
main:
  call init_serial
  push hello
  call puts

  push 0x7c00
  call putx

times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0
