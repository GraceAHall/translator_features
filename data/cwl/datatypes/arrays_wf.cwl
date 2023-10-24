#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.2

requirements:
  MultipleInputFeatureRequirement: {}

inputs:
  inFileArr:
    type: File[]
  inIntArr:
    type: int[]
  inStrArr:
    type: string[]
  inFileArrOpt:
    type: File[]?
  inIntArrOpt:
    type: int[]?
  inStrArrOpt:
    type: string[]?

outputs: []

steps:
  arrays:
    in:
      inFileArr: inFileArr
      inIntArr: inIntArr
      inStrArr: inStrArr
      inFileArrOpt: inFileArrOpt
      inIntArrOpt: inIntArrOpt
      inStrArrOpt: inStrArrOpt
    out: []
    run: arrays_tool.cwl
  