
cwlVersion: v1.2
class: CommandLineTool
 
baseCommand: [ echo ]

inputs:
    inFile:
        type: File
        format:
            - "http://edamontology.org/format_2572"  # BAM
        inputBinding:
            position: 1

outputs: []