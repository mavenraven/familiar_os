; puts
; Writes a string to the terminal and to the serial port, with a new line.
; parameter 1: Pointer to the null terminated string to be printed.

%ifndef WRITE_CHAR
  %define WRITE_CHAR
  %include "write_char.s"
%endif

puts:
  push ax
  push bx
  push cx
  push dx
  pushfd

  mov bx, sp
  add bx, 14
  mov bx, [bx]
  
.while:
  mov al, [bx]
  cmp al, 0x00
  je .end

  push ax
  call write_char

  inc bx
  jmp .while
.end:

  push 0x0a
  call write_char

  push 0x0d
  call write_char

  popfd
  pop dx
  pop cx
  pop bx
  pop ax

  ret
