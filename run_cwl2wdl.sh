
# setup
export PARENTDIR=`pwd`
export DATADIR=$PARENTDIR/data/cwl
export OUTDIR=$PARENTDIR/translated/cwl2wdl
export CWL2WDL_HOME=$PARENTDIR/packages/cwl2wdl


#####################################################
### software install - uncomment if clean install ###
#####################################################

# cd $PARENTDIR
# cd packages
# git clone https://github.com/adamstruck/cwl2wdl
# cd cwl2wdl
# sudo apt-add-repository universe
# sudo apt update
# sudo apt install python2-minimal
# sudo pip install virtualenv
# virtualenv --python=/usr/bin/python2.7 venv
# source venv/bin/activate
# alias pip2=pip
# pip install .
# pip install cwl-utils
# pip install PyYAML

source $PARENTDIR/packages/cwl2wdl/venv/bin/activate

############
### REAL ###
############

mkdir $OUTDIR/real &> /dev/null
cd $OUTDIR/real
cwl2wdl $DATADIR/real/samtools_index_alt.cwl > samtools_index_alt.wdl


#################
### DATATYPES ###
#################

mkdir $OUTDIR/datatypes &> /dev/null
mkdir $OUTDIR/datatypes/singles &> /dev/null
cd $OUTDIR/datatypes/singles
cwl2wdl $DATADIR/datatypes/singles_wf.cwl > singles_wf.wdl

deactivate