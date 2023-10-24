
export PARENTDIR=`pwd`
export DATADIR=$PARENTDIR/data/wdl
export OUTDIR=$PARENTDIR/runs/wdl
export MINIWDL_DIR=$PARENTDIR/packages/wdl

######################################################
### software installs - uncomment if clean install ###
######################################################

# mkdir packages &> /dev/null
# mkdir $MINIWDL_DIR &> /dev/null
# cd $MINIWDL_DIR
# python -m venv venv
# source venv/bin/activate
# pip install miniwdl
# deactivate

source $MINIWDL_DIR/venv/bin/activate

#############
### BASIC ###
#############

# mkdir $OUTDIR/basic &> /dev/null

# cd $DATADIR/basic
# mkdir $OUTDIR/basic/io &> /dev/null
# miniwdl run io_wf.wdl --input io_wf.json -d $OUTDIR/basic/io

#################
### DATATYPES ###
#################

mkdir $OUTDIR/datatypes &> /dev/null

cd $DATADIR/datatypes
mkdir $OUTDIR/datatypes/singles &> /dev/null
miniwdl run singles_wf.wdl --input singles_wf.json -d $OUTDIR/datatypes/singles

deactivate