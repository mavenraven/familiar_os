; There is a standard format for the beginning of a binary file for bootup:
; that looks like:
; http://www.techpository.com/wp-content/uploads/2015/07/examiningpartitiontables.pdf
; jmp instruction (3 bytes) ;
jmp _hello
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
_hello:
mov ah, 0x0e
mov al, 0x53
; mov bh, 0x01
; mov cx, 0x01
int 0x10


times 0x1fe - ($ - $$) db 0
db 0x55
db 0xaa
times 1474560 - ($ - $$) db 0
