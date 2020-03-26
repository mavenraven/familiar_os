; from http://www.plantation-productions.com/Webster/www.artofasm.com/DOS/ch13/CH13-3.html
init_serial:
  mov ah, 0
  mov dx, 0
  mov al, 0b10100011
  int 0x14
  ret
