%ifndef PUTX
  %define PUTX %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

%ifndef DETECT_RTL_CARD
  %define DETECT_RTL_CARD
  %include "detect_rtl_card.s"
%endif

%ifndef PCI_CONSTANTS
  %define PCI_CONSTANTS
  %include "pci_constants.s"
%endif

%ifndef PCNET_CONSTANTS
  %define PCNET_CONSTANTS
  %include "pcnet_constants.s"
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

  call detect_rtl_card

 ; bus mastering

  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.FIND_PCI_DEVICE

  mov cx, RTL.PCI_CONFIGURATION_REGISTERS.PCI_DEVICE_ID
  mov dx, RTL.PCI_CONFIGURATION_REGISTERS.PCI_VENDOR_ID
  mov si, 0
  
  int 0x1a

  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.READ_CONFIG_WORD
  mov di, 1

  int 0x1a

  push cx
  call putx
