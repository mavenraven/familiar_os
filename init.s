org 0x7c00
jmp init

%ifndef PUTX
  %define PUTX
  %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

%ifndef INIT_SERIAL
  %define INIT_SERIAL
  %include "init_serial.s"
%endif

%ifndef LOAD_REST_OF_CODE_INTO_MEMORY
  %define LOAD_REST_OF_CODE_INTO_MEMORY 
  %include "load_rest_of_code_into_memory.s"
%endif

init:
  mov sp, 0x7c00

  call init_serial
  
  push load
  push dx
  call load_rest_of_code_into_memory

  jmp main

times (512 - 2) - ($ - $$) db 0
db 0x55
db 0xaa
; https://stackoverflow.com/a/15690134
times 512 - ($ - $$) db 0

load:
  %include "string_constants.s"

main:
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

times 2048 - ($ - $$) dw 0x0000
