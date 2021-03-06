#!/bin/bash

set -e  # exit immediately on error
set -x  # echo commands before they are executed

travis_retry wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_${CUDA}_amd64.deb
# travis_retry sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
travis_retry sudo dpkg -i cuda-repo-ubuntu1404_${CUDA}_amd64.deb

# travis_retry wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_${CUDA}_amd64.deb
# travis_retry sudo dpkg -i cuda-repo-ubuntu1604_${CUDA}_amd64.deb
# travis_retry sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

travis_retry sudo apt-get update -qq
export CUDA_VER=$(expr ${CUDA} : '\([0-9]*\.[0-9]*\)')
export CUDA_APT=${CUDA_VER/./-}
travis_retry sudo apt-get install -y nvidia-settings cuda-drivers cuda-core-${CUDA_APT} cuda-cudart-dev-${CUDA_APT} cuda-cufft-dev-${CUDA_APT} cuda-cublas-dev-${CUDA_APT} cuda-cusparse-dev-${CUDA_APT}
# cuda-cusolver-dev-${CUDA_APT}
travis_retry sudo apt-get clean
export CUDA_HOME=/usr/local/cuda-${CUDA_VER}
export LD_LIBRARY_PATH=${CUDA_HOME}/nvvm/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
export PATH=${CUDA_HOME}/bin:${PATH}

set +xe

