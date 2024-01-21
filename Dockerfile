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

COPY bin/gcc-5.2.0.tar.gz /i386/gcc-5.2.0.tar.gz
COPY bin/binutils-2.25.1.tar.gz /i386/binutils-2.25.1.tar.gz

RUN cd /i386 && tar -xf gcc-5.2.0.tar.gz
RUN cd /i386 && tar -xf binutils-2.25.1.tar.gz
RUN cd /i386/binutils-2.25.1 && ./configure
RUN cd /i386/gcc-5.2.0 && ./configure

RUN cd /i386/binutils-2.25.1 && make
RUN cd /i386/gcc-5.2.0 && make
