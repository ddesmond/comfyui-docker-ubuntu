FROM nvidia/cuda:12.6.3-runtime-rockylinux9


ENV TZ=Europe/Zagreb

ARG USE_PERSISTENT_DATA

RUN mkdir -p /data && chmod -R 777 /data

WORKDIR /setup
COPY ./setup/deps.sh /setup/deps.sh
COPY ./setup/requirements.txt /setup/requirements.txt
COPY ./setup/setup.sh /setup/setup.sh
COPY ./setup/debug.sh /setup/debug.sh
COPY ./setup/run_comfyui.sh /setup/run_comfyui.sh
COPY ./setup/startup.sh /setup/startup.sh
COPY ./setup/folder_setup.sh /setup/folder_setup.sh
COPY ./setup/.comfyui-init /.comfyui-init
COPY ./setup/extra_models_paths.yaml /setup/extra_models_paths.yaml

# Copy
RUN chmod +x /setup/*.sh

# Deps
RUN bash /setup/deps.sh

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

CMD ["bash","/setup/startup.sh"]