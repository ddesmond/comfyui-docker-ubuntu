#!/bin/bash
echo "_____ STARTUP _____"
if [ -e /.comfyui-init ]; then
  bash /code/setup.sh
  bash /code/folder_setup.sh
  bash /code/run_comfyui.sh
else
  bash /code/run_comfyui.sh
fi


