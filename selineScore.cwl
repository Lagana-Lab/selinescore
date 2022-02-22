#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "sinaiiidgst/selinescore:c95d5b7"
  InlineJavascriptRequirement: {}

inputs:
  inputExprMatrix:
    type: File
    inputBinding:
      position: 1
  
  bostonDist:
    type: File
    inputBinding:
      position: 2

baseCommand: [Rscript, /R/run_selinescore.R]

outputs:
  selineScoreResults:
    type: File
    outputBinding:
      glob: "*_latest.tsv"