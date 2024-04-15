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

;  call init_serial
  
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

%ifndef MAIN
  %define MAIN 
  %include "main.s"
%endif

; https://stackoverflow.com/a/15690134
times 1024 - ($ - $$) db 0
