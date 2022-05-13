# toolchain

A collection of cross-compilation toolchains

## Build machine

- OS: CentOS-7.9.2009
- Arch: amd64
- Glibc: 2.17

## Target machines

### powerpc64-linux-gnu

- OS: CentOS-7.9.2009
- Kernel: 3.10.0-1160
- Arch: powerpc64
- Glibc: 2.17
- Binutils: 2.27
- GCC: 4.9.4
- CrossPrefix: powerpc64-linux-gnu-

### powerpc64le-linux-gnu

- OS: CentOS-7.9.2009
- Kernel: 3.10.0-1160
- Arch: powerpc64le
- Glibc: 2.17
- Binutils: 2.27
- GCC: 4.9.4
- CrossPrefix: powerpc64le-linux-gnu-

## Usage

### Makefile
```bash
docker run --rm -it fjzhangzzz/toolchain:latest \
    make CC=powerpc64-linux-gnu-gcc CXX=powerpc64-linux-gnu-g++ LD=powerpc64-linux-gnu-ld -f /path/to/your/Makefile
```

### CMake
```bash
$ vi powerpc64-linux-gnu.toolchain.cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR powerpc64)

set(TOOLCHAIN /opt/powerpc64-linux-gnu)
set(CMAKE_SYSROOT${TOOLCHAIN}/sysroot)
set(CMAKE_C_COMPILER ${TOOLCHAIN}/usr/bin/powerpc64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN}/usr/bin/powerpc64-linux-gnu-g++)

set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN}/sysroot)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

$ mkdir build && cd build
$ cmake -DCMAKE_TOOLCHAIN_FILE=powerpc64-linux-gnu.toolchain.cmake ..
$ make
```

## Links

- [fjzhangZzzzzz/toolchain - Github](https://github.com/fjzhangZzzzzz/toolchain)
- [fjzhangzzz/toolchain - Dockerhub](https://hub.docker.com/r/fjzhangzzz/toolchain)
