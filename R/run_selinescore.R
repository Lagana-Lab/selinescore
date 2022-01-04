#!/usr/bin/env Rscript

library("GSVA")
library("preprocessCore")

args <- commandArgs(trailingOnly=TRUE)

exprMat <- args[1] # tab separated, normalized & batch corrected expression matrix. HUGO gene symbols as rows and samples as columns. Only works for human data.
bostonDist <- args[2] # BOSTON study reference distribution for quantile normalization
outDir <- args[3] # output directory

if (length(args)!=3) {
  stop("Arguments are incorrectly specified. Usage: ", call.=FALSE)
} 

source('function.R')

countsTableNorm <- read.delim(exprMat)
boston <- readRDS(bostonDist)

result <- calculate_selinescore(x=countsTableNorm, normalizeToBoston=TRUE, bostonDist=boston)

outDir <- sub("/$", "", outDir)
outFileName <- paste0(outDir, '/selinescores_latest.tsv') # puns 4 lyfe

write.table(result, outFileName, sep='\t', quote=FALSE)