#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: "test1"

requirements:
  - class: ShellCommandRequirement

baseCommand: []

inputs:
  text:
    type: string
    inputBinding:
      position: 3

arguments: 
  - valueFrom: "mkdir -p outdir &&"
    shellQuote: false
    position: 1
  - valueFrom: "echo"
    position: 2
  - valueFrom: ">"
    shellQuote: false
    position: 4
  - valueFrom: "outfile.txt"
    position: 5

outputs:
  outfile:
    type: File
    outputBinding:
      glob: "outfile.txt"

