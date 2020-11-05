# environment settings
# DO NOT MOVE

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)



# path for ncbi-blast
path_blastn=/project/aspen/software/ncbi-blast-2.2.30+/bin
path_blastn_database=/project/aspen/TC/GIT/DATA/NT/nt/nt

#path for infernal 1.1.3
path_infernal=${RNACMAP_DIR}/3rd_party/infernal/infernal-1.1.3-linux-intel-gcc/binaries
path_infernal_database=/project/aspen/TC/DATA/NT/fasta/nt

#path for SPOT-RNA
path_spotrna=$RNACMAP_DIR/3rd_party/SPOT-RNA

# Required for mfdca
path_matlab=/usr/local/bin

export PATH=${RNACMAP_DIR}/bin:$PATH

export PATH=${path_infernal}:$PATH

export PATH=${path_blastn}:$PATH