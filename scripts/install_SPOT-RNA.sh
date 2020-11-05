#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

working_dir=$RNACMAP_DIR/3rd_party/SPOT-RNA

git clone https://github.com/jaswindersingh2/SPOT-RNA.git $working_dir
cd $working_dir
wget -O SPOT-RNA-models.tar.gz 'https://app.nihaocloud.com/f/fbf3315a91d542c0bdc2/?dl=1' ||wget 'https://www.dropbox.com/s/dsrcf460nbjqpxa/SPOT-RNA-models.tar.gz'  

tar -xvzf SPOT-RNA-models.tar.gz && rm SPOT-RNA-models.tar.gz

## Use conda
eval "$(conda shell.bash hook)" 
conda activate venv_rnacmap
conda install --yes tensorflow==1.14.0 
conda install --yes --file requirements.txt


## Or use virtual environment
# source ../venv_rnacmap/bin/activate 
# pip install tensorflow==1.14.0
# pip install -r requirements.txt 