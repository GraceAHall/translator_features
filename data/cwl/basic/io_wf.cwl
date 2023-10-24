#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  inInt:
    type: int
  inStr:
    type: string
  inBool:
    type: boolean
  inFile:
    type: File
  inFileOpt:
    type: File?
  inFileArr:
    type: File[]
  inSecondary:
    type: File
    secondaryFiles: [.bai]

outputs:
  outStdout:
    type: File
    outputSource: io/outStdout
  outFile:
    type: File
    outputSource: io/outFile
  outFileOpt:
    type: File?
    outputSource: io/outFileOpt
  outFileArr:
    type: File[]
    outputSource: io/outFileArr
  outSecondary:
    type: File
    secondaryFiles: .bai
    outputSource: io/outSecondary

steps:
  io:
    in:
      inInt: inInt
      inStr: inStr
      inBool: inBool
      inFile: inFile
      inFileOpt: inFileOpt
      inFileArr: inFileArr
      inSecondary: inSecondary
    out: [outFile, outFileOpt, outFileArr, outSecondary, outStdout] 
    run: io_tool.cwl
