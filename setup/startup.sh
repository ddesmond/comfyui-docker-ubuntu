#!/bin/bash
echo "_____ STARTUP _____"
if [ -e /.comfyui-init ]; then
  bash /setup/setup.sh
  bash /setup/folder_setup.sh
  bash /setup/run_comfyui.sh
else
  bash /setup/run_comfyui.sh
fi


