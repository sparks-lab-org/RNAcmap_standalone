#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/RNAstructure

mkdir -p $working_dir

cd $working_dir

wget http://rna.urmc.rochester.edu/Releases/current/RNAstructureLinuxTextInterfaces64bit.tgz

tar xvf RNAstructureLinuxTextInterfaces64bit.tgz

rm -f RNAstructureLinuxTextInterfaces64bit.tgz



ln -rs RNAstructure/exe/* $RNACMAP_DIR/bin/




