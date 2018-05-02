ENV NSPAWN_BOOTSTRAP_IMAGE_SIZE=10GB
FROM ubuntu:xenial

# install singularity config files
COPY anacapa /usr/local/anacapa
RUN cd /usr/local/anacapa/singularity-files && \
  cp -r ./ /

# set unlimited bash history
# nspawn needs resolv.conf to be set up for internet to work
# root password gets changed to 'root'
RUN cd /usr/local/anacapa && \
  echo "export HISTFILESIZE=" >> .bashrc && \
  echo "export HISTSIZE=" >> .bashrc && \
  rm -f /etc/resolv.conf && echo '8.8.8.8' > /etc/resolv.conf && \
  echo "root:root" | chpasswd
  
# install apt + npm dependencies
RUN apt-get install build-essential software-properties-common apt-transport-https curl wget git libssl-dev libcurl4-openssl-dev libxml2-dev gfortran -y && \
  wget -P /tmp/ "http://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh" && \
  bash "/tmp/Anaconda2-5.0.1-Linux-x86_64.sh" -b -p /usr/local/anacapa/anaconda && \
  echo "export PATH=/usr/local/anacapa/anaconda/bin:\$PATH" >> /usr/local/anacapa/.bashrc && \
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  apt-get install -y nodejs && \
  npm i dat -g

# install python modules
RUN cd /usr/local/anacapa && \
  . /usr/local/anacapa/.bashrc && \
  pip install biopython cutadapt && \
  conda config --add channels r && \
  conda config --add channels defaults && \
  conda config --add channels conda-forge && \
  conda config --add channels bioconda && \
  conda install -yqc bioconda bioconductor-impute bioconductor-genefilter bioconductor-phyloseq bioconductor-dada2 ecopcr obitools blast bowtie2 libiconv && \
  Rscript --vanilla install-deps.R

# install bundled software
RUN cd /usr/local/anacapa && \
  tar xzvf fastx_toolkit.tar.gz && \
  mkdir -p /u/local && \
  ln -s /usr/local/anacapa/apps /u/local/apps && \
  echo "export PATH=/usr/local/anacapa/apps/fastx_toolkit/0.0.13.2/gcc-4.4.6/bin/:\$PATH" >> .bashrc && \
  tar xzvf libgtextutils.tar.gz && \
  echo "/usr/local/anacapa/apps/libgtextutils/0.6.1/gcc-4.4.6/lib/" > /etc/ld.so.conf.d/libgtextutils.conf && \
  ldconfig && \
  tar xzvf bowtie2-2.2.9.tar.gz && \
  echo "export PATH=/usr/local/anacapa/apps/bowtie2/2.2.9:\$PATH" >> .bashrc && \
  cp muscle3.8.31_i86linux64 /usr/local/bin/muscle && \
  chmod +x /usr/local/bin/muscle