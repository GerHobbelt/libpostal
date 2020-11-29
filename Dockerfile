FROM python:3.8-slim-buster AS base

RUN apt-get update && \
     apt-get -y install curl autoconf automake libtool pkg-config

WORKDIR /
#COPY . /libpostal/
RUN apt-get install -y git && \
    git clone --depth 1 --branch v1.1.1 https://github.com/raph84/libpostal.git

WORKDIR /libpostal

RUN  ./bootstrap.sh && \
     ./configure --datadir=/libpostal_data && \
     make -j4 && \
     make install && \
     ldconfig && \ 
     rm -rf /var/lib/apt/lists/* && \
     cd / && \ 
     /bin/bash -c "pip3 install postal"

#TODO build tool cleanup