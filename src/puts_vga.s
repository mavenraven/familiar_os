; puts_vga
; Writes a string to the terminal, with a new line.
; parameter 1: Pointer to the null terminated string to be printed.


%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

puts_vga:
   prologue
;  push ax
;  push ds
;  push di
;  push bx

;  mov ah, 0x00
;  mov al, 0x03
;  int 0x10

;  mov ax, 0xB800
;  mov ds, ax
;  mov di, 0x0
;  mov bx, 0xFF30
;  mov [ds:di], bx

;  pop bx
;  pop di
;  pop ds
;  pop ax
  epilogue 0
  ret
