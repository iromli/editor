#!/bin/bash

GEDIT_STARTER_KIT=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

echo "initializing submodules"
git submodule update --init
echo "done!"
source $GEDIT_STARTER_KIT/install.sh
