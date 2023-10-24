
cwlVersion: v1.0
class: CommandLineTool

requirements:
    InlineJavascriptRequirement: {}
    InitialWorkDirRequirement:
        listing: [ $(inputs.inBamBai) ]

baseCommand: [ echo ]

inputs:
    inBamBai:
        type: File
        secondaryFiles: .bai
        inputBinding:
            position: 1
    
outputs: []

