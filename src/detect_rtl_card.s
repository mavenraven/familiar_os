; detect_rtl_card
; Prints whether RTL8139 is detected.

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

%ifndef RTL_CONSTANTS
  %define RTL_CONSTANTS
  %include "rtl_constants.s"
%endif

rtl_card_detected: db 'RTL8139 detected!', 0
rtl_card_not_detected: db 'RTL8139 NOT detected.', 0

bus_number: db 'bus number: ', 0


detect_rtl_card:
  prologue

  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.FIND_PCI_DEVICE

  mov cx, RTL.PCI_CONFIGURATION_REGISTERS.PCI_DEVICE_ID
  mov dx, RTL.PCI_CONFIGURATION_REGISTERS.PCI_VENDOR_ID
  mov si, 0
  
  int 0x1a

  and ax, 0xff00
  shr ax, 8
  cmp ax, PCI.FUNCTION_SUCCESSFUL
  jz .success
  jnz .failure

.success:
  push rtl_card_detected
  call puts
  push bus_number
  call print

  mov bx, 0
  push bx
  call puts

  epilogue 0
  ret

.failure:
  push rtl_card_not_detected
  call puts
  epilogue 0
  ret
