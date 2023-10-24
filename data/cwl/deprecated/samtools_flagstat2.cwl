#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: "samtools flagstat"

requirements:
    - class: ResourceRequirement
      ramMin: 400
    - class: DockerRequirement
      dockerPull: "quay.io/biocontainers/samtools:1.11--h6270b1f_0"

baseCommand: ["/usr/local/bin/samtools", "flagstat"]
arguments: 
    - position: 2
      valueFrom: "> out.txt"

inputs:
    bam:
        type: File
        doc: "The BAM file for which statistics should be retrieved."
        inputBinding:
            position: 1

outputs:
    flagstats:
      type: File
      doc: "The number of alignments for each FLAG type."
      outputBinding:
        glob: "out.txt"

