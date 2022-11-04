FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime

# install git
RUN apt-get -y update
RUN apt-get -y install git

# base libs
RUN pip install \
    scikit-learn \
    pandas \

RUN mkdir /app
WORKDIR /app
COPY ./* .

CMD ["tail", "-f", "/etc/hosts"]