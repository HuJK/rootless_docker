#!/bin/bash
echo "options overlay permit_mounts_in_userns=1" > /etc/modprobe.d/rootless_docker.conf
echo "kernel.unprivileged_userns_clone=1" > /etc/sysctl.d/99-rootless_docker.conf
grep -qxF "source <( /etc/rootless_docker/start_dockerd.sh )" /etc/skel/.bashrc || echo "source <( /etc/rootless_docker/start_dockerd.sh )" >> /etc/skel/.bashrc

sysctl --system

apt-get install -y uidmap iptables tmux
apt-get install -y nvidia-container-runtime
export dv=20.10.5
mkdir download
cd download
wget https://download.docker.com/linux/static/stable/$(uname -m)/docker-$dv.tgz
wget https://download.docker.com/linux/static/stable/$(uname -m)/docker-rootless-extras-$dv.tgz
cd ..
tar -zxvf download/docker-$dv.tgz 
tar -zxvf download/docker-rootless-extras-$dv.tgz

cp -r docker/* bin
cp -r docker-rootless-extras/* bin
cp -r docker-rootless-user/* bin

rm -r docker docker-rootless-extras download
chmod 777 user_data
