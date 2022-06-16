# Selinexor Sensitivity Signature

This repository contains the code needed to calculate selinexor sensitivity signature scores as described in "A Three gene signature predicts selinexor response in multiple myeloma" by Restrepo et al, published in [JCO Precision Oncology](https://ascopubs.org/doi/10.1200/PO.22.00147).

The signature is a GSVA combined z-score that is calculated after quantile-normalization to the original BOSTON discovery expression matrix. It is implemented in R. This repository provides a simple rscript, containing a function that can easily calculate signature scores on new data.

## Requirements
Requires the GSVA, preprocessCore, and FSQN packages in R 3.5 or higher.

## Installation & Usage

### RScript

The Rscript uses positional functions as follows:

```
Rscript R/run_selinescore.R [/path/to/expression_matrix.csv] [/path/to/reference/boston_expression_matrix.csv.gz]
```

An example command might look something like this:

```
Rscript R/run_selinescore.R data/example_input_matrix.csv data/boston_reference_matrix.csv.gz
```

## R function

If you need to fine-tune some parameters or want to include the score into a larger analysis, you can also source the function in directly to your rscripts.

```
source('R/function.R')
```

## Docker

A dockerfile is included if you would like to build the container from scratch.

## CWL

A cwltool file is included, which uses the docker container.


# Citation

If used, please cite:

Restrepo P, Bhalla S, Ghodke-Puranik Y, Aleman A, Leshchenko V, Melnekoff DT, Agte S, Jiang J, Madduri D, Richter J, Richard S, Chari A, Cho HJ, Jagannath S, Walker CJ, Landesman Y, Laganà A, Parekh S. A Three-Gene Signature Predicts Response to Selinexor in Multiple Myeloma. JCO Precis Oncol. 2022 Jun;6:e2200147. doi: 10.1200/PO.22.00147. PMID: 35704796.
