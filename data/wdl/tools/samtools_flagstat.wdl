
task Samtools_Flagstat {
    input {
        File bam
        String memory = "400MiB" 
        String dockerImage = "quay.io/biocontainers/samtools:1.11--h6270b1f_0"
    }

    command <<<
        set -e
        samtools flagstat ~{bam} > out.txt
    >>>

    output {
        File flagstats = "out.txt"
    }

    runtime {
        memory: memory
        docker: dockerImage
    }

    parameter_meta {
        # inputs
        bam: {
            description: "The BAM file for which statistics should be retrieved." 
        }
        # outputs
        flagstats: {
            description: "The number of alignments for each FLAG type."
        }
    }
}