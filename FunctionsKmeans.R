# Function that implements K-means algorithm. The default number of maximal iterations is 100.
# X - n by p matrix containing n data points to cluster
# K - integer specifying number of clusters
# M - (optional) K by p matrix of cluster centers
# numIter - number of maximal iterations for the algorithm, the default value is 100



#Building a function to place into an apply statement



MyKmeans <- function(X, K, M = NULL, numIter = 100){
 
  # Check whether M is NULL or not. If NULL, initialize based on K randomly selected points from X.
  if(is.null(M)){
    M <- (sample(X,K,replace=FALSE))
  }
  # If not NULL, check for compatibility with X dimensions and K.
  
  #Coercing values of M into matrix of size K.

  #Creating an empty variable to store clustered assignments. 
  Y <- c(rep(0,length(X))) 

## Maybe it would be wise to add a While loop here to check when to end. 
  #For finding Euclidean Differences, and selecting the clusters
  diff <- apply(as.matrix(X),c(1:2),function(X) {sqrt((X - M)^2)})
  clusters <- apply(diff,2,function(z) which(z == min(z)))
  
  #This Piece is for re-evaluating the k-means
  M <- c(mean(diff[for(i in length(K)){
    logic <- which(clusters == i) 
    return(logic)
    }
  ]))
  
  
  # Implement K-means algorithm. 
  # It should stop when either 
  # (i) the centroids don't change from one iteration to the next (exactly the same), or
  # (ii) the maximal number of iterations was reached, or
  # (iii) one of the clusters has disappeared after one of the iterations (in which case the error message is returned)
  
  # Return the vector of assignments Y
  return(clusters)
}
