# check required scripts
# please source this script before run_rnacmap.sh
# DO NOT MOVE

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)


path_blastn=./ncbi-blast-2.10.0+/bin
path_blastn_database=./nt_database/nt
path_infernal=./infernal-1.1.3-linux-intel-gcc/binaries
path_infernal_database=./nt_database/nt
path_matlab=/usr/local/bin
