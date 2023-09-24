### This file contains functions that can be used in FunctionsKmeans.R

##For calculating the clusters:
diff_clusters <- function(Data,M){
  diff <- apply(as.matrix(Data),c(1:2),function(Data) {sqrt((Data - M)^2)})
  clusters <- apply(diff,2,function(z) which(z == min(z)))
  #return(diff)
  return(clusters)
}

##This is my first attempt at building a For loop for what the above did.
#Y <- c(rep(0,length(X)))

for (i in 1:length(X)){ 
  diff <- rep(0,K)
  diff <- (sqrt((X[i] - c(M))^2))
  #return(diff)
  Y[i] <- which(diff == min(diff))
  #assign("Y[i]",which(diff == min(diff)),envir = .GlobalEnv)
}

Y

##Note that while it does work, it will not retain the results in Y. The Y in the 
##Global environment will be kept. 