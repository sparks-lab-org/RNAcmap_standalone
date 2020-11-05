# environment settings
# DO NOT MOVE

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)



# path for ncbi-blast
path_blastn=/project/aspen/software/ncbi-blast-2.2.30+/bin
path_blastn_database=$RNACMAP_DIR/nt_database/blastn_database/nt

# path for infernal 1.1.3
# install with install_infernal.sh, or edit the following links
path_infernal=${RNACMAP_DIR}/3rd_party/infernal/infernal-1.1.3-linux-intel-gcc/binaries
path_infernal_database=$RNACMAP_DIR/nt_database/infernal_database/nt

# path for SPOT-RNA
path_spotrna=$RNACMAP_DIR/3rd_party/SPOT-RNA


# path for RNAstructure

path_rnastructure=$RNACMAP_DIR/3rd_party/RNAstructure/RNAstructure/exe/

# Matlab, Required for mfdca
path_matlab=/usr/local/bin

# temporarily change path env
export PATH=${RNACMAP_DIR}/bin:${path_infernal}:${path_blastn}:${path_rnastructure}:$PATH
