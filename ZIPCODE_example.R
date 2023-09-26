# Application of K-means algorithm to ZIPCODE data

# Rand Index Calculation example
require(fossil)
cluster1 <- c(2,2,1,3)
cluster2 <- c(3,3,2,1)
rand.index(cluster1, cluster2) # clusters match

# Load the ZIPCODE data
zipcode <- read.table("ZIPCODE.txt", header = F)

# Extract the true digits
Y <- zipcode[ , 1]

# Extract the data points
X <- zipcode[ , -1]

# [ToDo] Try K-means algorithm nRep times with different starting points
# on ZIPCODE data. Calculate Rand Index at each replication
nRep <- 50
MyKmeans(X,10,numIter = nRep)
cluster <- kmeans(X,10,iter.max=nRep)$cluster



# [ToDo] Report mean Rand Index
rand.index(Y,cluster)

# [ToDo] Report mean run time for one replication on your machine
