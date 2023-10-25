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

arguments: 
  - valueFrom: "mkdir -p outdir &&"
    shellQuote: false
  - valueFrom: "echo"
  - valueFrom: "$(inputs.text)"
  - valueFrom: "|"
    shellQuote: false
  - valueFrom: "wc -l" 
    shellQuote: false
  - valueFrom: ">"
    shellQuote: false
  - valueFrom: "outdir/outfile.txt"

outputs:
  outfile:
    type: File
    outputBinding:
      glob: "outdir/outfile.txt"

