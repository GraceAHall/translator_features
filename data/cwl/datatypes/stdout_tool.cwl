
cwlVersion: v1.0
class: CommandLineTool
 
baseCommand: [ echo ]

inputs:
    inStr:
        type: string
        inputBinding:
            position: 1

outputs:
    outFile:
        type: stdout
    