; hex_to_str
; Converts a 16 bit value to its hex string representation, null terminated.
; parameter 1: Address of buffer to write string to.
; parameter 2: 16 bit hex value to be printed.

putx:
  push ax
  push bx
  push cx
  push dx
  pushfd

  mov bx, [esp+16]
  mov cx, [esp+12]
  mov [esp+14], cx

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
  call write_char
  add cx, 1
  cmp cx, 4
  jl .print_loop

  push 0x0a
  call write_char

  push 0x0d
  call write_char

  popfd
  pop dx
  pop cx
  pop bx
  pop ax

  add esp, 2
  ret
