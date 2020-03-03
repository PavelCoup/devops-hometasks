#!/bin/bash

####################################################################################################

# https://habr.com/ru/company/ruvds/blog/438796/

apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
adduser ${USER} docker
usermod -a -G docker $(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)


# windows wsl + remote docker daemon
# https://nickjanetakis.com/blog/docker-tip-73-connecting-to-a-remote-docker-daemon
# https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly

####################################################################################################

# https://habr.com/ru/company/ruvds/blog/450312/

curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


docker ps -a




