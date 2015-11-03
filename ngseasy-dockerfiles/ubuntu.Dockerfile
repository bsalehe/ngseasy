# base image
FROM ubuntu:14.04.3
# Maintainer
MAINTAINER Stephen Newhouse stephen.j.newhouse@gmail.com
# Remain current
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get dist-upgrade -y
# Basic dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-utils \
  automake \
  bash \
  binutils \
  perl \
  bioperl \
  build-essential \
  bzip2 \
  c++11 \
  cmake \
  cron \
  curl \
  dkms \
  dpkg-dev \
  g++ \
  gpp \
  gcc \
  gfortran \
  git \
  git-core \
  libblas-dev \
  libatlas-dev \
  libbz2-dev \
  liblzma-dev \
  libpcre3-dev \
  libreadline-dev \
  make \
  php5-curl \
  python python-dev python-yaml ncurses-dev zlib1g-dev python-numpy python-pip \
  sudo \
  tabix \
  tree \
  unzip \
  vim \
  wget \
  python-software-properties \
  libc-bin \
  llvm \
  libconfig-dev \
  ncurses-dev \
  zlib1g-dev \
  libX11-dev libXpm-dev libXft-dev libXext-dev

# get java 7
RUN apt-get install -y openjdk-7-jdk openjdk-7-doc openjdk-7-jre-lib

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java

# Create a pipeline user:ngseasy and group:ngseasy
RUN useradd -m -U -s /bin/bash ngseasy && \
  cd /home/ngseasy && \
  echo "#bash config file for user ngseasy" >> /home/ngseasy/.bashrc && \
  usermod -aG sudo ngseasy

# make pipeline install dirs
RUN mkdir /usr/local/pipeline && \
    chown ngseasy:ngseasy /usr/local/pipeline

# PERMISSIONS
RUN chmod -R 777 /usr/local/pipeline
RUN chown -R ngseasy:ngseasy /usr/local/pipeline

# Cleanup the temp dir
RUN rm -rvf /tmp/*

# open ports private only
EXPOSE 8080

# Use baseimage-docker's bash.
CMD ["/bin/bash"]

# Clean up APT when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
