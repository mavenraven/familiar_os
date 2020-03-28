%ifndef PUTX
  %define PUTX
  %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

%ifndef DETECT_PCNET_CARD
  %define DETECT_PCNET_CARD
  %include "detect_pcnet_card.s"
%endif


hello: db 'hello world', 0

main:
  sub sp, 8
  push sp
  push 0xface
  call hex_to_str

  push sp
  call puts
  add sp, 8

  call detect_pcnet_card

  mov ah, 0xb1
  mov al, 0x2

  mov cx, pci_device_id
  mov dx, pci_vendor_id
  mov si, 0
  
  int 0x1a

  
  mov ah, 0xb1
  mov al, 0x9
  mov di, 0x0

  int 0x1a

  push ax
  call putx
   
  pushf
  call putx

  push cx
  call putx
