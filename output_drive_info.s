; output_drive_info
; Writes out useful statsitics about a drive.
; parameter 1: The drive number to be examined. Same as dx set by bios.

%ifndef PRINT
  %define PRINT
  %include "print.s"
%endif

%ifndef PUTX
  %define PUTX
  %include "putx.s"
%endif

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

carry_flag: db 'carry flag: ', 0
return_code: db 'return code: ', 0
number_drives: db 'number of hard disk drives: ', 0
logical_last_head: db 'last index of heads: ', 0
logical_last_cylinder: db 'last index of cylinders: ', 0
logical_last_sector: db 'last index of sectors: ', 0

output_drive_info:
  prologue
  mov ah, 0x8
  mov dx, [param1]
  
  int 0x13

  push cx
  push cx
  push cx
  push dx
  push dx
  push ax
  pushf
  
  push carry_flag
  call print

  pop bx
  and bx, 0x0001
  push bx
  call putx

  push return_code
  call print

  pop bx
  and bx, 0xff00
  shr bx, 8
  push bx
  call putx
  
  push number_drives
  call print

  pop bx
  and bx, 0x00ff
  push bx
  call putx

  push logical_last_head
  call print

  pop bx
  and bx, 0xff00
  shr bx, 8
  push bx
  call putx
  
  push logical_last_sector
  call print

  pop bx
  and bx, 0b0000000000111111
  push bx
  call putx

  push logical_last_cylinder
  call print

  pop bx
  and bx, 0b1111111100000000
  shr bx, 8
  pop cx
  and cx, 0b0000000011000000
  shl cx, 2
  or bx, cx
  push bx
  call putx

  epilogue 1
  ret
