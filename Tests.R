# Use this file to create tests/debug your functions

# Source the functions
source("FunctionsKmeans.R")

#Looking at what the kmeans algorithm produces.
X<-sample(seq(1:100),10)
K <- 2
M <- c(10,90)
kmeans(X,2)$centers
X


#Super simple sample data
MyKmeans(X,K,M)
