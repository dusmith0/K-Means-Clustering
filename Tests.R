# Use this file to create tests/debug your functions

# Source the functions
source("FunctionsKmeans.R")

#Calling the Function
Y <- c(rep(0,length(X)))

#Super simple sample data
MyKmeans(X,K,M)
MyKmeans(X,K)

kmeans(X,K,M)
kmeans(X,K)

#Looking at what the kmeans algorithm produces.
set.seed(12)
X<-sample(seq(1:100),10)
K <- 3
M <- c(10,90,30)
M <- c(29,92,71)


#The below code was my attempt to change the format of M to see what would happen.
#M <- matrix(rep(M,length(X)),nrow=K,byrow=TRUE)


#Testing to see if my first Error message works:
set.seed(12)
X<-sample(seq(1:100),10)
K <- 3
M <- c(10,90)
