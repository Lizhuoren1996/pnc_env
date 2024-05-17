#!/bin/bash
set -ue

sudo dpkg -i *.deb


sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker