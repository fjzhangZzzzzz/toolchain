#!/bin/bash
# 生成最新工具链
# 根目录下除 latest 外，每个子目录代表一个交叉编译镜像标签
# 子目录中构建交叉编译工具链结果会存放在 /opt 目录下，目录名同子目录名

set -e

WORKDIR=$(pwd)

function generate_package() {
    local name=$1
    echo "package $name"
    docker images
    #docker run --rm -t -v$WORKDIR:/root/workdir toolchain:$name \
    #    bash -c "cd /opt && tar -zcf $name.tar.gz $name && mv $name.tar.gz /root/workdir/latest"
        
    if [ ! -f $WORKDIR/latest/$name.tar.gz ]; then
        echo "$WORKDIR/latest/$name.tar.gz not found!"
        # exit 1
    fi
}

function generate_toolchain() {
    local name=$1
    if [ -f latest/$name.tar.gz ]; then
        echo "latest/$name.tar.gz exist already"
        return 0
    fi

    echo "build $name"
    cd $WORKDIR/$name
    echo "docker build -t toolchain:$name ."
    # docker build -t toolchain:$name .
    docker image prune -f && docker container prune -f
    generate_package $name
}

cd $WORKDIR
for dir in $(ls); do
    echo "for item $dir"
    if [ -d $dir ] && [ -f "$dir/Dockerfile" ] && [ "$dir" != "latest" ]; then
        generate_toolchain $dir && ls -lR $WORKDIR
    fi
done

cd $WORKDIR/latest && docker build -t toolchain:latest .
