FROM ubuntu:16.04

ENV NSPAWN_BOOTSTRAP_IMAGE_SIZE=10GB

# install singularity config files
COPY anacapa /usr/local/anacapa
RUN cd /usr/local/anacapa/singularity-files && \
  cp -r ./ /
  
# install apt + npm dependencies
RUN apt-get update && \
  apt-get install --yes \
    build-essential \
    software-properties-common \
    apt-transport-https \
    curl \
    wget \
    git \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    gfortran -y && \
  ln -s /bin/gzip /usr/bin/gzip && \
  wget -P /tmp/ "https://repo.continuum.io/miniconda/Miniconda2-4.7.10-Linux-x86_64.sh" && \
  bash "/tmp/Miniconda2-4.7.10-Linux-x86_64.sh" -b -p /usr/local/anacapa/miniconda

ENV PATH "/usr/local/anacapa/miniconda/bin:${PATH}"
 
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs && \
  npm i dat -g

# install python modules
RUN pip install --upgrade pip && \
  pip install biopython cutadapt && \
  conda config --add channels r && \
  conda config --add channels defaults && \
  conda config --add channels conda-forge && \
  conda config --add channels bioconda && \
  conda update --all -c defaults

RUN conda install -yqc bioconda \
    bioconductor-impute \
    bioconductor-genefilter \
    bioconductor-phyloseq \
    bioconductor-dada2 \
    bioconductor-genomeinfodbdata \
    ecopcr \
    obitools \
    blast \
    bowtie2 \
    libiconv \
    cogent \
    pandas

ENV PATH "/usr/local/anacapa/miniconda/lib/R/bin:${PATH}"

RUN apt-get install --yes zlib1g-dev libgit2-dev 

RUN Rscript --vanilla /usr/local/anacapa/install-deps.R

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

ENV PATH "/act/sge/bin/linux-x64:/usr/local/anacapa/apps/bowtie2/2.2.9:/usr/local/anacapa/apps/fastx_toolkit/0.0.13.2/gcc-4.4.6/bin/:/usr/local/anacapa/miniconda/bin:${PATH}"