FROM multiarch/qemu-user-static as qemu
FROM centos:7

ADD powerpc64-linux-gnu.tar.gz /opt
ADD powerpc64le-linux-gnu.tar.gz /opt
ADD enable-powerpc64-linux-gnu /opt
ADD enable-powerpc64le-linux-gnu /opt
ADD register.sh /register
# https://raw.githubusercontent.com/qemu/qemu/e75941331e4cdc05878119e08635ace437aae721/scripts/qemu-binfmt-conf.sh
ADD qemu-binfmt-conf.sh /qemu-binfmt-conf.sh
COPY --from=qemu /usr/bin/qemu-ppc64-static /usr/bin
COPY --from=qemu /usr/bin/qemu-ppc64le-static /usr/bin

ENV QEMU_BIN_DIR=/usr/bin
ENV PATH="$PATH:/opt/powerpc64-linux-gnu/usr/local/bin:/opt/powerpc64le-linux-gnu/usr/local/bin"

RUN yum install -y epel-release && \
    yum install -y make git p7zip p7zip-plugins zip && \
    chmod +x /qemu-binfmt-conf.sh && chmod +x /register

CMD ["/bin/bash"]
