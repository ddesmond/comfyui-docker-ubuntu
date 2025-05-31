#!/bin/bash
echo "_____ Startup _____"
if [ -e /.comfyui-init ]; then
  bash /setup/setup.sh
  bash /setup/folder_setup.sh
  bash /setup/run_comfyui.sh
elif [ -z "${REFRESH}" ];
  echo "_____ Refresh _____"
  bash /setup/setup.sh
  bash /setup/run_comfyui.sh
elif [ -e /data/models ]; then
  echo "_____ Reset folders  _____"
  bash /setup/folder_setup.sh
  bash /setup/run_comfyui.sh
else
  bash /setup/run_comfyui.sh
fi


