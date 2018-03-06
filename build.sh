#!/bin/bash
# builds container from Containerfile
# usage: ./build.sh. change CACHE dir to your own path where cached build layers should live
mkcontainer-generate && make CACHE=/mnt/bigdisk/UCLA/container/cache &> buildlog.txt 
