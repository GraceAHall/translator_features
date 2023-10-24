#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  inStr:
    type: string

outputs: []

steps:
  main:
    in:
      inStr: inStr
    out: []
    run: stdout_tool.cwl