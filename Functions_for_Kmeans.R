### This file contains functions that can be used in FunctionsKmeans.R

## For calculating the clusters on non-matrix data
diff_clusters <- function(Data,M){
  diff <- apply(as.matrix(Data),c(1:2),function(Data) {sqrt((Data - M)^2)})
  clusters <- apply(diff,2,function(z) which(z == min(z)))
  #return(diff)
  return(clusters)
}


## Maybe try a double apply where you go through each row and then column?
find_diff <- function(X,M){
  diff <- matrix(rep(0,(nrow(X)*nrow(M))),nrow=nrow(X))
  
  for(i in 1:nrow(X)){
    for(j in 1:nrow(M)){
      #diff <- sapply(X,function (X) {norm((X[i,] - M[j,]),type="2")})
      diff[i,j] <- norm((X[i,] - M[j,]),type="2") 
    }
  }
}

diff






######Functions below this line are not being used in my MyKmeans function
###### They are simply old functions that I had at some point. 
 
# These are other attempts to find the new k-means. I will keep it for now in the 
# case where these may actually be faster then the code I kept. 
M <- c(mean(diff[for(i in 1:K){
  logic <- which(clusters == i) 
  return(logic)
}
]))

Ks <- seq(1:K)
M <- c(mean(diff[which(clusters == Ks)]))

# Old function for checking if M matches Mnew

for(j in 1:K){ # 8 Milliseconds seems to be my longest running piece.
  if(M[i] == Mnew[i]){
    break
  }
}


## This is my first attempt at building a For loop for what the above did.
# Y <- c(rep(0,length(X)))

for (i in 1:length(X)){ 
  diff <- rep(0,K)
  diff <- (sqrt((X[i] - c(M))^2))
  # return(diff)
  Y[i] <- which(diff == min(diff))
  # assign("Y[i]",which(diff == min(diff)),envir = .GlobalEnv)
}

Y

## This is the original script for creating the values of M if M=NULL

if(is.null(M) & !is.matrix(X)){
  M <- (sample(X,K,replace=FALSE))
}

#selection of points from X if X is a matrix This tests at 1.2 microseconds
if(is.null(M) & is.matrix(X)){
  rows_data <- sample(nrow(X),K,replace=FALSE)
  M <- X[rows_data,]
}





