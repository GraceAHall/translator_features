
#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  infile:
    type: File
  
  outname:
    type: string

outputs:
  index:
    type: File
    outputSource: rename/target_file

steps:
  samtools_index:
    in:
      bam: infile
    out: [index]
    run: samtools_index.cwl
  
  rename:
    in:
      source_file: samtools_index/index
      target_filename: outname
    out: [target_file]
    run: rename.cwl


  