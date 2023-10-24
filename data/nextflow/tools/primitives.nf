nextflow.enable.dsl=2

process PRIMITIVES {
    
    input:
    path inFile
    path inFileOpt

    script:
    def inFileOpt = inFileOpt.simpleName != 'null' ? inFileOpt : ""
    """
    echo \
    ${inFile} \
    ${inFileOpt} \
    """

}


