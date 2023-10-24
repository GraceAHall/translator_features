
#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
doc: Tool renames (cp) `source_file` to `target_filename`

requirements:
- class: DockerRequirement
  dockerPull: biowardrobe2/scidap:v0.0.3

baseCommand: ["cp"]

inputs:
  source_file:
    type: File
    inputBinding:
      position: 1
    doc: source file to rename
  
  target_filename:
    type: string
    inputBinding:
      position: 2
    doc: filename to rename to

outputs:
  target_file:
    type: File
    outputBinding:
      glob: $(inputs.target_filename)
