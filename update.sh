#!/bin/bash

GEDIT_STARTER_KIT=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

echo "updating submodules"
git submodule foreach "git pull"
echo "done!"
source $GEDIT_STARTER_KIT/install.sh
