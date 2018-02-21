ENV NSPAWN_BOOTSTRAP_IMAGE_SIZE=20GB
FROM ubuntu:xenial

# set unlimited bash history
# nspawn needs resolv.conf to be set up for internet to work
# password gets changeed so we can login later
RUN echo "export HISTFILESIZE=" >> .bashrc && \
  echo "export HISTSIZE=" >> .bashrc && \
  rm -f /etc/resolv.conf && echo '8.8.8.8' > /etc/resolv.conf && \
  echo "root:root" | chpasswd && \
  mkdir /usr/local/anacapa

# install apt + npm dependencies
RUN apt-get install software-properties-common apt-transport-https curl wget git libssl-dev libcurl4-openssl-dev libxml2-dev -y && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
  add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/' && \
  add-apt-repository universe && \
  apt-get update && \
  apt-get install r-base -y && \
  wget -P /tmp/ "http://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh" && \
  bash "/tmp/Anaconda2-5.0.1-Linux-x86_64.sh" -b -p /usr/local/anacapa/anaconda && \
  echo "export PATH=/usr/local/anacapa/anaconda/bin:\$PATH" >> /usr/local/anacapa/.bashrc && \
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  apt-get install -y nodejs && \
  npm i dat -g

# download scripts from this gist
RUN cd /usr/local/anacapa && \
  git clone https://gist.github.com/maxogden/7ad5c0e81ee003fde843f6a133d94b86 gist && \
  mv gist/run.sh run.sh && \
  chmod +x run.sh && \
  Rscript --vanilla gist/install-deps.R && \
  pip install biopython cutadapt

# install hoffman software
RUN cd /usr/local/anacapa && \
  dat clone $HOFFMANDEPS hoffman-deps && \
  tar xzvf hoffman-deps/fastx_toolkit.tar.gz && \
  mkdir -p /u/local && \
  ln -s /usr/local/anacapa/apps /u/local/apps && \
  echo "export PATH=/usr/local/anacapa/apps/fastx_toolkit/0.0.13.2/gcc-4.4.6/bin/:\$PATH" >> .bashrc && \
  tar xzvf hoffman-deps/libgtextutils.tar.gz && \
  echo "/usr/local/anacapa/apps/libgtextutils/0.6.1/gcc-4.4.6/lib/" > /etc/ld.so.conf.d/libgtextutils.conf && \
  ldconfig && \
  tar xzvf hoffman-deps/bowtie2-2.2.9.tar.gz && \
  echo "export PATH=/usr/local/anacapa/apps/bowtie2/2.2.9:\$PATH" >> .bashrc && \
  cp hoffman-deps/muscle3.8.31_i86linux64 /usr/local/bin/muscle && \
  chmod +x /usr/local/bin/muscle
