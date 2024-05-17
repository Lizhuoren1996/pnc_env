#!/bin/bash

set -ue 

mkdir -p /tmp/btree && cd /tmp/btree

wget https://github.com/BehaviorTree/BehaviorTree.CPP.git
cd BehaviorTree.CPP
mkdir build
cd build
cmake ..
make
sudo make install
