#!/bin/bash

cwltool selineScore.cwl \
--bostonDist data/boston_reference_matrix.csv.gz \
--inputExprMatrix data/test_input_matrix.csv