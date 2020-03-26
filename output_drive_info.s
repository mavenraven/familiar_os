output_drive_info:
  mov ah, 0x8
  mov dl, 0
  
  int 0x13
   
  pushf
  pop bx
  and bx, 0x0001
  push bx
  push carry_flag

  and ax, 0xff00
  shr ax, 8
  push ax
  push return_code

  mov bx, dx
  and bx, 0x00ff
  push bx
  push number_drives

  mov bx, dx
  and bx, 0xff00
  shr bx, 8
  push bx
  push logical_last_head
  
  mov bx, cx
  and bx, 0b0000000000111111
  push bx
  push logical_last_sector

  mov bx, cx
  and bx, 0b1111111100000000
  shr bx, 8
  and cx, 0b0000000011000000
  shl cx, 2
  or bx, cx
  push bx
  push logical_last_cylinder

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  call puts
  call putx

  ret
