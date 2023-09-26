# Use this file to create tests/debug your functions

# Source the functions
source("FunctionsKmeans.R")

# inserting libraries
library("microbenchmark")

# Calling the Function
Y <- c(rep(0,length(X)))

# Super simple sample data
MyKmeans(X,K,M)
MyKmeans(X,K,numIter=1000)

kmeans(X,K,M)
kmeans(X,K)

# Looking at what the kmeans algorithm produces.
set.seed(12)
X<-sample(seq(1:100),10)
K <- 3
M <- c(10,50,30)
M <- c(29,92,71)
M <- c(sample(10,10,replace = TRUE))
M <- NULL


# The below code was my attempt to change the format of M to see what would happen.
# M <- matrix(rep(M,length(X)),nrow=K,byrow=TRUE)


# Testing to see if my first Error message works:
set.seed(12)
X<-sample(seq(1:100),10)
K <- 3
M <- c(10,90)

# Checking my speed for now
numIter <- 10000
M <- NULL

Y <- c(rep(0,length(X))) 
Mnew <- c(rep(NULL,K))
counter <- 0

# Using Microbenchmark to check speed
microbenchmark(
  while(counter != numIter){
    counter <- counter + 1
    
    if(is.null(Mnew) == FALSE){
      M <- Mnew
    }
    
    diff <- apply(as.matrix(X),c(1:2),function(X) {sqrt((X - M)^2)})
    clusters <- apply(diff,2,function(z) which(z == min(z)))

    for(i in 1:K){
      Mnew[i] <- mean(X[which(clusters == i)])
      
    }
    
    for(j in 1:K){
      if(M[i] == Mnew[i]){
        break
      }
    }
    

  }
)

microbenchmark(
  kmeans(X,K,iter.max = numIter)
  )

microbenchmark(
  MyKmeans(X,K,M = c(10,90,30),numIter=10000)
)
## Using Rprof() to check for bottle necks
Rprof()
invisible(MyKmeans(X,K,M = c(10,80,30),numIter=1000))
Rprof(NULL)
summaryRprof()

# I am attempting to break my function by removing a cluster to see if
# My error message will work. 
MyKmeans(X,K,M = c(10,5,2),numIter=10000)

