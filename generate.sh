#!/bin/bash
# 生成最新工具链
# 根目录下除 latest 外，每个子目录代表一个交叉编译镜像标签
# 子目录中构建交叉编译工具链结果会存放在 /opt 目录下，目录名同子目录名

set -e

WORKDIR=$(pwd)

function generate_package() {
    local name=$1
    docker run --rm -t -v$WORKDIR:/root/workdir toolchain:$name \
        bash -c "cd /opt && tar -zcf $name.tar.gz $name && mv $name.tar.gz /root/workdir/latest"
}

function generate_toolchain() {
    local name=$1
    if [ -f latest/$name.tar.gz ]; then
        echo "latest/$name.tar.gz exist already"
        return 0
    fi

    echo "build $name"
    cd $WORKDIR/$name && docker build -t toolchain:$name .

    docker image prune -f && docker container prune -f

    generate_package $dir
}

for dir in $(ls); do
    if [ -d $dir ] && [ -f "$dir/Dockerfile" ] && [ "$dir" != "latest" ]; then
        generate_toolchain $dir
    fi
done

cd $WORKDIR/latest && docker build -t toolchain:latest .
