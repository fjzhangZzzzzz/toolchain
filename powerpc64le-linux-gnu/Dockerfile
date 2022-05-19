FROM centos:7

RUN yum install -y wget bzip2 unzip gcc gcc-c++ flex texinfo \
                   help2man ncurses-devel file which gpatch patch \
                   make libtool libtool-bin rpm2cpio

WORKDIR /tmp/src
RUN wget --no-check-certificate https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/7.9.2009/os/ppc64le/Packages/glibc-2.17-317.el7.ppc64le.rpm && \
    wget --no-check-certificate https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/7.9.2009/os/ppc64le/Packages/glibc-devel-2.17-317.el7.ppc64le.rpm && \
    wget --no-check-certificate https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/7.9.2009/os/ppc64le/Packages/glibc-headers-2.17-317.el7.ppc64le.rpm && \
    wget --no-check-certificate https://mirrors.tuna.tsinghua.edu.cn/centos-altarch/7.9.2009/os/ppc64le/Packages/kernel-headers-3.10.0-1160.el7.ppc64le.rpm && \
    wget --no-check-certificate https://mirror.tuna.tsinghua.edu.cn/centos-altarch/7.9.2009/os/ppc64le/Packages/nss-softokn-freebl-devel-3.44.0-8.el7_7.ppc64le.rpm && \
    wget --no-check-certificate https://mirror.tuna.tsinghua.edu.cn/centos-altarch/7.9.2009/os/ppc64le/Packages/nss-softokn-freebl-3.44.0-8.el7_7.ppc64le.rpm && \
    wget --no-check-certificate http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz && \
    wget --no-check-certificate http://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.gz

WORKDIR /opt/powerpc64le-linux-gnu
RUN rpm2cpio /tmp/src/glibc-2.17-317.el7.ppc64le.rpm | cpio -div
RUN rpm2cpio /tmp/src/glibc-devel-2.17-317.el7.ppc64le.rpm | cpio -div
RUN rpm2cpio /tmp/src/glibc-headers-2.17-317.el7.ppc64le.rpm | cpio -div
RUN rpm2cpio /tmp/src/kernel-headers-3.10.0-1160.el7.ppc64le.rpm | cpio -div
RUN rpm2cpio /tmp/src/nss-softokn-freebl-3.44.0-8.el7_7.ppc64le.rpm | cpio -div
RUN rpm2cpio /tmp/src/nss-softokn-freebl-devel-3.44.0-8.el7_7.ppc64le.rpm | cpio -div
RUN ([ -d /opt/powerpc64le-linux-gnu/lib ] && rm -rf /opt/powerpc64le-linux-gnu/lib || true) && \
    ([ -d /opt/powerpc64le-linux-gnu/usr/lib ] && rm -rf /opt/powerpc64le-linux-gnu/usr/lib || true) && \
    ln -s /opt/powerpc64le-linux-gnu/lib64 /opt/powerpc64le-linux-gnu/lib && \
    ln -s /opt/powerpc64le-linux-gnu/usr/lib64 /opt/powerpc64le-linux-gnu/usr/lib

ENV PATH="${PATH}:/opt/powerpc64le-linux-gnu/usr/local/bin"

WORKDIR /tmp/src
RUN tar -xf binutils-2.27.tar.gz && cd binutils-2.27 && \
    ./configure --build=x86_64-redhat-linux-gnu \
                --host=x86_64-redhat-linux-gnu \
                --target=powerpc64le-linux-gnu \
                --with-sysroot=/opt/powerpc64le-linux-gnu/ \
                --disable-werror && \
    make && make DESTDIR=/opt/powerpc64le-linux-gnu install && \
    cd /tmp/src && tar -xf gcc-4.9.4.tar.gz && cd gcc-4.9.4 && ./contrib/download_prerequisites && \
    cd /tmp/src && mkdir -p gcc-4.9.4-build && ls -l && cd gcc-4.9.4-build && \
    ../gcc-4.9.4/configure --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu \
                        --target=powerpc64le-linux-gnu --with-sysroot=/opt/powerpc64le-linux-gnu/ \
                        --enable-checking=release --enable-languages=c,c++ --disable-multilib \
                        --enable-libstdcxx-allocator --enable-threads --enable-libstdcxx-threads \
                        --enable-long-long --enable-threads=posix --enable-tls && \
    make && make DESTDIR=/opt/powerpc64le-linux-gnu install && \
    rm -rf /tmp/src

WORKDIR /root
