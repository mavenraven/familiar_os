# Use Ubuntu Jammy as the base image
# Have to use emulated because ubuntu decided to add multiime for arm https://packages.ubuntu.com/jammy/gcc-multilib
#FROM --platform=linux/amd64 ubuntu:jammy
FROM ubuntu:jammy
VOLUME src/unikernel

RUN apt-get update 

# Needed to build gcc-5.2.0, the last(?) gcc with i386 support.
RUN apt-get install -y gcc 
RUN apt-get install -y build-essential
RUN apt-get install -y bison
RUN apt-get install -y flex
RUN apt-get install -y info
RUN apt-get install -y libmpc-dev

COPY bin/gcc-5.2.0.tar.bz2 /i386/gcc-5.2.0.tar.bz2
COPY bin/binutils-2.25.1.tar.bz2 /i386/binutils-2.25.1.tar.bz2
COPY bin/binutils-2.25.1.tar.bz2 /i386/binutils-2.25.1.tar.bz2

RUN cd /i386 && tar -xvjf gcc-5.2.0.tar.bz2
RUN cd /i386 && tar -xvjf binutils-2.25.1.tar.bz2
RUN cd /i386/binutils-2.25.1 && ./configure
RUN cd /i386/gcc-5.2.0 && ./configure

RUN cd /i386/binutils-2.25.1 && make

# save a copy of the file to be patched for debugging purposes
RUN cp /i386/gcc-5.2.0/gcc/wide-int.h /wide-int.h
# Needed because of this: https://github.com/espressif/esp-idf/issues/2126
COPY bin/0001-Remove-double-tempate-declarations-in-wide-int.h.patch /i386/gcc-5.2.0/0001-Remove-double-tempate-declarations-in-wide-int.h.patch
RUN cd /i386/gcc-5.2.0 && patch -p1 < 0001-Remove-double-tempate-declarations-in-wide-int.h.patch

# save a copy of the file to be patched for debugging purposes
RUN cp /i386/gcc-5.2.0/gcc/reload1.c /reload1.c
# Needed because of this: 
#
#../.././gcc/reload1.c: In function 'void init_reload()':
#../.././gcc/reload1.c:115:24: error: use of an operand of type 'bool' in 'operator++' is forbidden in C++17
#  115 |   (this_target_reload->x_spill_indirect_levels)
#      |   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
#../.././gcc/reload1.c:470:7: note: in expansion of macro 'spill_indirect_levels'
#  470 |       spill_indirect_levels++;
#      |       ^~~~~~~~~~~~~~~~~~~~~
COPY bin/0002-c17-boolean-fix.patch /i386/gcc-5.2.0/0002-c17-boolean-fix.patch
RUN cd /i386/gcc-5.2.0 && patch gcc/reload1.c 0002-c17-boolean-fix.patch


#RUN cd /i386/gcc-5.2.0 && make
