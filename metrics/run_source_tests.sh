
# 5 easy, 5 medium, 5 hard?


cd ../
export PARENTDIR=`pwd`

RUN_CWL=true
RUN_WDL=true
RUN_GALAXY=true

###########
### CWL ###
###########

CWL_TESTS_PASSED=0
CWL_TESTS_FAILED=0

if [ "$RUN_CWL" = true ]; then
    source $PARENTDIR/packages/cwl/venv/bin/activate
    export DATADIR=$PARENTDIR/data/cwl/real/tools
    
    echo ""
    echo "--- RUNNING CWL TESTS ---"
    
    ############
    ### EASY ###
    ############

    # rm -r $DATADIR/easy/bwa/outputs
    # mkdir -p $DATADIR/easy/bwa/outputs
    # {
    #     cwltool --outdir $DATADIR/easy/bwa/outputs $DATADIR/easy/bwa/BWA-Index.cwl $DATADIR/easy/bwa/tests/bwa-index-t1.yml &> /dev/null && echo "PASSED BWA-INDEX" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED BWA-INDEX" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }

    # {
    #     cwltool --outdir $DATADIR/easy/bwa/outputs $DATADIR/easy/bwa/BWA-Mem.cwl $DATADIR/easy/bwa/tests/bwa-mem-t1.yml &> /dev/null && echo "PASSED BWA-MEM" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED BWA-MEM" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }

    # rm -r $DATADIR/easy/cutadapt/outputs
    # mkdir -p $DATADIR/easy/cutadapt/outputs
    # {
    #     cwltool --outdir $DATADIR/easy/cutadapt/outputs $DATADIR/easy/cutadapt/cutadapt-paired.cwl $DATADIR/easy/cutadapt/tests/cutadapt-t1.yml &> /dev/null && echo "PASSED CUTADAPT" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED CUTADAPT" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
    
    # rm -r $DATADIR/easy/fastqc/outputs
    # mkdir -p $DATADIR/easy/fastqc/outputs
    # {
    #     cwltool --outdir $DATADIR/easy/fastqc/outputs $DATADIR/easy/fastqc/fastqc_2.cwl $DATADIR/easy/fastqc/tests/fastqc_2_t1.json &> /dev/null && echo "PASSED FASTQC" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED FASTQC" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
    
    # rm -r $DATADIR/easy/samtools/outputs
    # mkdir -p $DATADIR/easy/samtools/outputs
    # {
    #     cwltool --outdir $DATADIR/easy/samtools/outputs $DATADIR/easy/samtools/samtools_index.cwl $DATADIR/easy/samtools/tests/samtools_index_t1.yml &> /dev/null && echo "PASSED SAMTOOLS INDEX" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED SAMTOOLS INDEX" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }

    ##############
    ### MEDIUM ###
    ##############

    # rm -r $DATADIR/medium/picard/outputs
    # mkdir -p $DATADIR/medium/picard/outputs
    # {
    #     cwltool --outdir $DATADIR/medium/picard/outputs $DATADIR/medium/picard/picard_MarkDuplicates.cwl $DATADIR/medium/picard/tests/picard_MarkDuplicates_t1.yml &> /dev/null  && echo "PASSED PICARD MARKDUPLICATES" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED PICARD MARKDUPLICATES" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
    
    # {
    #     cwltool --outdir $DATADIR/medium/picard/outputs $DATADIR/medium/picard/picard_SortSam.cwl $DATADIR/medium/picard/tests/picard_SortSam_t1.yml &> /dev/null && echo "PASSED PICARD SORTSAM" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED PICARD SORTSAM" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
   
    # rm -r $DATADIR/medium/kraken2/outputs
    # mkdir -p $DATADIR/medium/kraken2/outputs
    # {
    #     cwltool --outdir $DATADIR/medium/kraken2/outputs $DATADIR/medium/kraken2/kraken2.cwl $DATADIR/medium/kraken2/tests/kraken2-t1.json &> /dev/null && echo "PASSED KRAKEN2" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED KRAKEN2" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
    
    # rm -r $DATADIR/medium/minimap2/outputs
    # mkdir -p $DATADIR/medium/minimap2/outputs
    # {
    #     cwltool --outdir $DATADIR/medium/minimap2/outputs $DATADIR/medium/minimap2/minimap2_paf.cwl $DATADIR/medium/minimap2/tests/minimap2_paf_t1.yml &> /dev/null && echo "PASSED MINIMAP2" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED MINIMAP2" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
    
    # rm -r $DATADIR/medium/nanoplot/outputs
    # mkdir -p $DATADIR/medium/nanoplot/outputs
    # {
    #     cwltool --outdir $DATADIR/medium/nanoplot/outputs $DATADIR/medium/nanoplot/nanoplot.cwl $DATADIR/medium/nanoplot/tests/nanoplot_t1.yml &> /dev/null && echo "PASSED NANOPLOT" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED NANOPLOT" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }

    ############
    ### HARD ###
    ############

    # rm -r $DATADIR/hard/bamtools/outputs
    # mkdir -p $DATADIR/hard/bamtools/outputs
    # {
    #     cwltool --outdir $DATADIR/hard/bamtools/outputs $DATADIR/hard/bamtools/bamtools_stats.cwl $DATADIR/hard/bamtools/tests/bamtools_stats_t1.json &> /dev/null && echo "PASSED BAMTOOLS STATS" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED BAMTOOLS STATS" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }
    
    # rm -r $DATADIR/hard/bowtie2/outputs
    # mkdir -p $DATADIR/hard/bowtie2/outputs
    # {
    #     cwltool --debug --outdir $DATADIR/hard/bowtie2/outputs $DATADIR/hard/bowtie2/bowtie2.cwl $DATADIR/hard/bowtie2/tests/bowtie2_t1.yml && echo "PASSED BOWTIE2" && CWL_TESTS_PASSED=$((CWL_TESTS_PASSED + 1))
    # } || {
    #     echo "FAILED BOWTIE2" && CWL_TESTS_FAILED=$((CWL_TESTS_FAILED + 1))
    # }

    # cellranger-aggr
    # picard_AddOrReplaceReadGroups
    # unicycler


fi


echo ""
echo "--- CWL RESULTS ---"
echo "Passed: $CWL_TESTS_PASSED"
echo "Failed: $CWL_TESTS_FAILED"
echo "Total:  `expr $CWL_TESTS_PASSED + $CWL_TESTS_FAILED`"