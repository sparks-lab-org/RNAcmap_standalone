# checking 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

source $SCRIPT_DIR/set_environments.sh

echo "## checking infernal & Blastn"

for COMMAND in cmbuild cmcalibrate cmsearch esl-reformat blastn;do
    if ! command -v $COMMAND &> /dev/null
    then
        printf "%-24s  NOT FOUND\n" $COMMAND
    else
        printf "%-24s  OK\n" $COMMAND
    fi
done

echo "## checking 3rd party tools"

for COMMAND in gremlin_cpp plmc RNAfold ct2dot dot2ct RemovePseudoknots;do
    if ! command -v $COMMAND &> /dev/null
    then
        printf "%-24s  NOT FOUND\n" $COMMAND
    else
        printf "%-24s  OK\n" $COMMAND
    fi
done

for SCRIPT in $path_spotrna/SPOT-RNA.py \
               $SCRIPT_DIR/parse_blastn_local.pl \
               $SCRIPT_DIR/reformat.pl \
               $RNACMAP_DIR/3rd_party/k2n_standalone/knotted2nested.py \
               $SCRIPT_DIR/get_ss.py;do

    if [ ! -f $SCRIPT ];    then
        printf "%-24s  NOT FOUND\n" $(basename $SCRIPT)
    else
        printf "%-24s  OK\n" $(basename $SCRIPT)
    fi

done
