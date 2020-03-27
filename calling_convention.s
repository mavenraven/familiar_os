%macro prologue 0
  push ax
  push bx
  push cx
  push dx
  pushfd
%endmacro


; The macro argument represents number of parameters to the function.
%macro epilogue 1
  ; The following is to put the return address
  ; at the top of the stack. This is so the caller
  ; doesn't have to do any cleanup.
  mov cx, [esp + 12]
  mov [esp + 10 + ((%1 + 1) * 2)], cx

  popfd
  pop dx
  pop cx
  pop bx
  pop ax
  
  add esp, (%1 * 2)
%endmacro


%define param1 esp + 14
%define param2 esp + 16
%define param3 esp + 18
%define param4 esp + 20
%define param5 esp + 22
