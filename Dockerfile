
# Get the base Ubuntu image from Docker Hub
FROM ubuntu:18.04
# FROM continuumio/anaconda3:latest

LABEL maintainer="zhaoying@comp.nus.edu.sg"

RUN apt-get update \
        && apt-get install  -y g++ software-properties-common \
        && add-apt-repository ppa:ubuntu-toolchain-r/test \
        && apt update \
        && apt install -y make gcc-9 clang-6.0 llvm-6.0 build-essential cmake git\
        && apt-get install -y libstdc++6 curl wget htop\
	&& wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh -O ~/anaconda.sh  \
    	&& /bin/bash ~/anaconda.sh -b -p /opt/conda  \
    	&& rm ~/anaconda.sh 

ENV PATH /opt/conda/bin:$PATH
COPY lisa.yml /
RUN git clone --recurse-submodules https://github.com/ecolab-nus/lisa.git /home/lzy/lisa && /opt/conda/bin/conda init bash && conda env create -f lisa.yml 
