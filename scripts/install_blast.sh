#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/blast

mkdir -p $working_dir

cd $working_dir

wget 'ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-*+-x64-linux.tar.gz'
tar -xvzf ncbi-blast-*+-x64-linux.tar.gz && rm ncbi-blast-*+-x64-linux.tar.gz
ln -rs $RNACMAP_DIR/3rd_party/blast/ncbi-blast-*+/bin/blastn $RNACMAP_DIR/bin/