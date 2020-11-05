#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/infernal

mkdir -p $working_dir

cd $working_dir

wget http://eddylab.org/infernal/infernal-1.1.3-linux-intel-gcc.tar.gz

tar xvf infernal-1.1.3-linux-intel-gcc.tar.gz

rm -f infernal-1.1.3-linux-intel-gcc.tar.gz

