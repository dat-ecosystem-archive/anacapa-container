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

# install anacapa dependencies
