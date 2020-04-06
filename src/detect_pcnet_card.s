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


pcnet_card_detected: db 'PCnet Am79C970A detected!', 0
pcnet_card_not_detected: db 'PCnet Am79C970A NOT detected.', 0

detect_pcnet_card:
  prologue

  mov ah, PCI_FUNCTION_ID
  mov al, FIND_PCI_DEVICE

  mov cx, PCNET_PCI_DEVICE_ID
  mov dx, PCNET_PCI_VENDOR_ID
  mov si, 0
  
  int 0x1a

  and ax, 0xff00
  shr ax, 8
  cmp ax, PCI_FUNCTION_SUCCESSFUL
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
