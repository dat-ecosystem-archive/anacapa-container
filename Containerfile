ENV NSPAWN_BOOTSTRAP_IMAGE_SIZE=10GB
FROM ubuntu:xenial

# unlimited bash history
RUN echo "export HISTFILESIZE=" >> .bashrc
RUN echo "export HISTSIZE=" >> .bashrc

# nspawn needs resolv.conf to be set up
RUN rm -f /etc/resolv.conf && echo '8.8.8.8' > /etc/resolv.conf

# install anacapa dependencies
RUN apt-get install software-properties-common apt-transport-https curl -y
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 # R
RUN add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/' # R
RUN apt-get update
RUN apt-get install r-base -y

# node + dat
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN npm i dat -g

# Anacapa_db
RUN dat clone abf59db56b915d6642edabd39121a790093596f76a634201ba3ec11893e716c5 Anacapa_db
RUN dat clone b67f9eafb5a5796ddfb0278acdfbf411f492f1d48b1a07bca4714364ff7dc6ff hoffman-deps

RUN tar xzvf hoffman-deps/fastx_toolkit.tar.gz
RUN echo "export PATH=/root/apps/fastx_toolkit/0.0.13.2/gcc-4.4.6/bin/:\$PATH" >> .bashrc

# libgtext shared library
RUN tar xzvf hoffman-deps/libgtextutils.tar.gz
RUN echo "/root/apps/libgtextutils/0.6.1/gcc-4.4.6/lib/" > /etc/ld.so.conf.d/libgtextutils.conf
RUN ldconfig # update cache

# python w/ lots of preinstalled packages
RUN tar xzvf hoffman-deps/python-2.7.13.tar.gz
RUN echo "export PATH=/root/apps/python/2.7.13/bin:\$PATH" >> .bashrc

# bowtie2
RUN tar xzvf hoffman-deps/bowtie2-2.2.9.tar.gz
RUN echo "export PATH=/root/apps/bowtie2/2.2.9:\$PATH" >> .bashrc