#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.2

inputs:
  inFile:
    type: File
    format:
        - "http://edamontology.org/format_2572" 

outputs: []

steps:
  arrays:
    in:
      inFile: inFile
    out: []
    run: formats_tool.cwl
