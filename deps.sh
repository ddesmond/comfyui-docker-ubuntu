#!/bin/bash

dnf update -y
dnf install -y ca-certificates --fix-missing
update-ca-certificates
dnf install -y \
    nano zip \
    git git-lfs wget curl screen \
    --fix-missing

dnf install -y \
    make build-essential libssl-dev zlib1g-dev \
    --fix-missing

dnf install -y \
    libbz2-dev libreadline-dev \
    libsqlite3-dev llvm --fix-missing

dnf install -y \
    libncursesw5-dev xz-utils tk-dev libxml2-dev \
    --fix-missing

dnf install -y \
    libxmlsec1-dev libffi-dev liblzma-dev \
    ffmpeg libsm6 libxext6 \
    cmake \
    --fix-missing


git lfs install
