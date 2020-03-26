; prints a null terminated string to the terminal and to COM1 [with new line]
puts:
  push bx
  push ax
  push dx

  mov bx, sp
  add bx, 4
  mov bx, [bx]
  
.while:
  mov al, [bx]
  cmp al, 0x00
  je .end

  mov ah, 0x0e
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  inc bx
  jmp .while
.end:
  mov al, 0x0a
  mov ah, 0x0e
  int 0x10

  mov al, 0x0d
  int 0x10

  mov al, 0x0a
  mov dx, 0
  mov ah, 1
  int 0x14

  pop dx
  pop ax
  pop bx

  ret
