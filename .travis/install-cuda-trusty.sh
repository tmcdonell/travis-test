#!/bin/bash

set +e  # exit immediately on error
set +x  # echo commands before they are executed

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_${CUDA}_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404_${CUDA}_amd64.deb
sudo apt-get update -qq
export CUDA_APT=${CUDA%-*}
export CUDA_APT=${CUDA_APT/./-}
sudo apt-get install -y cuda-drivers cuda-core-${CUDA_APT} cuda-cudart-dev-${CUDA_APT}
sudo apt-get clean
export CUDA_HOME=/usr/local/cuda-${CUDA%%-*}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
export PATH=${CUDA_HOME}/bin:${PATH}

