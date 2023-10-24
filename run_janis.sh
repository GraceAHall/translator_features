

# setting paths
export PARENTDIR=`pwd`
export DATADIR=$PARENTDIR/data
export OUTDIR=$PARENTDIR/translated/janis
export JANIS_HOME=$PARENTDIR/packages/janis

RUN_INSTALL=false
RUN_FROM_CWL=false
RUN_FROM_WDL=false
RUN_FROM_GX=true

########################
### software install ###
########################

if [ "$RUN_INSTALL" = true ]; then
    echo "Running JANIS install"
    cd $PARENTDIR
    mkdir $JANIS_HOME 
    cd $JANIS_HOME
    python -m venv venv 
    source venv/bin/activate
    pip install -q -U pip setuptools wheel
    pip install -q -e ../../../janis-core
    deactivate
fi

cd $JANIS_HOME
source venv/bin/activate

################
### FROM CWL ###
################

if [ "$RUN_FROM_CWL" = true ]; then
    echo "Running CWL translations"
    
    ### real ####
    mkdir $OUTDIR/real &> /dev/null
    mkdir $OUTDIR/real/fromcwl &> /dev/null
    janis-translate --from cwl --to nextflow -o $OUTDIR/real/fromcwl $DATADIR/cwl/real/samtools_index.cwl
    janis-translate --from cwl --to wdl -o $OUTDIR/real/fromcwl $DATADIR/cwl/real/samtools_index.cwl

    # ### basic ####
    # mkdir $OUTDIR/basic &> /dev/null
    # mkdir $OUTDIR/basic/io &> /dev/null
    # janis-translate --from cwl --to nextflow -o $OUTDIR/basic/io/fromcwl $DATADIR/cwl/basic/io_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/basic/io/fromcwl $DATADIR/cwl/basic/io_tool.cwl

    # ### datatypes ###
    # mkdir $OUTDIR/datatypes &> /dev/null
    # mkdir $OUTDIR/datatypes/singles &> /dev/null
    # mkdir $OUTDIR/datatypes/stdout &> /dev/null
    # mkdir $OUTDIR/datatypes/arrays &> /dev/null
    # mkdir $OUTDIR/datatypes/formats &> /dev/null
    # mkdir $OUTDIR/datatypes/multi &> /dev/null
    # mkdir $OUTDIR/datatypes/secondaries &> /dev/null
    # # primitives
    # janis-translate --from cwl --to nextflow -o $OUTDIR/datatypes/singles/fromcwl $DATADIR/cwl/datatypes/singles_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/datatypes/singles/fromcwl $DATADIR/cwl/datatypes/singles_tool.cwl
    # # stdout
    # janis-translate --from cwl --to nextflow -o $OUTDIR/datatypes/stdout/fromcwl $DATADIR/cwl/datatypes/stdout_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/datatypes/stdout/fromcwl $DATADIR/cwl/datatypes/stdout_tool.cwl
    # # arrays
    # janis-translate --from cwl --to nextflow -o $OUTDIR/datatypes/arrays/fromcwl $DATADIR/cwl/datatypes/arrays_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/datatypes/arrays/fromcwl $DATADIR/cwl/datatypes/arrays_tool.cwl
    # # format
    # janis-translate --from cwl --to nextflow -o $OUTDIR/datatypes/formats/fromcwl $DATADIR/cwl/datatypes/formats_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/datatypes/formats/fromcwl $DATADIR/cwl/datatypes/formats_tool.cwl
    # # multi
    # janis-translate --from cwl --to nextflow -o $OUTDIR/datatypes/multi/fromcwl $DATADIR/cwl/datatypes/multi_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/datatypes/multi/fromcwl $DATADIR/cwl/datatypes/multi_tool.cwl
    # # secondaries
    # janis-translate --from cwl --to nextflow -o $OUTDIR/datatypes/secondaries/fromcwl $DATADIR/cwl/datatypes/secondaries_tool.cwl
    # janis-translate --from cwl --to wdl -o $OUTDIR/datatypes/secondaries/fromcwl $DATADIR/cwl/datatypes/secondaries_tool.cwl
fi

################
### FROM WDL ###
################

