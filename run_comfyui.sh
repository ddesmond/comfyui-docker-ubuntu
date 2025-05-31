#!/bin/bash
echo "_____ RUN COMFYUI _____"
python main.py --listen 0.0.0.0 --port 7860 --output-directory /outputs/ --disable-xformers --preview-method auto --multi-user