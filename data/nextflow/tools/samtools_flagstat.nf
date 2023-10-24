nextflow.enable.dsl=2

process SAMTOOLS_FLAGSTAT {
    
    memory '400 MB'
    container "quay.io/biocontainers/samtools:1.11--h6270b1f_0"

    input:
    path bam

    output:
    path "out.txt", emit: flagstats

    script:
    """
    /usr/local/bin/samtools flagstat \
    ${bam} \
    > out.txt
    """

}
