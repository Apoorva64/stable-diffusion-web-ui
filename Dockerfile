FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-runtime
RUN apt update && apt install -y git
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui && cd stable-diffusion-webui
RUN python3 -m venv venv
# Create a user
RUN useradd -ms /bin/bash webui
# Change to the new user
USER webui
# Set the working directory
WORKDIR /home/webui/stable-diffusion-webui
CMD ["./webui.sh"]

EXPOSE 8000