%ifndef CALLING_CONVENTION
  %define CALLING_CONVENTION
  %include "calling_convention.s"
%endif

%ifndef PUTS %define PUTS
  %include "puts.s"
%endif

hello_routine: db 'hello routine', 0

irq_routine:
  prologue

  push hello_routine
  call puts

  epilogue 0
  ret
