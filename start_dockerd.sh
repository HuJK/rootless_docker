#!/bin/bash
cd /etc/rootless_docker
#set -x
storage_path=/etc/rootless_docker/user_data
mkdir -p $storage_path/$(whoami)/.config/docker/

echo '{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}' >> $storage_path/$(whoami)/.config/docker/daemon.json

cp -rnp bin $storage_path/$(whoami)
cd $storage_path/$(whoami)/bin
export XDG_RUNTIME_DIR="$HOME/.docker/run"
tmux new -d -s dockerd ./dockerd-rootless-tmux.sh $storage_path
#./dockerd-rootless-tmux.sh $storage_path

echo "Set following envirement variables or save it in your .bashrc to use docker."
echo "Anyway, if you didn't get what I say(envirement variables .bashrc stuff)"
echo "Just run me, then copy and past following text in your terminal before you want to use docker"
echo "==============================================================================================="
echo "export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}"
echo "export PATH=${storage_path}/$(whoami)/bin:$PATH"
echo "export DOCKER_HOST=unix:///${storage_path}/$(whoami)/.docker/run/docker.sock"
