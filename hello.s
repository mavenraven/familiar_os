mov al, 10 

;pad with nops upto bootloader magic bytes
%rep 508 
nop
%endrep
db 0x55
db 0xaa



