#!/bin/bash

## GREMLIN will be installed under 3rd_party

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/GREMLIN_CPP

git clone "https://github.com/sokrypton/GREMLIN_CPP" $working_dir
cd $working_dir
g++ -O3 -std=c++0x -o gremlin_cpp gremlin_cpp.cpp -fopenmp

mkdir -p $RNACMAP_DIR/bin
ln -s $working_dir/gremlin_cpp $RNACMAP_DIR/bin/gremlin_cpp