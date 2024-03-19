FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-runtime
WORKDIR /home/webui
RUN apt update && apt install -y git
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui && cd stable-diffusion-webui

WORKDIR /home/webui/stable-diffusion-webui

RUN python3 -m venv venv

RUN . venv/bin/activate
RUN pip install -r requirements.txt
# install tcmalloc
RUN apt-get update && apt-get install -y libtcmalloc-minimal4 libgl1-mesa-glx ffmpeg libsm6 libxext6 ibglib2.0-0 libxrender1

# Create a user
RUN useradd -ms /bin/bash webui
# add permissions for current dir to the new user
RUN chown -R webui:webui /home/webui/stable-diffusion-webui
# add /home/webui/.cache to the new user
RUN mkdir /home/webui/.cache
RUN chown -R webui:webui /home/webui/.cache
# add /home/webui/.torch to the new user
RUN mkdir /home/webui/.torch
RUN chown -R webui:webui /home/webui/.torch
# add /home/webui/.local to the new user
RUN mkdir /home/webui/.local
RUN chown -R webui:webui /home/webui/.local

# add pip cache to the new user
RUN mkdir /home/webui/.cache/pip
RUN chown -R webui:webui /home/webui/.cache/pip

COPY prepare.py ./prepare.py

# Change to the new user
USER webui

RUN python prepare.py
# Set the working directory

CMD ["./webui.sh"]

EXPOSE 8000