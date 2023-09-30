# Function that implements K-means algorithm. The default number of maximal iterations is 100.
# X - n by p matrix containing n data points to cluster
# K - integer specifying number of clusters
# M - (optional) K by p matrix of cluster centers
# numIter - number of maximal iterations for the algorithm, the default value is 100


MyKmeans <- function(X, K, M = NULL, numIter = 100){
  
  # Check whether M is NULL or not. If NULL, initialize based on K randomly 
  # selected points from X.
  if(is.null(M)){
    ifelse(!is.matrix(X), 
           (M <- sample(X,K,replace=FALSE)) , 
           ifelse(is.matrix(X),
                  {rows_data <- sample(nrow(X),K,replace=FALSE);
                  M <- X[rows_data,]},
                  M <- M
           )
    )
  } 

  # If not NULL, check for compatibility with X dimensions and K.

  # Checking length of M to match that of K.
  if(K != length(M) & !is.matrix(M)){
    stop(paste("Error: The number of values you have for M=Starting Means, must match 
    the value you chose for K=Number of clusters."))
  }
 
  # Checking length of rows in M to match that of K
  if(is.matrix(M)){
    if(K != (nrow(M))){
      stop(paste("Error: The number of values you have for M=Starting Means, must match 
      the value you chose for K=Number of clusters."))
    }
 
    # Checking to ensure that if X is in matrix for multiple varibales, M is in an 
    # comparable form.
    
    if(ncol(X) != ncol(M)){
      stop(paste("Error: this fuction requires that the number of columns (variables)
               in M (guessed centers) match that of X (your data)"))
    }
  }
 
  # Creating an empty variable to store clustered assignments, New K-means, and a counter for numIter.
  Y <- c(rep(0,length(X)))
  counter <- 0
  
  ### this bit runs if the X value supplied is a vector.
    if(!is.matrix(X) == TRUE){
      Mnew <- c(rep(0,K))
  
      while(counter != numIter){
        # Creating a Counter and merging the Mnew with M
        counter <- counter + 1
    
        if(counter != 1){ 
          M <- Mnew
        }
        
        # For finding Euclidean Differences, and selecting the clusters
        diff <- apply(as.matrix(X),c(1,2),function(X) {sqrt((X - M) ^ 2)})
        clusters <- apply(diff,2,function(z) which(z == min(z)))
    
        # Break option (iii) one of the clusters has disappeared after one of the iterations (in which case the error message is returned)
        if((length(table(clusters)) != K)){
            stop(paste("Note: The function completely removed one cluster with the chosen
                  values of M. Please generate or choose a different set of initial clusters
                  and attempt the function again."))
         }
    
        # clusters <- apply(diff,2,function(z) which.min(diff)) 
        # This Piece is for re-evaluating the k-means
    
        Mnew <- sapply(1:K,function(i) {
          ifelse((sum(clusters ==i)) > 1
                 ,mean(X[which(clusters == i)])
                 ,X[which(clusters == i)])
        })
        
        # Break option 1 the centroids don't change from one iteration to the next (exactly the same),
        if(identical(M,Mnew)){
          break
        }
      }
    }
 
  
   
  ## This bit runs if the X provided is a Matrix
  if(is.matrix(X)){
     Mnew <- matrix(rep(0),nrow=nrow(M),ncol=ncol(M))
 
    # Implement K-means algorithm.
    # Break option (ii) the maximal number of iterations was reached
    while(counter != numIter){
      # Creating a Counter and merging the Mnew with M
      counter <- counter + 1
      diff <- matrix(rep(0,(nrow(X)*nrow(M))),nrow=nrow(X))
      
      if(counter != 1){ 
        M <- Mnew
      }
      
      diff <- sapply(1:nrow(X),function(i){
              sapply(1:nrow(M),function(j){
              diff[i,j] <- norm((X[i,] - M[j,]),type="2")
            })
        })
      
      clusters <- apply(diff,2,function(z) which(z == min(z)))
    
 
      # Break option (iii) one of the clusters has disappeared after one of the iterations (in which case the error message is returned)
      if((length(table(clusters)) != K)){
        stop(paste("Note: The function completely removed one cluster with the chosen
                 values of M. Please generate or choose a different set of initial clusters
                and attempt the function again."))
      }
    
      # This Piece is for re-evaluating the k-means
      
      for(i in 1:K){
        if(sum(clusters ==i) > 1){
          Mnew[i,] <- colMeans(X[which(clusters == i),])
        }
        else{
          Mnew[i,] <- X[which(clusters == i),]
        }
      }

      # Break option 1 the centroids don't change from one iteration to the next (exactly the same),
      if(identical(M,Mnew)){
        break
      }
    }
  } #End of While loop

  # Return the vector of assignments Y
  Y <- clusters
  return(Y)
}
