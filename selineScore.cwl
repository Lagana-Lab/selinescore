#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "sinaiiidgst/selinescore:51cc9de"
  InlineJavascriptRequirement: {}

inputs:
  rDataFile:
    type: File
    inputBinding:
      position: 1
  
  bostonDist:
    type: File
    inputBinding:
      position: 2

  outputDir:
    type: string
    default: $(runtime.outdir)
    inputBinding:
      valueFrom: $(runtime.outdir)
      position: 3

baseCommand: [Rscript, /bin/calculateSelineScores.R]

outputs:
  selineScoreResults:
    type: File
    outputBinding:
      glob: "selinescores_latest.tsv"