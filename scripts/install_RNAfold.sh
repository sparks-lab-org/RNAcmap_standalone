#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/

wget -c 'https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.14.tar.gz'
tar -zxvf ViennaRNA-2.4.14.tar.gz
rm ViennaRNA-2.4.14.tar.gz
cd ViennaRNA-2.4.14
./configure --prefix=$working_dir/RNAfold
make
make install
cd ../
rm -r ViennaRNA-2.4.14

mkdir -p $RNACMAP_DIR/bin
ln -s $working_dir/RNAfold/RNAfold $RNACMAP_DIR/bin/RNAfold