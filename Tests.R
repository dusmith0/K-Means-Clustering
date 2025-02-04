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

# The below data is for simple tests with MyKmeans.
set.seed(12)
X<-sample(seq(1:100),10)
K <- 3
M <- c(10,50,30)
M <- c(29,92,71)
M <- c(sample(10,10,replace = TRUE))
M <- NULL


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


# Creating a new test with a set of 3D coordinates
set.seed(12)
x <- sample(1:100,10)
set.seed(20)
y <- sample(1:100,10)
set.seed(300)
z <- sample(1:100,10)
K <- 5

X <- data <- matrix(c(x,y,z),byrow=FALSE,nrow=10)

microbenchmark(
MyKmeans(data,K,numIter = 100000)
)

Rprof()
invisible(MyKmeans(data,K))
Rprof(NULL)
summaryRprof()

microbenchmark(
  kmeans(data,K,algorithm = "Lloyd")
)

## Trying to create a large set of data to see if my function is working or not.
set.seed(12)
x <- sample(1:100,20)
set.seed(20)
y <- sample(1:100,20)
set.seed(300)
z <- sample(1:100,20)
K <- 5

X <- data <- matrix(c(x,y,z),byrow=FALSE,nrow=20)

microbenchmark(
  MyKmeans(data,K)
) # ran at 22.747 milliseconds


microbenchmark(
  kmeans(data,K)
) # ran at 318 microseconds





