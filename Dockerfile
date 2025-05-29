FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Zagreb

ARG USE_PERSISTENT_DATA

RUN apt-get update -y && apt-get install software-properties-common -y

RUN repo="deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64  InRelease" \
    && add-apt-repository --remove "$repo" \
    && apt update -y


RUN apt-get update -y
RUN apt-get install -y ca-certificates
RUN update-ca-certificates
RUN apt-get update -y && apt-get install -y \
    nano \
    zip \
    git
RUN apt-get install -y -t jammy \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev git git-lfs  \
    ffmpeg libsm6 libxext6 cmake libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/* \
    && git lfs install

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt
COPY ./setup.sh /code/setup.sh

RUN chown 1000:1000 -R /code

# User
RUN useradd -m --groups users,sudo  -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Pyenv
RUN curl https://pyenv.run | bash
ENV PATH=$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH

ARG PYTHON_VERSION=3.10.12
# Python
RUN pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION && \
    pyenv rehash && \
    pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir \
    datasets \
    huggingface-hub "protobuf<4" "click<8.1"

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Set the working directory to /data if USE_PERSISTENT_DATA is set, otherwise set to $HOME/app
WORKDIR $HOME/app

RUN bash /code/setup.sh

# Checkpoints

RUN echo "Done"

# instal custom nodes
RUN echo "Installing custom nodes..."
WORKDIR $HOME/app
RUN ls -la .

RUN echo "Done"

CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "7860", "--output-directory", "${HOME:+/data/}"]