FROM nvidia/cuda:12.6.3-runtime-rockylinux9


ENV TZ=Europe/Zagreb

ARG USE_PERSISTENT_DATA

RUN mkdir -p /data && chmod -R 777 /data

WORKDIR /code
COPY ./deps.sh /code/deps.sh
COPY ./requirements.txt /code/requirements.txt
COPY ./setup.sh /code/setup.sh
COPY ./debug.sh /code/debug.sh
COPY ./startup.sh /code/startup.sh
COPY ./.comfyui-init /.comfyui-init

# Copy
RUN chmod +x /code/debug.sh
RUN chmod +x /code/startup.sh
RUN chmod +x /code/deps.sh

# Deps
RUN bash /code/deps.sh

# ENV
ENV HOME=/root \
    PATH=/root/.local/bin:$PATH

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

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Set the working directory to /data mounted from docker compose
WORKDIR $HOME/app

RUN echo "Done."
ENV HF_TOKEN="" \
    HF_ENDPOINT="https://huggingface.co" \
    HF_HUB_ENABLE_HF_TRANSFER=true \
    HF_HUB_ENABLE_HF_TRANSFER_NO_AUTH=true \
    HF_HUB_DOWNLOAD_TIMEOUT=60

CMD ["bash","/code/startup.sh"]