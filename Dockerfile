FROM debian:8.5
MAINTAINER David Asabina <vid@bina.me>
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git htop man unzip vim wget texlive texlive-binaries && \
  rm -rf /var/lib/apt/lists/*
WORKDIR /home/research
