%ifndef PUTX
  %define PUTX %include "putx.s"
%endif

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

%ifndef DETECT_PCNET_CARD
  %define DETECT_PCNET_CARD
  %include "detect_pcnet_card.s"
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

  call detect_pcnet_card

;set address
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.FIND_PCI_DEVICE

  mov cx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_DEVICE_ID.DEFAULT
  mov dx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_VENDOR_ID.DEFAULT
  mov si, 0
  
  int 0x1a
  
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.WRITE_CONFIG_WORD
  mov di, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_MEMORY_MAPPED_IO_BASE_ADDRESS.OFFSET
  mov eax, 0x8000 ; arbitary, 2 sectors past 0x7c00
  shl eax, 5

  int 0x1a

;set memem
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.FIND_PCI_DEVICE

  mov cx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_DEVICE_ID.DEFAULT
  mov dx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_VENDOR_ID.DEFAULT
  mov si, 0
  
  int 0x1a

  
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.WRITE_CONFIG_WORD
  mov di, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_COMMAND.OFFSET
  mov cx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_COMMAND.MEMEM

  int 0x1a
