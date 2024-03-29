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
}' > $storage_path/$(whoami)/.config/docker/daemon.json

cp -rnp bin $storage_path/$(whoami)
cd $storage_path/$(whoami)/bin

export HOME=$storage_path/$(whoami)
export XDG_RUNTIME_DIR="$HOME/.docker/run"

export PATH=${storage_path}/$(whoami)/bin:$PATH
export DOCKER_HOST=unix://${storage_path}/$(whoami)/.docker/run/docker.sock

tmux has-session -t dockerd 2>/dev/null
if [ $? != 0 ]; then
  # Running dockerd in background
  tmux new -d -s dockerd ./dockerd-rootless-tmux.sh $storage_path
  #./dockerd-rootless-tmux.sh $storage_path
fi

{ # try
    if [ ! -f ~/.rootless_docker_success ]; then
        sleep 1 &&
        docker run --rm -it busybox true &&
        echo 1 > ~/.rootless_docker_success
    else
        true
    fi
} || { # catch
    # Restart dockerd
    tmux send-keys -t dockerd C-c
    sleep 3
    tmux kill-session -t dockerd
    tmux new -d -s dockerd ./dockerd-rootless-tmux.sh $storage_path
}

echo "export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}"
echo "export PATH=${PATH}"
echo "export DOCKER_HOST=${DOCKER_HOST}"
