# RNAcmap
A Fully Automatic Pipeline for Predicting Contact Maps of RNAs by Evolutionary Coupling Analysis

SYSTEM REQUIREMENTS
====
Hardware Requirments:
----
RNAcmap predictor requires only a standard computer with around 32 GB RAM to support the in-memory operations for RNAs sequence length less than 500.

Software Requirments:
----
* [BLASTN](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)
* [Infernal](http://eddylab.org/infernal/)
* [RNAstructure](https://rna.urmc.rochester.edu/RNAstructure.html)
* [MATLAB](https://au.mathworks.com/products/matlab.html) (optinal if using mf_DCA)
* [Python3](https://docs.python-guide.org/starting/install3/linux/)
* [virtualenv](https://virtualenv.pypa.io/en/latest/installation/) or [Anaconda](https://anaconda.org/anaconda/virtualenv)


RNAcmap has been tested on Ubuntu 14.04, 16.04, and 18.04 operating systems.

USAGE
====

Installation:
----

To install RNAcmap and it's dependencies following commands can be used in terminal:

1. `git clone https://github.com/jaswindersingh2/RNAcmap.git`
2. `cd RNAcmap`

Either follow **virtualenv** column steps or **conda** column steps to create virtual environment and to install RNAcmap python dependencies given in table below:<br />

|    | virtualenv |conda  |
| :- | :--------: | :---: |
| 3. | `virtualenv -p python3.6 venv_rnacmap` | `conda create -n venv_rnacmap python=3.6` |
| 4. | `source ./venv_rnacmap/bin/activate` | `conda activate venv_rnacmap` | 
| 5. | `pip install -r requirements.txt && deactivate` | `conda install --file requirements.txt && conda deactivate` | 

If Infernal tool is already installed in the system, please add the path for binary files to the script 'scripts/set_environments.sh' . In case Infernal tool is not installed in the system, Run the following script, Infernal 1.1.3 will be installed under `3rd_party/infernal`

6. `./scripts/install_infernal.sh`

 In case of any problem and issue regarding Infernal download, please refer to [Infernal webpage](http://eddylab.org/infernal/) 




If BLASTN tool is already installed in the system, pplease add the path for binary files to the script 'scripts/set_environments.sh' In case, BLASTN tool is not installed in the system, run the following script, Infernal 1.1.3 will be installed under `3rd_party/blast`

In case of any problem and issue regarding BLASTN download, please refer to [BLASTN webpage](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) as following commands only tested on Ubuntu 18.04, 64 bit system.

7. `./scripts/install_blast.sh`

Either install **RNAfold** or **SPOT-RNA** predictor depending upon which Secondary Structure predictor you want to use. Installation of RNAfold will take 15-20 mins and 2-3 mins for SPOT-RNA. Both the secondary structure can be installed as well if you want to predict for both predictors. 

8. `./scripts/install_RNAfold.sh` or/and `./scripts/install_SPOT-RNA.sh`

please refer to more specific and detailed guide for [ViennaRNA](https://www.tbi.univie.ac.at/RNA/#download) and [SPOT-RNA](https://github.com/jaswindersingh2/SPOT-RNA).

If NCBI's nt database already available in your system, please add the path for binary files to the script 'scripts/set_environments.sh'.  Otherwise, download the reference database ([NCBI's nt database](ftp://ftp.ncbi.nlm.nih.gov/blast/db/)) for BLASTN and INFERNAL. The following command can be used for NCBI's nt database. Make sure there is enough space on the system, as NCBI's nt database will take up around 270 GB and it can take couple of hours to download. In case of any issue, please rerfer to [NCBI's database website](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download).

9. `wget -c "ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz" -O ./nt_database/nt.gz && gunzip ./nt_database/nt.gz`

This NCBI's database need to formated to use with BLASTN tool. To format the NCBI's database, the following command can be used. Please make sure system have enough space as formated database is of size around 120 GB in addition to appox. 270 GB from previous step and it can few hours for it.

10. `./ncbi-blast-2.10.0+/bin/makeblastdb -in ./nt_database/nt -dbtype nucl`

To install the DCA predictor, please run the following command:

11. `./scripts/install_GREMLIN.sh` or/and `./scripts/install_plmc.sh`


Finally, run the following script to confirm dependencies are met.

12. `./scripts/check_deps.sh` 

Expected output:

```
## checking infernal & Blastn
cmbuild                   OK
cmcalibrate               OK
cmsearch                  OK
esl-reformat              OK
blastn                    OK
## checking 3rd party tools
gremlin_cpp               OK
plmc                      OK
RNAfold                   OK
ct2dot                    OK
dot2ct                    OK
RemovePseudoknots         OK
SPOT-RNA.py               OK
parse_blastn_local.pl     OK
reformat.pl               OK
get_ss.py                 OK
```



How To Use
-----
To run the RNAcmap, the following command can be used. Use either RNAfold or SPOT-RNA for secondary structure predictor and one DCA method among GREMLIN, plmc, and mfDCA as input argument.
```
./run_rnacmap.sh inputs/sample_seq.fasta RNAfold|SPOT-RNA GREMLIN|plmc|mfDCA
```
The final output will be the "*.dca" file in the `inputs/outputs` folder consists of predicted Direct Coupling Analysis (DCA) by RNAcmap for a given input RNA sequence.




References
====
If you use RNAcmap for your research please cite the following papers:
----
Zhang, T., Singh, J., Litfin, T., Zhan, J., Paliwal, K., Zhou, Y., 2020. RNAcmap: A Fully Automatic Method for Predicting Contact Maps of RNAs by Evolutionary Coupling Analysis. (Under Review)

Other references:
----
[1] Nawrocki, E.P. and Eddy, S.R., 2013. Infernal 1.1: 100-fold faster RNA homology searches. Bioinformatics, 29(22), pp.2933-2935..

[2] Hofacker, I.L., 2003. Vienna RNA secondary structure server. Nucleic acids research, 31(13), pp.3429-3431. 

[3] H.M. Berman, J. Westbrook, Z. Feng, G. Gilliland, T.N. Bhat, H. Weissig, I.N. Shindyalov, P.E. Bourne. (2000) The Protein Data Bank Nucleic Acids Research, 28: 235-242.

[4] Singh, J., Hanson, J., Paliwal, K. and Zhou, Y., 2019. RNA secondary structure prediction using an ensemble of two-dimensional deep neural networks and transfer learning. Nature communications, 10(1), pp.1-13.

[5] Kamisetty, H., Ovchinnikov, S. and Baker, D., 2013. Assessing the utility of coevolution-based residue–residue contact predictions in a sequence-and structure-rich era. Proceedings of the National Academy of Sciences, 110(39), pp.15674-15679.

Licence
====
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/.


Contact
====
jaswinder.singh3@griffithuni.edu.au, tongchuan.zhang@griffithuni.edu.au, yaoqi.zhou@griffith.edu.au

