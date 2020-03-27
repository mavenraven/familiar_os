; write_char
; Writes a character to the terminal and to the serial port.
; parameter 1: The character to be printed.
write_char:
  push ax
  push bx
  push cx
  push dx
  pushfd

  mov bx, sp
  add bx, 14
  mov bx, [bx]

  mov ah, 0x0e
  mov al, bl
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  popfd
  pop dx
  pop cx
  pop bx
  pop ax

  ret
