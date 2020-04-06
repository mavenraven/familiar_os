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

  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.FIND_PCI_DEVICE

  mov cx, PCNET.PCI_CONFIGURATION_REGISTERS.DEFAULTS.PCI_DEVICE_ID
  mov dx, PCNET.PCI_CONFIGURATION_REGISTERS.DEFAULTS.PCI_VENDOR_ID
  mov si, 0
  
  int 0x1a

  
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.READ_CONFIG_WORD
  mov di, 0x0

  int 0x1a

  push ax
  call putx
   
  pushf
  call putx

  push cx
  call putx



; PCI I/O Base Address or Memory Mapped I/O Base Address register
; PCI Expansion ROM Base Address register
; PCI Interrupt Line register
; PCI Latency Timer register
; PCI Status register
; PCI Command register
