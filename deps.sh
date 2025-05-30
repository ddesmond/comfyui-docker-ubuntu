#!/bin/bash

apt-get update -y
apt-get install -y ca-certificates --fix-missing
update-ca-certificates
apt-get install -y \
    nano zip \
    git git-lfs wget curl screen \
    --fix-missing

apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    --fix-missing

apt-get install -y \
    libbz2-dev libreadline-dev \
    libsqlite3-dev llvm --fix-missing

apt-get install -y \
    libncursesw5-dev xz-utils tk-dev libxml2-dev \
    --fix-missing

apt-get install -y \
    libxmlsec1-dev libffi-dev liblzma-dev \
    ffmpeg libsm6 libxext6 \
    cmake \
    --fix-missing

wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mesa/libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb \
    && chmod 777 ./libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb \
    && apt install ./libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb --fix-missing \
    && apt autoremove -y

git lfs install
