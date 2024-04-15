; This needs to match the number of registers saved on the stack during
; the prologue.
%define number_of_registers 8

%define registers_space number_of_registers * 2
%define return_address_space 2

%macro prologue 0
  push ax
  push bx
  push cx
  push dx
  push ds
  push es
  push di
  pushfd
%endmacro


; The macro argument represents number of parameters to the function.
%macro epilogue 1
  ; The following is to put the return address
  ; at the top of the stack. This is so the caller
  ; doesn't have to do any cleanup.
  mov cx, [esp + registers_space + return_address_space]
  mov     [esp + registers_space + return_address_space + (%1 * 2)], cx

  popfd
  pop di
  pop es
  pop ds
  pop dx
  pop cx
  pop bx
  pop ax
  
  add esp, (%1 * 2)
%endmacro


%define param1 esp + 2  + registers_space + return_address_space
%define param2 esp + 4  + registers_space + return_address_space
%define param3 esp + 6  + registers_space + return_address_space
%define param4 esp + 8  + registers_space + return_address_space
%define param5 esp + 10 + registers_space + return_address_space
%define param6 esp + 12 + registers_space + return_address_space
