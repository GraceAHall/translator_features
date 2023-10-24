cwlVersion: v1.0
class: Workflow
    
inputs:
  intext: string

outputs:
  outfile:
    type: File
    outputSource: echo/out

steps:
  echo:
    in:
      text: intext
    out: [out]
    run: echo.cwl
      