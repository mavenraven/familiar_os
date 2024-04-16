%ifndef PUTS %define PUTS
  %include "puts.s"
%endif

hello_routine: db 'hello routine', 0

irq_routine:
  push hello_routine
  call puts
  iret
