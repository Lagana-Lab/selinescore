#!/bin/bash

docker build -t sinaiiidgst/selinescore:test . 
docker run -v ${PWD}/data/:/data sinaiiidgst/selinescore:test \
Rscript /R/run_selinescore.R \
"/data/example_input_matrix.csv" \
"/data/boston_reference_matrix.csv.gz" \
"/data/"
