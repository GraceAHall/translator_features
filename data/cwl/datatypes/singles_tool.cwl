
cwlVersion: v1.0
class: CommandLineTool
 
baseCommand: [ echo ]

inputs:
    # mandatory
    inFile:
        type: File
        inputBinding:
            position: 1
    inInt:
        type: int
        inputBinding:
            position: 2
    inFloat:
        type: float
        inputBinding:
            position: 3
    inStr:
        type: string
        inputBinding:
            position: 4
    inBool:
        type: boolean
        inputBinding:
            position: 5
            prefix: --flag1
    
    # optional
    inFileOpt:
      type: File?
      inputBinding:
        position: 1
    inIntOpt:
        type: int?
        inputBinding:
            position: 7
    inFloatOpt:
        type: float?
        inputBinding:
            position: 7
    inStrOpt:
        type: string?
        inputBinding:
            position: 9
    inBoolOpt:
        type: boolean?
        inputBinding:
            position: 10
            prefix: --flag2

outputs: []
    