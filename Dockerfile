
FROM ubuntu:22.04

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

#ARG SSH_PRIVATE_KEY
RUN apt-get update && apt-get install -y tzdata curl git vim \
  && apt-get install python3 python3-pip python3-setuptools -y 

RUN curl -sL https://deb.nodesource.com/setup_20.x  | bash
RUN apt-get -yq install nodejs

RUN git clone https://github.com/mlc-ai/web-llm.git
RUN cd web-llm
RUN pip3 install -r requirements.txt

RUN cd ..
RUN git clone https://github.com/emscripten-core/emsdk.git
RUN cd emsdk
RUN git pull
RUN ./emsdk activate latest
RUN source ./emsdk_env.sh