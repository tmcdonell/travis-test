#!/bin/bash

set -x

# Install and upgrade the dependencies. Since we cache the cabal directory, if
# there are any problems throw it away and try again.
#
cabal install --only-dependencies --upgrade-dependencies --enable-tests --force-reinstalls
status=$?

if [ $status -ne 0 ]; then
    rm -rf $HOME/.ghc
    rm -rf $HOME/.cabal/bin
    rm -rf $HOME/.cabal/lib
    rm -rf $HOME/.cabal/share
fi
exit $status

