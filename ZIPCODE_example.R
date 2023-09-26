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
r <- rep(NULL,nRep)

# With the base kmeans to compair
for(i in 1:nRep){
  microbenchmark(  
  cluster <- kmeans(X,10)
  )

  r[i] <- rand.index(Y,cluster)
  
}

# With MyKmeans
nRep <- 50
r <- rep(NULL,nRep)

for(i in 1:nRep){
  microbenchmark(  
    cluster <- MyKmeans(X,10)
  )
  
  r[i] <- rand.index(Y,cluster)
  
}


# [ToDo] Report mean Rand Index
(mean(r))

# [ToDo] Report mean run time for one replication on your machine
