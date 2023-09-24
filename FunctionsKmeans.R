# Function that implements K-means algorithm. The default number of maximal iterations is 100.
# X - n by p matrix containing n data points to cluster
# K - integer specifying number of clusters
# M - (optional) K by p matrix of cluster centers
# numIter - number of maximal iterations for the algorithm, the default value is 100

set.seed(12)
X<-sample(seq(1:100),10)
K <- 2
M <- c(10,90)
X<- rep(X,K)

M <- matrix(rep(M,length(X)),nrow=K,byrow=TRUE)

Y <- c(rep(0,length(X)))

#Building a function to place into an apply statement
diff_calculation <- function(data){
  diff <- apply(as.matrix(X),c(1:2),function(X) {sqrt((X - M)^2)})
  
}

#Attempting apply instead of a for loop

diffs<- mapply(function(X){sqrt((X - c(M))^2)})

#This sort of works, but does not add in the correct order.
diffs <- matrix((sqrt((X[] - c(M))^2)),byrow = FALSE, ncol = 2)
clusters <- apply(diffs,1,function(z) which(z == min(z)))


for (i in length(X)){ #The loop is not exicuting to the global enviornment. Try mapply instead.
  diff <- rep(0,K)
  diff <- (sqrt((X[i] - c(M))^2))
  #return(diff)
  assign("Y[i]",which(diff == min(diff)),envir = .GlobalEnv)
  #return(Y)
}

Y


MyKmeans <- function(X, K, M = NULL, numIter = 100){
 
  # Check whether M is NULL or not. If NULL, initialize based on K randomly selected points from X.
  if(is.null(M)){
    M <- (sample(X,K,replace=FALSE))
  }
  # If not NULL, check for compatibility with X dimensions and K.
  
  #Coercing values of M into matrix of size K.
  M <- matrix(M,nrow=K)
  
  #Creating an empty variable to store clustered assignments. 
  Y <- c(rep(0,length(X))) 
 
  #For finding Euclidean Differences, and selecting the clusters
  diffs <- matrix((sqrt((X[] - c(M))^2)),byrow = FALSE, ncol = 2)
  clusters <- apply(diffs,1,function(z) which(z == min(z)))
  
  # Implement K-means algorithm. 
  # It should stop when either 
  # (i) the centroids don't change from one iteration to the next (exactly the same), or
  # (ii) the maximal number of iterations was reached, or
  # (iii) one of the clusters has disappeared after one of the iterations (in which case the error message is returned)
  
  # Return the vector of assignments Y
  return(Y)
}
