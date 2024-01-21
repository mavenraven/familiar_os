; hex_to_str
; Converts a 16 bit value to its hex string representation, null terminated.
; parameter 2: Address of buffer to write string to.
; parameter 1: 16 bit hex value to be printed.

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

hex_to_str:
  prologue
  mov ax, [param2]
  mov bx, [param1]
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
  mov bx, ax
.copy_loop:
  pop dx
  mov [bx], dx
  add bx, 1
  add cx, 1
  cmp cx, 4
  jl .copy_loop

  ; null terminate
  mov dx, 0
  mov [bx], dx

  epilogue 2
  ret
