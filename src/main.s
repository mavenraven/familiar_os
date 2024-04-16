%ifndef PUTX
  %define PUTX %include "putx.s"
%endif
%ifndef PUTS %define PUTS
  %include "puts.s"
%endif

%ifndef PUTS_VGA
  %define PUTS_VGA
  %include "puts_vga.s"
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
reseting_card: db 'reseting card.', 0
card_reset: db 'card reset', 0
irq_num: db'IRQ ', 0
bar: db'BAR ', 0

main:
  push hello
  call puts_vga
  push 0x51
  call write_char
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

; read command register
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.READ_CONFIG_WORD
  mov di, 4

  int 0x1a

;command register, turn on the bus master bit
 or cx, 4

; then write it back 
  mov ah, PCI.PCI_FUNCTION_ID
  mov al, PCI.WRITE_CONFIG_WORD
  mov di, 4

  int 0x1a
 


  ; we get the io base address similarly to the way this code does: http://www.jbox.dk/sanos/source/sys/dev/rtl8139.c.html
  ; that code loops over each of the 6 base addresses and returns the first one that is an io address
  ; 
  ; we'll be lazy and just assume that the first base address is the io address

  ; resources:
  ; https://wiki.osdev.org/RTL8139
  ; https://github.com/mavenraven/sanos/blob/master/src/sys/krnl/pci.c#L337-L354
  ; https://github.com/mavenraven/sanos/blob/master/src/sys/dev/rtl8139.c#L1187
  ; https://github.com/mavenraven/sanos/blob/master/src/sys/krnl/dev.c#L177-L182
  ; https://github.com/mavenraven/sanos/blob/master/src/sys/krnl/dev.c#L159-L162

; read first part of first BAR
 mov ah, PCI.PCI_FUNCTION_ID
 mov al, PCI.READ_CONFIG_WORD
 mov di, 16
 int 0x1a

 push cx
 call putx

  ; on qemu the whole value is 0x0000c001. we bit shift 2 to the right because
  ; the low 2 bits are reserved.

 and cx, 0xFFFC
 push cx
 call putx

; push the BAR for later delicious snacking
push cx

; read from the address PCI Revision ID as a santity check
 add cx, 0x005e
 mov dx, cx
 push dx
 call putx

 in ax, dx
 push ax
 call putx


; ok, so it works as expected. QEMU has the revision ID for this card as 0x20, and that's what we see. 
; now to do the step: Turning on the RTL8139 [https://wiki.osdev.org/RTL8139]

pop cx

; save the BAR again for more snacking
push cx

add cx, 0x52
mov dx, cx

mov ax, 0x0
out dx, ax

; Software Reset!

pop cx

; save the BAR again for more snacking
push cx

add cx, 0x37
mov dx, cx

mov ax, 0x10
out dx, ax


.software_reset_loop:
in ax, dx
and ax, 0x10
cmp ax, 0x0
je .software_reset_loop_end

push reseting_card
call puts

jmp .software_reset_loop

.software_reset_loop_end:

push card_reset
call puts

; Init Receive buffer

pop cx

; save the BAR again for more snacking
push cx


add cx, 0x30
mov dx, cx

mov ax, 0xface

out dx, ax

; Set IMR + ISR

pop cx

; save the BAR again for more snacking
push cx

add cx, 0x3c
mov dx, cx

mov ax, 0x0005
out dx, ax


; Configuring receive buffer (RCR)

pop cx

; save the BAR again for more snacking
push cx

add cx, 0x44
mov dx, cx


; this turns on AB+AM+APM+AAP and also the WRAP Bit
mov ax, 0b01001111
out dx, ax


; Enable Receive and Transmitter

pop cx

; save the BAR again for more snacking
push cx

add cx, 0x37
mov dx, cx

mov ax, 0x0c
out dx, ax









