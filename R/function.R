calculate_selinescore <- function(
  x,  normalizeToBoston=FALSE, bostonDist=NA,  threshold=0,
  signature_genes = c("ETV7", "DUSP1", "WNT10A")
){
  library(GSVA)

  if(normalizeToBoston){
    # error handling
    if(is.na(bostonDist)){
      stop('Please supply a reference expression matrix!')
    }
    library(FSQN)
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