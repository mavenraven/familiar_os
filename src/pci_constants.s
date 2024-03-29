;See pci_bios_21.pdf, page 23
%define PCI.PCI_FUNCTION_ID 0xb1
%define PCI.PCI_BIOS_PRESENT 0x1
%define PCI.FIND_PCI_DEVICE 0x2
%define PCI.FIND_PCI_CLASS_CODE 0x3
%define PCI.GENERATE_SPECIAL_CYCLE 0x6
%define PCI.READ_CONFIG_BYTE 0x8
%define PCI.READ_CONFIG_WORD 0x9
%define PCI.READ_CONFIG_DWORD 0xa
%define PCI.WRITE_CONFIG_BYTE 0xb
%define PCI.WRITE_CONFIG_WORD 0xc
%define PCI.WRITE_CONFIG_DWORD 0xd
%define PCI.GET_IRQ_ROUTING_OPTIONS 0xe
%define PCI.SET_PCI_IRQ 0xf

;See pci_bios_21.pdf, page 24
%define PCI.FUNCTION_SUCCESSFUL 0x00
%define PCI.FUNC_NOT_SUPPORTED 0x81
%define PCI.BAD_VENDOR_ID 0x83
%define PCI.DEVICE_NOT_FOUND 0x86
%define PCI.BAD_REGISTER_NUMBER 0x87
%define PCI.SET_FAILED 0x88
%define PCI.BUFFER_TOO_SMALL 0x89
