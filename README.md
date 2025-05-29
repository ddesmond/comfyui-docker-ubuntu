# 🤖 🌄 comfyui-docker

## 🚀 Dockerized AI Environment with NVIDIA CUDA for ComfyUI

Docker setup for a powerful and modular diffusion model GUI and backend. 

This project sets up a complete AI development environment with NVIDIA CUDA, cuDNN, and various essential AI/ML libraries using Docker. It includes Stable Diffusion models and ControlNet for text-to-image generation and various deep learning models.

## 🛠️ Project Overview

This Docker image is based on **`nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04`**, ensuring GPU acceleration for deep learning workloads. It is configured for ease of use with `Pyenv`, custom Python versions, and GPU-specific libraries.

### Key Features:

- **NVIDIA CUDA & cuDNN** support for GPU-accelerated AI tasks.
- **Pyenv** for managing Python versions.
- Integration with **ComfyUI**, **Stable Diffusion**, and **ControlNet** models.
- **Custom node installation** for advanced workflows and extensions.
- Ready-to-use **AI/ML models** from Hugging Face, including various **checkpoints** for text-to-image generation.

## 🛠️ Setup

### Prerequisites

Ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- NVIDIA GPU with proper drivers.
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) (for GPU acceleration).

### Steps to Build and Run

1. **Clone the repository** and navigate to the project root:

   ```bash
   git clone https://github.com/ddesmond/comfyui-docker-ubuntu.git
   cd https://github.com/ddesmond/comfyui-docker-ubuntu.git
   ```

2. **Build the Docker image**:

   ```bash
   docker-compose build
   ```

3. **Run the Docker container**:

   ```bash
   docker-compose up
   ```

   The service will run on port `7860`, accessible via `http://localhost:7860`.

## 🔧 Customization

You can modify the Docker build to suit your needs by adding models or adjusting the configuration.

### Example: Persistent Data

To enable persistent data storage, pass the `USE_PERSISTENT_DATA` argument:

```bash
docker-compose up -d
```

This will store outputs and models in `/data` on the host machine, ensuring that checkpoints and configurations are preserved.

## 🧠 Included AI Models


Refer to the Dockerfile for the exact models included and their paths.

## 📂 Directory Structure

- `/models`: Contains all downloaded models (checkpoints, VAE, Loras, etc.).
- `/code`: Working directory for the main codebase.
- `/data`: Optional directory for persistent data, checkpoints, and output.

## 🛠️ How to Add Custom Models

You can add custom models by modifying the `downloads.sh` and adding additional `wget` commands to download models or use external repositories.


## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🙌 Acknowledgments

- NVIDIA for CUDA and GPU acceleration.
- Hugging Face for pre-trained AI models.
- Stability AI for Stable Diffusion.

---

Feel free to modify or expand upon this depending on your specific project needs!