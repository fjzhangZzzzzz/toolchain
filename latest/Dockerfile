FROM centos:7

ADD powerpc64-linux-gnu.tar.gz /opt
ADD powerpc64le-linux-gnu.tar.gz /opt

ENV PATH="$PATH:/opt/powerpc64-linux-gnu/usr/local/bin:/opt/powerpc64le-linux-gnu/usr/local/bin"

RUN yum install -y make

CMD ["/bin/bash"]
