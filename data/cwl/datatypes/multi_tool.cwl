
cwlVersion: v1.0
class: CommandLineTool
 
baseCommand: [ echo ]

inputs:
    # mandatory
    inStringInt:
        type: 
            - string
            - int
        inputBinding:
            position: 1
    inBamFastq:
        type: File
        format: 
            - "http://edamontology.org/format_2330"  # txt
            - "http://edamontology.org/format_2572"  # bam
        inputBinding:
            position: 2
    
    # optional
    inStringIntOpt:
        type: 
            - "null"
            - string
            - int
        inputBinding:
            position: 3
    inBamFastqOpt:
        type: 
            - "null"
            - File
        format: 
            - "http://edamontology.org/format_2330"  # txt
            - "http://edamontology.org/format_2572"  # bam
        inputBinding:
            position: 4

outputs: []
    