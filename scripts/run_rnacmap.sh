#!/bin/bash




if [[ $# -lt 3 ]]; then
	echo "======================================================================"
	echo "              RNAcmap: A Fully Automatic pipeline                     "
	echo " for Predicting Contact Maps of RNAs by Evolutionary Coupling Analysis"                            
	echo "======================================================================"
    echo "Usage $0 input.fasta SSPredictor ECTOOL"
    echo "         input.fasta    Input RNA sequence in fasta format"
    echo "         SSPredictor    Tool for predicting RNA secondary structure."
    echo "                        Available options: [SPOT-RNA|RNAfold]"
    echo "         ECTOOL         Tool for calculating evolutionary coupling score."
    echo "                        Available options: [GREMLIN|plmc|mfDCA]"
    exit 1
fi

input=$1 
input_dir=$(dirname $1)
output_dir=$input_dir/outputs
seq_id=$(basename $(basename $input) .fasta)

# set script dir environment variable

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
RNACMAP_DIR=$(dirname $SCRIPT_DIR)

source $SCRIPT_DIR/set_environments.sh

source $RNACMAP_DIR/venv_rnacmap/bin/activate || eval "$(conda shell.bash hook)" &&conda activate venv_rnacmap


#echo $input_dir/$seq_id.bla

start=`date +%s`

if [ -f $input_dir/$seq_id.a2m ];	then
	echo "MSA file already exists."
else
	######## run blastn ################
	blastn -db $path_blastn_database -query $input -out $input_dir/$seq_id.bla -evalue 0.001 -num_descriptions 1 -num_threads 8 -line_length 1000 -num_alignments 50000

	######## reformat the output ################
	$SCRIPT_DIR/parse_blastn_local.pl $input_dir/$seq_id.bla $input_dir/$seq_id.fasta $input_dir/$seq_id.aln
	$SCRIPT_DIR/reformat.pl fas sto $input_dir/$seq_id.aln $input_dir/$seq_id.sto


	######## predict secondary ################
	if [[ $2 == 'SPOT-RNA' ]]; then
		echo "Running SPOT-RNA secondary structure predictor"

		source $RNACMAP_DIR/venv_rnacmap/bin/activate || eval "$(conda shell.bash hook)" &&conda activate venv_rnacmap
		python3 $path_spotrna/SPOT-RNA.py --inputs $input_dir/$seq_id.fasta --outputs $input_dir/
		
		######## remove pseudoknot from predicted SS
		# cd ../k2n_standalone
		# python2  $RNACMAP_DIR/3rd_party/k2n_standalone/knotted2nested.py -f bpseq -F vienna  $input_dir/$seq_id.bpseq | tail -n +3 > $input_dir/$seq_id.dbn
		# cd ../
		RemovePseudoknots $input_dir/${seq_id}.ct $input_dir/${seq_id}.rmpk.ct
		ct2dot $input_dir/${seq_id}.rmpk.ct 1 $input_dir/temp.dbn
		tail -n +3 $input_dir/temp.dbn  >$input_dir/$seq_id.dbn

	else
		echo "Running RNAfold secondary structure predictor"
		RNAfold $input | awk '{print $1}' | tail -n +3 > $input_dir/$seq_id.dbn
	fi
	
	################ reformat ss with according to gaps in reference sequence of .sto file from blastn ################
	for i in `awk '{print $2}' $input_dir/$seq_id.sto | head -n5 | tail -n1 | grep -b -o - | sed 's/..$//'`; do sed -i "s/./&-/$i" $input_dir/$seq_id.dbn; done

	#########  add reformated ss from last step to .sto file of blastn ##############
	head -n -1 $input_dir/$seq_id.sto > $input_dir/temp.sto
	echo "#=GC SS_cons                     "`cat $input_dir/$seq_id.dbn` > $input_dir/temp.txt
	cat $input_dir/temp.sto $input_dir/temp.txt > $input_dir/$seq_id.sto
	echo "//" >> $input_dir/$seq_id.sto

	######## run infernal ################
	cmbuild --hand -F $input_dir/$seq_id.cm $input_dir/$seq_id.sto
	cmcalibrate $input_dir/$seq_id.cm
	cmsearch -o $input_dir/$seq_id.out -A $input_dir/$seq_id.msa --cpu 24 --incE 10.0 $input_dir/$seq_id.cm $path_infernal_database

	######### reformat the output for dca input ###############
	esl-reformat --replace acgturyswkmbdhvn:................ a2m $input_dir/$seq_id.msa > $input_dir/$seq_id.a2m 
	cat $input_dir/$seq_id.a2m | awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' | sed '/^$/d' > $input_dir/temp.a2m # multiline fasta to single line fasta
    cat $input_dir/$seq_id.fasta $input_dir/temp.a2m > $input_dir/$seq_id.a2m # add query sequence at the top of MSA file
fi


mkdir -p $output_dir

echo "######### run dca predictor ###############"
######### run dca predictor ###############
if [[ $3 == 'plmc' ]]; then
	plmc -c $output_dir/$seq_id.dca_plmc -a -.ACGU -le 20 -lh 0.01 -m 50 $input_dir/$seq_id.a2m > $output_dir/$seq_id.log_plmc
elif [[ $3 == 'mf_DCA' ]]; then
	$path_matlab/matlab -nodisplay -nosplash -nodesktop < $SCRIPT_DIR/run_mfdca.m > $output_dir/$seq_id.log_mfDCA
else
	gremlin_cpp -alphabet rna -i $input_dir/$seq_id.a2m -o $output_dir/$seq_id.dca_gremlin > $output_dir/$seq_id.log_gremlin
fi

echo "############ save output in ct, bpseq and base-pair matrix #############"
############ save output in ct, bpseq and base-pair matrix #############
# source ./venv_rnacmap/bin/activate || conda activate venv_rnacmap
python3 $SCRIPT_DIR/get_ss.py --inputs_path $input_dir --rna_id $seq_id --outputs $output_dir

end=`date +%s`

runtime=$((end-start))

echo -e "\ncomputation time = "$runtime" seconds"


deactivate || conda deactivate