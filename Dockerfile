FROM nvidia/cuda:12.6.1-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Zagreb

ARG USE_PERSISTENT_DATA

RUN apt-get update -y && apt-get install software-properties-common -y


RUN apt-get update -y
RUN apt-get install -y ca-certificates
RUN update-ca-certificates
RUN apt-get update -y && apt-get install -y \
    nano \
    zip \
    git
RUN apt-get install -y  \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev git git-lfs  \
    ffmpeg libsm6 libxext6 cmake \
    && rm -rf /var/lib/apt/lists/* \
    && git lfs install
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mesa/libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb \
    && chmod 777 ./libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb \
    && apt install ./libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb \
    && apt autoremove

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt
COPY ./setup.sh /code/setup.sh

RUN chown 1200:1200 -R /code

# User
RUN useradd -m --groups users,sudo  -u 1200 user
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