if [ "$RUN_FROM_WDL" = true ]; then
    echo "Running WDL translations"

    ### basic ####
    mkdir $OUTDIR/basic &> /dev/null
    mkdir $OUTDIR/basic/io &> /dev/null
    mkdir $OUTDIR/basic/rename &> /dev/null

    # io tool
    janis-translate --from wdl --to nextflow -o $OUTDIR/basic/io/fromwdl $DATADIR/wdl/basic/io_tool.wdl
    janis-translate --from wdl --to cwl -o $OUTDIR/basic/io/fromwdl $DATADIR/wdl/basic/io_tool.wdl
    
    # rename tool
    janis-translate --from wdl --to nextflow -o $OUTDIR/basic/rename/fromwdl $DATADIR/wdl/basic/rename_tool.wdl
    janis-translate --from wdl --to cwl -o $OUTDIR/basic/rename/fromwdl $DATADIR/wdl/basic/rename_tool.wdl

    ### datatypes ###
    mkdir $OUTDIR/datatypes &> /dev/null
    mkdir $OUTDIR/datatypes/singles &> /dev/null
    mkdir $OUTDIR/datatypes/stdout &> /dev/null
    mkdir $OUTDIR/datatypes/arrays &> /dev/null
    mkdir $OUTDIR/datatypes/formats &> /dev/null
    mkdir $OUTDIR/datatypes/multi &> /dev/null
    mkdir $OUTDIR/datatypes/secondaries &> /dev/null

    # singles
    janis-translate --from wdl --to nextflow -o $OUTDIR/datatypes/singles/fromwdl $DATADIR/wdl/datatypes/singles_tool.wdl
    janis-translate --from wdl --to cwl -o $OUTDIR/datatypes/singles/fromwdl $DATADIR/wdl/datatypes/singles_tool.wdl

    # # stdout
    # janis-translate --from wdl --to nextflow -o $OUTDIR/datatypes/stdout/fromwdl $DATADIR/wdl/datatypes/stdout_tool.wdl
    # janis-translate --from wdl --to cwl -o $OUTDIR/datatypes/stdout/fromwdl $DATADIR/wdl/datatypes/stdout_tool.wdl

    # # arrays
    # janis-translate --from wdl --to nextflow -o $OUTDIR/datatypes/arrays/fromwdl $DATADIR/wdl/datatypes/arrays_tool.wdl
    # janis-translate --from wdl --to cwl -o $OUTDIR/datatypes/arrays/fromwdl $DATADIR/wdl/datatypes/arrays_tool.wdl

    # # format
    # janis-translate --from wdl --to nextflow -o $OUTDIR/datatypes/formats/fromwdl $DATADIR/wdl/datatypes/formats_tool.wdl
    # janis-translate --from wdl --to cwl -o $OUTDIR/datatypes/formats/fromwdl $DATADIR/wdl/datatypes/formats_tool.wdl

    # # multi
    # janis-translate --from wdl --to nextflow -o $OUTDIR/datatypes/multi/fromwdl $DATADIR/wdl/datatypes/multi_tool.wdl
    # janis-translate --from wdl --to cwl -o $OUTDIR/datatypes/multi/fromwdl $DATADIR/wdl/datatypes/multi_tool.wdl

    # # secondaries
    # janis-translate --from wdl --to nextflow -o $OUTDIR/datatypes/secondaries/fromwdl $DATADIR/wdl/datatypes/secondaries_tool.wdl
    # janis-translate --from wdl --to cwl -o $OUTDIR/datatypes/secondaries/fromwdl $DATADIR/wdl/datatypes/secondaries_tool.wdl
fi


###############
### FROM GX ###
###############


if [ "$RUN_FROM_GX" = true ]; then
    echo "Running GALAXY translations"

    ### real ###
    # mkdir $OUTDIR/real &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy/tools &> /dev/null
    # janis-translate --from galaxy --to cwl -o $OUTDIR/real/fromgalaxy/tools $DATADIR/galaxy/real/samtools_flagstat.xml
    # janis-translate --from galaxy --to nextflow -o $OUTDIR/real/fromgalaxy/tools $DATADIR/galaxy/real/samtools_flagstat.xml
    # janis-translate --from galaxy --to wdl -o $OUTDIR/real/fromgalaxy/tools $DATADIR/galaxy/real/samtools_flagstat.xml
    
    mkdir $OUTDIR/real/fromgalaxy/workflows &> /dev/null
    mkdir $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly &> /dev/null
    mkdir $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly/cwl &> /dev/null
    mkdir $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly/nextflow &> /dev/null
    mkdir $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly/wdl &> /dev/null
    janis-translate --from galaxy --to cwl -o $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly/cwl $DATADIR/galaxy/real/unicycler_assembly.ga
    janis-translate --from galaxy --to nextflow -o $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly/nextflow $DATADIR/galaxy/real/unicycler_assembly.ga
    janis-translate --from galaxy --to wdl -o $OUTDIR/real/fromgalaxy/workflows/unicycler_assembly/wdl $DATADIR/galaxy/real/unicycler_assembly.ga
    
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly/cwl &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly/nextflow &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly/wdl &> /dev/null
    # janis-translate --from galaxy --to cwl --mode regular -o $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly/cwl $DATADIR/galaxy/real/unicycler_assembly.ga
    # janis-translate --from galaxy --to nextflow --mode regular -o $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly/nextflow $DATADIR/galaxy/real/unicycler_assembly.ga
    # janis-translate --from galaxy --to wdl --mode regular -o $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly/wdl $DATADIR/galaxy/real/unicycler_assembly.ga
    
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal/cwl &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal/nextflow &> /dev/null
    # mkdir $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal/wdl &> /dev/null
    # janis-translate --from galaxy --to cwl --mode regular -o $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal/cwl $DATADIR/galaxy/real/unicycler_assembly_minimal.ga
    # janis-translate --from galaxy --to nextflow --mode regular -o $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal/nextflow $DATADIR/galaxy/real/unicycler_assembly_minimal.ga
    # janis-translate --from galaxy --to wdl --mode regular -o $OUTDIR/real/fromgalaxy_regular/workflows/unicycler_assembly_minimal/wdl $DATADIR/galaxy/real/unicycler_assembly_minimal.ga
fi


deactivate







