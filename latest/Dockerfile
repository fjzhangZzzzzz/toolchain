FROM centos:7

ADD powerpc64-linux-gnu.tar.gz /opt
ADD powerpc64le-linux-gnu.tar.gz /opt
ADD enable-powerpc64-linux-gnu /opt
ADD enable-powerpc64le-linux-gnu /opt

ENV PATH="$PATH:/opt/powerpc64-linux-gnu/usr/local/bin:/opt/powerpc64le-linux-gnu/usr/local/bin"

RUN yum install -y epel-release && \
    yum install -y make git p7zip p7zip-plugins zip

CMD ["/bin/bash"]
