
export PARENTDIR=`pwd`
export DATADIR=$PARENTDIR/data/wdl
export OUTDIR=$PARENTDIR/translated/wdl2cwl
export WDL2CWL_HOME=$PARENTDIR/packages/wdl-cwl-translator

######################################################
### software installs - uncomment if clean install ###
######################################################

# # wdl2cwl
# cd $PARENTDIR
# git clone https://github.com/common-workflow-lab/wdl-cwl-translator/
# cd $WDL2CWL_HOME
# python -m venv venv
# source venv/bin/activate
# pip install -U pip setuptools wheel
# pip install -e .
# deactivate

cd $WDL2CWL_HOME
source venv/bin/activate

#############
### BASIC ###
#############

mkdir $OUTDIR/basic &> /dev/null
wdl2cwl $DATADIR/basic/io_tool.wdl --output $OUTDIR/basic/io_tool.cwl
wdl2cwl $DATADIR/basic/rename_tool.wdl --output $OUTDIR/basic/rename_tool.cwl

#################
### DATATYPES ###
#################

mkdir $OUTDIR/datatypes &> /dev/null
wdl2cwl $DATADIR/datatypes/singles_tool.wdl --output $OUTDIR/datatypes/singles_tool.cwl

deactivate
