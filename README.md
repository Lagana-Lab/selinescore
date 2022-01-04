# Selinexor Sensitivity Signature

This repository contains the code needed to calculate selinexor sensitivity signature scores as described in "A Three gene signature predicts selinexor response in multiple myeloma" by Restrepo et al.

The signature is a GSVA combined z-score that is calculated after quantile-normalization to the original BOSTON discovery expression matrix. It is implemented in R. This repository provides a simple rscript, containing a function that can easily calculate signature scores on new data.

## Requirements
Requires the GSVA and preprocessCore packages in R 3.5 or higher.

## Installation & Usage

### RScript

The Rscript uses positional functions as follows:

```
Rscript R/run_selinescore.R [/path/to/expression_matrix.tsv] [/path/to/reference/boston.rds] [/path/to/output/directory]
```

An example command might look something like this:

```
Rscript R/run_selinescore.R expression_matrix.tsv data/bostonStudyExpressionDistribution.rds data/
```

## R function

If you need to fine-tune some parameters or want to include the score into a larger analysis, you can also source the function in directly to your rscripts.

```
source('R/function.R')
```

## Docker
A dockerfile is included if you would like to build the container from scratch. Or, you can use our container from DockerHub:

```
docker pull sinaiiidgst/selinescore:v1
```

## CWL

CWL file provided, uses docker.