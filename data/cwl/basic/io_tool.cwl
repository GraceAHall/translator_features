
cwlVersion: v1.0
class: CommandLineTool
 
baseCommand: [ echo ]

requirements:
    InlineJavascriptRequirement: {}
    InitialWorkDirRequirement:
        listing: 
            - $(inputs.inFile)
            - $(inputs.inFileOpt)
            - $(inputs.inFileArr)
            - $(inputs.inSecondary) 

inputs:
    inInt:
        type: int
        inputBinding:
            position: 1
    inStr:
        type: string
        inputBinding:
            position: 2
    inBool:
        type: boolean
        inputBinding:
            position: 3
            prefix: --flag1
    inFile:
        type: File
        doc: "input file"
        inputBinding:
            position: 4
            prefix: --in-file=
            separate: false
    inFileOpt:
        type: File?
        inputBinding:
            position: 5
    inFileArr:
        type: File[]
        inputBinding:
            position: 6
            prefix: --in-file-arr
            itemSeparator: ","
    inSecondary:
        type: File
        secondaryFiles: [.bai]
        inputBinding:
            position: 7

stdout: "stdout.txt"

outputs: 
    outFile:
        type: File
        outputBinding:
            glob: $(inputs.inFile.basename)
    outFileOpt:
        type: File?
        outputBinding:
            glob: $(inputs.inFileOpt.basename)
    outFileArr:
        type: File[]
        outputBinding:
            glob: "*.txt"
    outSecondary:
        type: File
        secondaryFiles: .bai
        outputBinding:
            glob: $(inputs.inSecondary.basename)
    outStdout:
        type: stdout
    