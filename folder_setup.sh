#!/bin/bash

# folder setup
cd /data
echo "Creating folders in /data"
mkdir -p ./models \
&& mkdir -p ./models/checkpoints/ \
&& mkdir -p ./models/clip/ \
&& mkdir -p ./models/clip_vision/ \
&& mkdir -p ./models/configs/ \
&& mkdir -p ./models/controlnet \
&& mkdir -p ./models/diffusers/ \
&& mkdir -p ./models/diffusion_models \
&& mkdir -p ./models/gligen/ \
&& mkdir -p ./models/hypernetworks/ \
&& mkdir -p ./models/loras/ \
&& mkdir -p ./models/photomaker/ \
&& mkdir -p ./models/style_models \
&& mkdir -p ./models/text_encoders \
&& mkdir -p ./models/text_encoders \
&& mkdir -p ./models/unet \
&& mkdir -p ./models/upscale_models \
&& mkdir -p ./models/vae \
&& mkdir -p ./models/vae_approx \
chmod -R 777 /data
chmod -R 777 /data/models
ls -la /data/