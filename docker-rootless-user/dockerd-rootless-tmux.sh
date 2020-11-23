#!/bin/sh
export HOME=$1/$(whoami)
export PATH=$1/$(whoami)/bin:$PATH
export XDG_RUNTIME_DIR=$HOME/.docker/run
mkdir -p -m 700 "$XDG_RUNTIME_DIR"
echo "#!/bin/sh
/usr/bin/nvidia-container-runtime-hook -config=${HOME}/bin/config.toml \"\$@\"" > nvidia-container-runtime-hook
echo $(pwd)
bash dockerd-rootless.sh --experimental --storage-driver overlay2
