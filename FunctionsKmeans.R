# Function that implements K-means algorithm. The default number of maximal iterations is 100.
# X - n by p matrix containing n data points to cluster
# K - integer specifying number of clusters
# M - (optional) K by p matrix of cluster centers
# numIter - number of maximal iterations for the algorithm, the default value is 100



# Building a function to place into an apply statement



MyKmeans <- function(X, K, M = NULL, numIter = 100){
 
  # Check whether M is NULL or not. If NULL, initialize based on K randomly 
  # selected points from X.
  if(is.null(M) & !is.matrix(X)){
    M <- (sample(X,K,replace=FALSE))
  }
  
  #selection of points from X if X is a matrix
  if(is.null(M) & is.matrix(X)){
    rows_data <- sample(nrow(X),K,replace=FALSE)
    M <- X[rows_data,]
  }
  # If not NULL, check for compatibility with X dimensions and K.
  
  # Checking length of M to match that of K.
  if(K != length(M)){
    stop(paste("Error: The number of values you have for M=Starting Means, must match 
    the value you chose for K=Number of clusters."))
  }

  # Creating an empty variable to store clustered assignments, New K-means, and 
  # a counter for numIter.
  Y <- c(rep(0,length(X))) 
  Mnew <- c(rep(NULL,K))
  counter <- 0

  # Implement K-means algorithm.
  # Break option (ii) the maximal number of iterations was reached
  while(counter != numIter){
    # Creating a Counter and merging the Mnew with M
    counter <- counter + 1

    if(is.null(Mnew) == FALSE){ #1125 nano-seconds
      M <- Mnew
    }
  
    
    # For finding Euclidean Differences, and selecting the clusters
 
    diff <- apply(as.matrix(X),c(1:2),function(X) {sqrt((X - M) ^ 2)}) #104 microseconds
#   diff <- apply(as.matrix(X),c(1,2),function (X - M) norm((X - M),type="2"))
    clusters <- apply(diff,2,function(z) which(z == min(z))) #203 Microseconds

    # clusters <- apply(diff,2,function(z) which.min(diff)) #65 Microseconds
    # This Piece is for re-evaluating the k-means

    for(i in 1:K){
      Mnew[i] <- mean(X[which(clusters == i)])
    }

    # Break option 1 the centroids don't change from one iteration to the next (exactly the same),
      if(identical(M,Mnew)){
        break
      }

    # Break option (iii) one of the clusters has disappeared after one of the iterations (in which case the error message is returned)
       if(any(is.nan(Mnew))){
         stop(paste("Error: The function completely removed one cluster with the chosen
                  values of M. Please generate or choose a different set of initial clusters
                  and attempt the function again."))
      }
  
    # Return the vector of assignments Y
  }
  Y <- clusters
  return(Y)
 }
