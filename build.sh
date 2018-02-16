#!/usr/bin/bash
mkdir mnt cache
set -e
mkcontainer-generate
make CACHE=$PWD/cache
sudo losetup -Pf container.img
sudo mount /dev/loop0p1 mnt
sudo singularity build --writable singularity.img mnt
sudo umount mnt
