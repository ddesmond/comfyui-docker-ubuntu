# ComfyUI Rocky Linux Docker

Mounts `/data` and `/outputs` folders from the host machine to the container.
If you change those paths, edit the files accordingly.

Run:

```bash
docker compose up
```

Based off nvidia/cuda:12.6.3-runtime-rockylinux9 - Rocky Linux 9 with ComfyUI and Python 3.10 (pyenv).

You can edit the setup/requirements.txt file to add/remove Python packages on install part.
You can edit the setup/download.sh file to add/remove ComfyUI nodes/models on install part.





