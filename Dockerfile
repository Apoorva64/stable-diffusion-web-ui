FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-runtime
WORKDIR /home/webui
RUN apt update && apt install -y git
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui && cd stable-diffusion-webui

WORKDIR /home/webui/stable-diffusion-webui

RUN python3 -m venv venv

RUN . venv/bin/activate
RUN pip install -r requirements.txt
# Create a user
RUN useradd -ms /bin/bash webui
# Change to the new user
USER webui
# Set the working directory

CMD ["./webui.sh"]

EXPOSE 8000