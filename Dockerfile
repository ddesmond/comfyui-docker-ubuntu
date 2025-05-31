FROM nvidia/cuda:12.6.3-runtime-rockylinux9


ENV TZ=Europe/Zagreb

ARG USE_PERSISTENT_DATA

RUN mkdir -p /data && chmod -R 777 /data

WORKDIR /code
COPY ./deps.sh /code/deps.sh
COPY ./requirements.txt /code/requirements.txt
COPY ./setup.sh /code/setup.sh


# Deps install
RUN chmod +x /code/deps.sh
RUN bash /code/deps.sh

# User

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

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Set the working directory to /data mounted from docker compose
WORKDIR $HOME/app

# deploy comfy code
RUN bash /code/setup.sh


RUN echo "Done"

CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "7860", "--output-directory", "/data/"]