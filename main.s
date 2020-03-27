
%ifndef OUTPUT_DRIVE_INFO
  %define OUTPUT_DRIVE_INFO
  %include "output_drive_info.s"
%endif


hello: db 'hello world', 0
main:
  push 0x80
  call output_drive_info

  push hello
  call puts

  push hello
  call puts

  push 0xec00
  push 0xface
  call hex_to_str

  push 0xec00
  call puts
 
  mov bx, sp
  push 0xf700
  push bx
  call hex_to_str

  push 0xf700
  call puts

  push 0xcafe
  call putx

  push 0xeeee
  call putx

  mov bx, sp
  push bx
  call putx
