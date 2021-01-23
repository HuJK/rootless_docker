# rootless-docker
Setup rootless docker with nvidia-gpu in one command.

This allows all users use nvidia-docker without root nor docker group. All process will userns-remapped, so users won't able break the system even mount ```/``` in docker.

Only tested on Ubuntu 18.04 and 20.04

Step1: root user prepare
----
Run following command with root
```
cd /etc
sudo git clone --depth 1 https://github.com/HuJK/rootless_docker.git
cd rootless_docker
sudo bash ./install-rootless-docker.sh
``` 

Step2: Now, all users can use docker command without add them to docker group.
----
Users can run this command to setup their own docker daemon and environment. I suggest puting it in user's .bashrc or .zshrc
```
#bash or zsh
$ source <( /etc/rootless_docker/start_dockerd.sh )


#fish
> /etc/rootless_docker/start_dockerd.sh | source
```

now users can use 
```docker run -it --gpus=all --rm nvidia/cuda:10.0-base bash``` 
normaly without root privilege nor docker group.

note: ubuntu20.04 users may get error
----

```
docker: Error response from daemon: OCI runtime create failed: /etc/rootless_docker/user_data/user/.local/share/docker/overlay2/c4e36d1dd8273cdb5818d21b62d9248ffc02521aa1e6f13e2df11492aef113a4/merged is not an absolute path or is a symlink: unknown.
```
they need to run this command to slove the issue. I have no idea why, it may be docker's bug.
```
tmux kill-session -t dockerd
source <( /etc/rootless_docker/start_dockerd.sh )
```
