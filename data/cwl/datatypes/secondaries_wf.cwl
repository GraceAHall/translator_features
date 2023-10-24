#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  inBamBai:
    type: File
    secondaryFiles: .bai

outputs: []

steps:
  secondaries:
    in:
      inBamBai: inBamBai
    out: []
    run: secondaries_tool.cwl