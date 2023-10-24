#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  inFile:
    type: File
  inInt:
    type: int
  inStr:
    type: string
  inBool:
    type: boolean
  inFileOpt:
    type: File?
  inIntOpt:
    type: int?
  inStrOpt:
    type: string?
  inBoolOpt:
    type: boolean?

outputs: []

steps:
  singles:
    in:
      inFile: inFile
      inInt: inInt
      inStr: inStr
      inBool: inBool
      inFileOpt: inFileOpt
      inIntOpt: inIntOpt
      inStrOpt: inStrOpt
      inBoolOpt: inBoolOpt
    out: []
    run: singles_tool.cwl