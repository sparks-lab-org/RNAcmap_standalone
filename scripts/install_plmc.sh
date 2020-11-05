#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/plmc

git clone 'https://github.com/debbiemarkslab/plmc' $working_dir
cd $working_dir

make all-openmp

mkdir -p $RNACMAP_DIR/bin

ln -s $working_dir/bin/plmc $RNACMAP_DIR/bin/plmc