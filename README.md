# rootless-docker
Setup rootless docker with nvidia-gpu in one command.
Only tested on Ubuntu 18.04 and 20.04

Step1: root user prepare
----
Run following command with root
```
cd /etc
git clone --depth 1 https://github.com/HuJK/rootless_docker.git
cd rootless_docker
./root_prepare.sh
``` 

Step2: Now, all users can use docker command without add them to docker group.
----
Users can run this command to setup their own docker daemon. I suggest to put it in .bashrc
```
$ source <( /etc/rootless_docker/start_dockerd.sh )
```

then users can use ```docker run -it --rm nvidia/cuda:10.0-base bash``` normaly without root.
