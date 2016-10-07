#!/bin/bash

set -e

Z=$1
D=`dirname $Z`
DN=$Z-uncompressed

rm -rf $DN
mkdir $DN
unzip -d $DN $Z 

python3 sdat2img/sdat2img.py $DN/system.transfer.list $DN/system.new.dat $DN/system.img

mkdir $DN/system-fs
sudo mount -o loop $DN/system.img $DN/system-fs
