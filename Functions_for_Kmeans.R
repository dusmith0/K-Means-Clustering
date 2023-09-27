### This file contains functions that can be used in FunctionsKmeans.R

## For calculating the clusters:
diff_clusters <- function(Data,M){
  diff <- apply(as.matrix(Data),c(1:2),function(Data) {sqrt((Data - M)^2)})
  clusters <- apply(diff,2,function(z) which(z == min(z)))
  #return(diff)
  return(clusters)
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


##Trying to create a for loop that will iterate through each value of M on each X
for(j in 1:nrow(X)){
  apply(M,2,function(X) {norm((X[j,] - M),type="2")})
}

## Maybe try a double apply where you go through each row and then column?
