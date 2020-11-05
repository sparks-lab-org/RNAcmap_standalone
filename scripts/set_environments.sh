# environment settings


# set RNACMAP_DIR based on script position
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)



# path for ncbi-blast
# install with install_blast.sh, or edit the following path
path_blastn=$RNACMAP_DIR/3rd_party/blast/ncbi-blast-2.11.0+/bin
path_blastn_database=$RNACMAP_DIR/nt_database/infernal_database/nt

# path for infernal 1.1.3
# if infernal is installed but check_deps.sh can't find them, you can edit the path,
# or install it with provided scripts.
path_infernal=${RNACMAP_DIR}/3rd_party/infernal/infernal-1.1.3-linux-intel-gcc/binaries
path_infernal_database=$RNACMAP_DIR/nt_database/infernal_database/nt

# path for infernal 1.1.3
# if infernal is installed but check_deps.sh can't find them, you can edit the path,
# or install it with provided scripts.
path_spotrna=$RNACMAP_DIR/3rd_party/SPOT-RNA


# path for infernal 1.1.3
# if infernal is installed but check_deps.sh can't find them, you can edit the path,
# or install it with provided scripts.
path_rnastructure=$RNACMAP_DIR/3rd_party/RNAstructure/RNAstructure/exe/

# Matlab, Required for mfdca
path_matlab=/usr/local/bin

# temporarily change path env
export PATH=${RNACMAP_DIR}/bin:${path_infernal}:${path_blastn}:${path_rnastructure}:$PATH
