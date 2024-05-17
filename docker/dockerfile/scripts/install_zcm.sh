#!/bin/bash

# Fail on first error.
set -e

export TERM=xterm
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

mkdir -p /tmp/installers && cd /tmp/installers
wget https://github.com/ZeroCM/zcm/tarball/229f726 -O ZeroCM-zcm-229f726.tar.gz && tar xzf ZeroCM-zcm-229f726.tar.gz && cd ZeroCM-zcm-229f726

# Install dependencies
sed -i 's/sudo //g' scripts/install-deps.sh # docker doesn't support `sudo`
sed -i '/apt-get update/i apt-get clean' scripts/install-deps.sh # To fix the possibility of install failure
sed -i 's/apt-get update/apt-get update --fix-missing/g' scripts/install-deps.sh # # To fix the possibility of install failure
sed -i '67,73d' scripts/install-deps.sh # do not upgrade pip

chmod +x scripts/* waf
bash scripts/install-deps.sh 

# Compile
./waf configure --use-java --use-python --python=/usr/bin/python3.6 --use-zmq  --use-elf  --use-third-party  --use-ipc --use-inproc --use-udpm && ./waf build && ./waf install

# Install Python Package Manually
cp build/zcm/python/zerocm.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages/ 

# Clean up
cd && rm -rf /tmp/installers/ZeroCM*

ldconfig
