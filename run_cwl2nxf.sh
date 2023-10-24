
# setting paths
export PARENTDIR=`pwd`
export DATADIR=$PARENTDIR/data/cwl
export OUTDIR=$PARENTDIR/translated/cwl2nxf
export CWL2NXF_HOME=$PARENTDIR/packages/cwl2nxf

#####################################################
### software install - uncomment if clean install ###
#####################################################

# cd $PARENTDIR
# git clone https://github.com/nextflow-io/cwl2nxf.git 
# cd $CWL2NXF_HOME 
# ./gradlew uberjar

#############
### BASIC ###
#############

mkdir $OUTDIR/basic &> /dev/null
mkdir $OUTDIR/basic/io &> /dev/null
cd $DATADIR/basic
java -jar $CWL2NXF_HOME/build/libs/cwl2nxf-*.jar -o $OUTDIR/basic/io/io_wf.nf io_wf.cwl io_wf.yml

#################
### DATATYPES ###
#################

mkdir $OUTDIR/datatypes &> /dev/null
mkdir $OUTDIR/datatypes/singles &> /dev/null
cd $DATADIR/datatypes
java -jar $CWL2NXF_HOME/build/libs/cwl2nxf-*.jar -o $OUTDIR/datatypes/singles/singles_wf.nf singles_wf.cwl singles_wf.yml
