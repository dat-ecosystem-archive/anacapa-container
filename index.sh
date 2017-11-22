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

# install anacapa dependencies
apt-get update
apt-get install wget -y

wget http://10.240.0.4:8080/fastx_toolkit.tar.gz
tar xzvf fastx_toolkit.tar.gz
echo "export PATH=/root/apps/fastx_toolkit/0.0.13.2/gcc-4.4.6/bin/:\$PATH" >> .bashrc

# shared library
wget http://10.240.0.4:8080/libgtextutils.tar.gz
tar xzvf libgtextutils.tar.gz
echo "/root/apps/libgtextutils/0.6.1/gcc-4.4.6/lib/" > /etc/ld.so.conf.d/libgtextutils.conf
ldconfig # update cache


