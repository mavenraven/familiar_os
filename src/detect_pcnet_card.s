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

;See https://stuff.mit.edu/afs/sipb/contrib/doc/specs/ic/network/am79c970a.pdf, page 169
%define pci_vendor_id 0x1022
%define pci_device_id 0x2000

pcnet_card_detected: db 'PCnet Am79C970A detected!', 0
pcnet_card_not_detected: db 'PCnet Am79C970A NOT detected.', 0

detect_pcnet_card:
  prologue

  mov ah, 0xb1
  mov al, 0x2

  mov cx, pci_device_id
  mov dx, pci_vendor_id
  mov si, 0
  
  int 0x1a

  and ax, 0xff00
  shr ax, 8
  cmp ax, 0
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
