
# Get the base Ubuntu image from Docker Hub
FROM ubuntu:18.04
# FROM continuumio/anaconda3:latest

LABEL maintainer="zhaoying@comp.nus.edu.sg"
COPY lisa  /home/lzy/lisa/
RUN apt-get update \
        && apt-get install  -y g++ software-properties-common \
        && add-apt-repository ppa:ubuntu-toolchain-r/test \
        && apt update \
        && apt install -y make gcc-9 clang-6.0 llvm-6.0 build-essential cmake \
        && apt-get install -y libstdc++6 curl wget htop\
	&& wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh -O ~/miniconda.sh  \
    	&& /bin/bash ~/miniconda.sh -b -p /opt/conda  \
    	&& rm ~/miniconda.sh 

ENV PATH /opt/conda/bin:$PATH
COPY lisa.yml /
RUN /opt/conda/bin/conda init bash && conda env create -f lisa.yml 
