FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime

# install git
RUN apt-get -y update
RUN apt-get -y install git

RUN apt-get -y install libglib2.0-0 libsm6 libxext6 libxrender-dev nvidia-cuda-toolkit
# base libs
RUN pip install \
    scikit-learn \
    pandas

RUN mkdir /app
RUN mkdir -p /app/models/ldm/stable-diffusion-v1

WORKDIR /app

COPY assets /app/
COPY configs /app/
COPY data /app/
COPY ldm /app/
COPY models /app/
COPY scripts /app/
COPY environment.yaml /app/
COPY v1-5-pruned.ckpt /app/models/ldm/stable-diffusion-v1/model.ckpt
COPY main.py /app/
COPY setup.py /app/

RUN conda env create -f environment.yaml
RUN conda init bash
RUN source /root/.bashrc
RUN conda install accelerate
RUN conda activate ldm
RUN pip install accelerate


CMD ["tail", "-f", "/etc/hosts"]