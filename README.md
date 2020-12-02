# rootless-docker
Setup rootless docker with nvidia-gpu in one command.
Only tested on 

Step1:
----
Run ```root_prepare.sh``` with root

Step2:
----
Users can run this command to setup their own docker daemon. I suggest to put it in .bashrc
```
$ source <( /etc/rootless_docker/start_dockerd.sh )
```

then users can use ```docker run -it --rm nvidia/cuda:10.0-base bash``` normaly without root.
