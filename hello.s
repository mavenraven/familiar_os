org 0x7c00
jmp main

hello: db 'hello world', 0
carry_flag: db 'carry flag:', 0
return_code: db 'return code:', 0
number_drives: db 'number of hard disk drives: ', 0
logical_last_head: db 'last index of heads: ', 0
logical_last_cylinder: db 'last index of cylinders: ', 0
logical_last_sector: db 'last index of sectors: ', 0
sectors_read: db 'sctrs read ', 0

; from http://www.plantation-productions.com/Webster/www.artofasm.com/DOS/ch13/CH13-3.html
init_serial:
  mov ah, 0
  mov dx, 0
  mov al, 0b10100011
  int 0x14
  ret

; prints a null terminated string to the terminal and to COM1 [with new line]
puts:
  pop cx
  pop bx
  push cx
.begin:
  mov al, [bx]
  cmp al, 0x00
  je .end

  mov ah, 0x0e
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  inc bx
  jmp .begin
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

  ret

; prints a 16 bit hex value to the terminal and to COM1 [with new line]
putx:
  pop cx
  pop bx
  push cx
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
  mov ah, 0x0e
  pop bx
  mov al, bl
  int 0x10

  mov dx, 0
  mov ah, 1
  int 0x14

  add cx, 1
  cmp cx, 4
  jl .print_loop

  mov al, 0x0a
  mov ah, 0x0e
  int 0x10

  mov al, 0x0d
  int 0x10

  mov al, 0x0a
  mov dx, 0

  mov dx, 0
  mov ah, 1
  int 0x14

  ret

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
  
main:
  call init_serial
  
  call output_drive_info

  push hello
  call puts

  mov ax, 0
  mov es, ax
  mov bx, after

  mov ah, 0x2
  mov al, 1
  mov ch, 0
  mov cl, 1
  mov dh, 0
  mov dl, 0

  int 0x13
   
  pushf
  pop bx
  and bx, 0x0001
  push bx
  push carry_flag

  mov bx, ax
  and bx, 0xff00
  shr bx, 8
  push bx
  push return_code

  mov bx, ax
  and bx, 0x00ff
  push bx
  push sectors_read
 
  call puts
  call putx

  call puts
  call putx

  call puts
  call putx


times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0
after:
times 2048 - ($ - $$) dw 0xface
