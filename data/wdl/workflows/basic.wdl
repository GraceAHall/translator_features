version 1.0

import "../tools/samtools_flagstat.wdl" as tools

workflow main {
    input {
        File infile
    }

    call tools.Samtools_Flagstat {
        input:
            bam = infile
    }

    output {
        File outfile = Samtools_Flagstat.flagstats
    }
}