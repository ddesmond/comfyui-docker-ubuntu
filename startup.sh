#!/bin/bash
echo "_____ STARTUP _____"
if [ -e /.comfyui-init ]; then
  bash /code/setup.sh
  bash /code/folder_setup.sh
else
  python main.py --listen 0.0.0.0 --port 7860 --output-directory /data/
fi


