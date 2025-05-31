#!/bin/bash

#SETUP COMFYUI
cd $HOME/app
git clone https://github.com/comfyanonymous/ComfyUI .
git pull


cd $HOME/app
# folders relink
rm -rf models/
ln -sf /data/models $HOME/app


pip install xformers!=0.0.18 --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121
ls -la .


cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager
cd comfyui-manager
pip install -r requirements.txt

rm -rf /.comfyui-init