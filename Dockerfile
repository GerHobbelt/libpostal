FROM python:3.8-slim-buster AS base

#RUN apt-get update && \
#     apt-get -y install curl autoconf automake libtool pkg-config

#COPY . /libpostal/
RUN apt-get update && apt-get install -y git && \
    git clone --depth 1 --branch v1.1.1 https://github.com/raph84/libpostal.git && \
    apt-get -y install curl \
                       autoconf \ 
                       automake \
                       libtool \
                       pkg-config \
                       build-essential && \
    cd /libpostal && \
    ls -l && \
    whereis autoreconf && \
    echo $PATH && \
    ls -l /bin/sh && \
    autoreconf -fi --warning=no-portability &&  \
    ./configure "--datadir=/libpostal_data" && \
    /usr/bin/make -j4 && \
    /usr/bin/make install && \
    ldconfig && \ 
    apt-get remove -y curl \
                       autoconf \ 
                       automake \
                       libtool \
                       pkg-config \
                       build-essential \
                       git && \ 
    rm -rf /var/lib/apt/lists/* && \
    cd /
RUN  /bin/bash -c "pip3 install postal"