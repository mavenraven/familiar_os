; http://www.techpository.com/wp-content/uploads/2015/07/examiningpartitiontables.pdf




mov ah, 0x0a
mov al, 0x54
mov bh, 0x01
mov cx, 0x01
int 0x10



;pad with nops upto bootloader magic bytes
%rep 499
nop
%endrep
db 0x55
db 0xaa



