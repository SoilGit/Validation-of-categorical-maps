```Rscript
calcErrorMat <- function(pred , obs , allCats){
  nCats = length(allCats)
  
  errorMat = matrix(NA , nCats , nCats)
  for (iobs in 1:nCats){
    for (ipred in 1:nCats){
      errorMat[ipred , iobs] <- length(which(pred == allCats[ipred] & obs == allCats[iobs]))
    }
  }
  return (errorMat)
}

calcWeightedKappa <- function(errorMat , weights.method = 'None'){
  
  ### weights.method = c('None' , 'Ag' , 'FC')  
  ### None = ordinary Kappa
  ### Ag = suggested weights in Agresti: Categorical Data Analysis, Section 10.5.5
  ### FC = Fleiss and Cohen (1973), also in Section 10.5.5 of Agresti book
  
  n = sum(errorMat)
  nCats <- nrow(errorMat)
  if(weights.method == 'None'){
    weights <- diag(nCats)
  }else if(weights.method == 'FC'){
    weights <- 1 - ((matrix(seq(nCats) , nCats , nCats) - matrix(seq(nCats) , nCats , nCats , byrow = TRUE)) ^ 2) / ((nCats - 1) ^ 2)
    diag(weights) <- 1
  }else if(weights.method == 'Ag'){
    weights <- 1 - abs(matrix(seq(nCats) , nCats , nCats) - matrix(seq(nCats) , nCats , nCats , byrow = TRUE)) / (nCats - 1)
    diag(weights) <- 1
  }else{
    stop('Enter appropriate method for assigning weights!')
  }
  
  pErrorMat <- errorMat / n
  
  matRowSums <- matrix(rowSums(pErrorMat) , nCats , nCats)
  matColSums <- matrix(colSums(pErrorMat) , nCats , nCats , byrow = TRUE)
  
  sum1 <- sum(weights * pErrorMat)
  sum2 <- sum(weights * matRowSums * matColSums)
  
  denom <- 1 - sum2
  
  if (denom != 0){
    kappa = (sum1 - sum2) / denom
  }else{
    kappa = NA
  }    
  return(kappa)
}
```
