#!/usr/bin/env Rscript

library("GSVA")
library("preprocessCore")
library("FSQN")

calculate_selinescore <- function(
  x,  normalizeToBoston=FALSE, bostonDist=NA,  threshold=0,
  signature_genes = c("ENSG00000010030", "ENSG00000120129", "ENSG00000135925")
){

  if(normalizeToBoston){
    # error handling
    if(is.na(bostonDist)){
      stop('Please supply a reference expression matrix!')
    }

    bostonDist <- as.data.frame(bostonDist)
    x <- as.data.frame(x)
    genes <- intersect(rownames(bostonDist), rownames(x))
    x2 <- t(as.matrix(x[genes,]))
    y2 <- t(as.matrix(bostonDist[genes,]))
    
    
    z <- t(as.matrix(quantileNormalizeByFeature(x2, y2)))
    class(z) <- 'matrix'
  } else{
    z <- x
  }
  
  sig_list <- list(score=signature_genes)
  
  scoredf <- data.frame(t(GSVA::gsva(expr=z, gset.idx.list=sig_list, method="gsva", verbose=FALSE)))
  scoredf$score_category <- ifelse(scoredf$score > threshold, 'high', 'low')
  scoredf$sample_id <- rownames(scoredf)
  
  return(as.data.frame(scoredf))
}


args <- commandArgs(trailingOnly=TRUE)

exprMat <- args[1] # tab separated, normalized & batch corrected expression matrix. HUGO gene symbols as rows and samples as columns. Only works for human data.
bostonFile <- args[2] # BOSTON study reference distribution for quantile normalization

if (length(args)!=3) {
  stop("Arguments are incorrectly specified. Usage: ", call.=FALSE)
} 

load(rDataFile)
countsTableNorm <- read.csv(exprMat, row.names=1, header = TRUE)
boston <- read.csv(gzfile(bostonFile), row.names=1, header = TRUE)

result <- calculate_selinescore(x=countsTableNorm, normalizeToBoston=TRUE, bostonDist=boston)

write.table(result, 'selinescores_latest.tsv', sep='\t', quote=FALSE)