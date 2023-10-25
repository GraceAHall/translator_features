
export PARENTDIR=`pwd`
source $PARENTDIR/packages/cwl/venv/bin/activate

RUN_BIOCWL=true
RUN_BASIC=false
RUN_SHELLCMD=false
RUN_DATATYPES=false

# TODO:
# requirements
# scatter
# subworkflows
# expressions
# expressiontools
# align_sort_markdup

#####################
### bio-cwl-tools ###
#####################

if [ "$RUN_BIOCWL" = true ]; then
    export DATADIR=$PARENTDIR/data/cwl/real/bio-cwl-tools
    export OUTDIR=$PARENTDIR/runs/cwl/real/bio-cwl-tools
    
    echo ""
    echo "--- BIO CWL TOOLS ---"
    {
        cwltool --outdir $OUTDIR $DATADIR/bwa/BWA-Index.cwl $DATADIR/bwa/tests/bwa-index-t1.yml && echo "PASSED BWA-INDEX"
    } || {
        echo "FAILED BWA-INDEX"
    }
fi

#############
### basic ###
#############

if [ "$RUN_BASIC" = true ]; then
    export DATADIR=$PARENTDIR/data/cwl/basic
    export OUTDIR=$PARENTDIR/runs/cwl/basic
    
    echo ""
    echo "--- BASIC ---"
    {
        cwltool --outdir $OUTDIR $DATADIR/io_wf.cwl $DATADIR/io_wf.yml &> /dev/null && echo "PASSED IO BASIC"
    } || {
        echo "FAILED IO BASIC"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/wf.cwl $DATADIR/wf.yml &> /dev/null && echo "PASSED BASIC"
    } || {
        echo "FAILED BASIC"
    }
fi

###############################
### ShellCommandRequirement ###
###############################

if [ "$RUN_SHELLCMD" = true ]; then
    export DATADIR=$PARENTDIR/data/cwl/shellcmd
    export OUTDIR=$PARENTDIR/runs/cwl/shellcmd
    echo ""
    echo "--- SHELL CMD ---"
    {
        cwltool --outdir $OUTDIR $DATADIR/test1.cwl $DATADIR/test1.yml && echo "PASSED SHELLCMD TEST1"
    } || {
        echo "FAILED SHELLCMD TEST1"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/test2.cwl $DATADIR/test1.yml && echo "PASSED SHELLCMD TEST2"
    } || {
        echo "FAILED SHELLCMD TEST2"
    }
fi


#################
### datatypes ###
#################

if [ "$RUN_DATATYPES" = true ]; then
    export DATADIR=$PARENTDIR/data/cwl/datatypes
    export OUTDIR=$PARENTDIR/runs/cwl/datatypes
    echo ""
    echo "--- DATATYPES ---"
    {
        cwltool --outdir $OUTDIR $DATADIR/basics_wf.cwl $DATADIR/basics_wf.yml &> /dev/null && echo "PASSED BASIC DATATYPES"
    } || {
        echo "FAILED BASIC DATATYPES"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/stdout_wf.cwl $DATADIR/stdout_wf.yml &> /dev/null && echo "PASSED STDOUT DATATYPES"
    } || {
        echo "FAILED STDOUT DATATYPES"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/arrays_wf.cwl $DATADIR/arrays_wf.yml &> /dev/null && echo "PASSED ARRAY DATATYPES"
    } || {
        echo "FAILED ARRAY DATATYPES"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/formats_wf.cwl $DATADIR/formats_wf.yml &> /dev/null && echo "PASSED FORMAT DATATYPES"
    } || {
        echo "FAILED FORMAT DATATYPES"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/multi_wf.cwl $DATADIR/multi_wf.yml &> /dev/null && echo "PASSED MULTI DATATYPES"
    } || {
        echo "FAILED MULTI DATATYPES"
    }
    {
        cwltool --outdir $OUTDIR $DATADIR/secondaries_wf.cwl $DATADIR/secondaries_wf.yml &> /dev/null && echo "PASSED SECONDARIES DATATYPES"
    } || {
        echo "FAILED SECONDARIES DATATYPES"
    }
fi




deactivate
