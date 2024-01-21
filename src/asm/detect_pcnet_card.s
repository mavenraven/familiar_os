; detect_pcnet_card
; Prints whether PCNet Am79C970A PCI card is detected.

%ifndef PUTS
  %define PUTS
  %include "puts.s"
%endif

%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

%ifndef PCI_CONSTANTS
  %define PCI_CONSTANTS
  %include "pci_constants.s"
%endif

%ifndef PCNET_CONSTANTS
  %define PCNET_CONSTANTS
  %include "pcnet_constants.s"
%endif

pcnet_card_detected: db 'PCnet Am79C970A detected!', 0
pcnet_card_not_detected: db 'PCnet Am79C970A NOT detected.', 0

detect_pcnet_card:
  prologue

  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.FIND_PCI_DEVICE

  mov cx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_DEVICE_ID.DEFAULT
  mov dx, PCNET.PCI_CONFIGURATION_REGISTERS.PCI_VENDOR_ID.DEFAULT
  mov si, 0
  
  int 0x1a

  and ax, 0xff00
  shr ax, 8
  cmp ax, PCI.FUNCTION_SUCCESSFUL
  jz .success
  jnz .failure

.success
  push pcnet_card_detected
  call puts
  epilogue 0
  ret

.failure
  push pcnet_card_not_detected
  call puts
  epilogue 0
  ret
