#!/bin/bash


# folder setup
cd /data
mkdir -p ./models \
&& mkdir -p ./models/checkpoints/ \
&& mkdir -p ./models/vae/ \
&& mkdir -p ./models/controlnet/ \
&& mkdir -p ./models/style_models/ \
&& mkdir -p ./models/loras \
&& mkdir -p ./models/controlnet/ \
&& mkdir -p ./models/clip_vision \
&& mkdir -p ./models/gligen/ \
&& mkdir -p ./models/upscale_models \
&& mkdir -p custom_nodes
ls -la .


#SETUP COMFYUI

git clone https://github.com/comfyanonymous/ComfyUI .
git pull

rm -rf models/
rm -rf custom_nodes/

# folders
ln -sf /data/models /home/user/app
ln -sf /data/custom_nodes /home/user/app
# Folders setup
cd /data

pip install xformers!=0.0.18 --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
ls -la .



cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager
cd comfyui-manager
pip install -r requirements.txt
