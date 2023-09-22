# Use this file to create tests/debug your functions

# Source the functions
source("FunctionsKmeans.R")

#Looking at what the kmeans algorithm produces.
X<-sample(seq(1:100),10)
K <- 2

kmeans(X,2)$centers
X

