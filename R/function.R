calculate_selinescore <- function(x, normalizeToBoston=FALSE, bostonDist=NULL, signature_genes = c('WNT10A', 'DUSP1', "ETV7"), threshold = 0){
  library(GSVA)
  
  if(normalizeToBoston){
    library(preprocessCore)
    y <- preprocessCore::normalize.quantiles.use.target(x, target = bostonDist)
    rownames(y) <- rownames(x)
    colnames(y) <- colnames(x)
    
  } else{
    y <- x
  }
  
  sig_list <- list(score=signature_genes)
  
  scoredf <- data.frame(t(GSVA::gsva(expr=y, gset.idx.list=sig_list, method="gsva", verbose=FALSE)))
  scoredf$score_category <- ifelse(scoredf$score > threshold, 'high', 'low')
  scoredf$sample_id <- rownames(scoredf)
  
  return(as.data.frame(scoredf))
}
