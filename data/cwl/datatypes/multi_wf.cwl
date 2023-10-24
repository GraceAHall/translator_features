#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  inStringInt:
    type: 
      - string
      - int
  inBamFastq:
    type: File
    format: 
        - "http://edamontology.org/format_2330"  # txt
        - "http://edamontology.org/format_2572"  # bam
  inStringIntOpt:
    type: 
      - "null"
      - string
      - int
  inBamFastqOpt:
    type: 
      - "null"
      - File

outputs: []

steps:
  basics:
    in:
      inStringInt: inStringInt
      inBamFastq: inBamFastq
      inStringIntOpt: inStringIntOpt
      inBamFastqOpt: inBamFastqOpt
    out: []
    run: multi_tool.cwl