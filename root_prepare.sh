#!/bin/bash
apt-get install -y uidmap iptables nvidia-container-runtime
apt-get install tmux newuidmap newgidmap
export dv=19.03.9
mkdir download
cd download
wget https://download.docker.com/linux/static/stable/x86_64/docker-$dv.tgz
wget https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-$dv.tgz
cd ..
tar -zxvf download/docker-$dv.tgz 
tar -zxvf download/docker-rootless-extras-$dv.tgz

cp -r docker/* bin
cp -r docker-rootless-extras/* bin
cp -r docker-rootless-user/* bin

rm -r docker docker-rootless-extras download

