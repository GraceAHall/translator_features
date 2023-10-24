#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: "samtools index"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/biocontainers/samtools:1.17--hd87286a_2"

baseCommand: ["/usr/local/bin/samtools", "index"]
arguments: 
    - position: 1
      prefix: "-o"
      valueFrom: "$(inputs.bam.basename).bai"

inputs:
  - id: "#bam"
    type: File
    inputBinding:
      position: 2

outputs:
  - id: "#index"
    type: File
    outputBinding:
      glob: "$(inputs.bam.basename).bai"
