org 0x7c00
; There is a standard format for the beginning of a binary file for bootup:
; that looks like:
; http://www.techpository.com/wp-content/uploads/2015/07/examiningpartitiontables.pdf
; jmp instruction (3 bytes) ;
mov sp, stack
mov bx, hello
push bx
jmp puts
db 0x00
; 
;oem name (8 bytes)
%rep 8
db 0x00
%endrep
; 
;bios paramter block
;https://en.wikipedia.org/wiki/BIOS_parameter_block#FAT12_/_FAT16
%rep 25
db 0x00
%endrep
; 
;extended bios paramter block
;https://en.wikipedia.org/wiki/BIOS_parameter_block#DOS_4.0_EBPB
%rep 54
db 0x00
%endrep

hello: db 'hello world', 0

puts:
  pop bx
  mov ah, 0x0e
  mov al, [hello] ;0x64
  int 0x10
  mov bx, hello
.begin:
  mov dl, [bx]
  cmp dl, 0
;  je  puts_end
  mov ah, 0x0e
  mov al, dl
  int 0x10
  inc bx
;  jmp puts_begin
.end:


stack:
times 0x1fe - ($ - $$) db 0
db 0x55
db 0xaa
times 1474560 - ($ - $$) db 0
