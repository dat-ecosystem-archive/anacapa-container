# assumes node, npm, debootstrap, systemd-container
# create new .img with ubuntu installed
npm install -g nspawn-bootstrap
nspawn-bootstrap ./ubuntu-16.04.img --ubuntu xenial --size 4GB

# boot container to bash
sudo systemd-nspawn -i ./ubuntu-16.04.img /bin/bash

# change pw inside container
passwd

# exit container
<ctrl> + ]]]

# do proper boot into container
sudo systemd-nspawn -b -i ./ubuntu-16.04.img

# login with root/your pw

# unlimited bash history
echo "export HISTFILESIZE=" >> .bashrc
echo "export HISTSIZE=" >> .bashrc
source .bashrc

# nspawn needs resolv.conf to be set up
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
echo "DNS=8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844" >> /etc/systemd/resolved.conf

# install anacapa dependencies
apt-get update
apt-get install wget -y

# needed for R dynamic requires to work
ln -s /root/apps /u/local/apps

# not a public ip, but these tarballs come from hoffman2 /u/apps folder
wget http://10.240.0.4:8080/fastx_toolkit.tar.gz
tar xzvf fastx_toolkit.tar.gz
echo "export PATH=/root/apps/fastx_toolkit/0.0.13.2/gcc-4.4.6/bin/:\$PATH" >> .bashrc

# shared library
wget http://10.240.0.4:8080/libgtextutils.tar.gz
tar xzvf libgtextutils.tar.gz
echo "/root/apps/libgtextutils/0.6.1/gcc-4.4.6/lib/" > /etc/ld.so.conf.d/libgtextutils.conf
ldconfig # update cache

# python w/ lots of preinstalled packages
wget http://10.240.0.4:8080/python-2.7.13.tar.gz
tar xzvf python-2.7.13.tar.gz
echo "export PATH=/root/apps/python/2.7.13/bin:\$PATH" >> .bashrc
source .bashrc

# bowtie2
wget http://10.240.0.4:8080/bowtie2-2.2.9.tar.gz
tar xzvf bowtie2-2.2.9.tar.gz
echo "export PATH=/root/apps/bowtie2/2.2.9:\$PATH" >> .bashrc
source .bashrc
