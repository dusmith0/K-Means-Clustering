# Application of K-means algorithm to ZIPCODE data

# Rand Index Calculation example
require(fossil)
cluster1 <- c(2,2,1,3)
cluster2 <- c(3,3,2,1)
rand.index(cluster1, cluster2) # clusters match

# Load the ZIPCODE data
zipcode <- read.table("ZIPCODE.txt", header = F)

# Extract the true digits
Y <- zipcode[1:1000 , 1]

# Extract the data points
X <- zipcode[ , -1]

# [ToDo] Try K-means algorithm nRep times with different starting points
# on ZIPCODE data. Calculate Rand Index at each replication
nRep <- 50
r <- rep(0,nRep)

# With the base kmeans to compare
for(i in 1:nRep){
  cluster <- (kmeans(X,10)$cluster) 
  r[i] <- rand.index(Y,cluster)
}

# With MyKmeans
nRep <- 10
r <- rep(NULL,nRep)

for(i in 1:nRep){
  cluster <- MyKmeans(X,10,numIter = 1)
  r <- rand.index(Y,cluster)
}

microbenchmark(
  MyKmeans(X,10,numIter = 1)
)

# [ToDo] Report mean Rand Index
(mean(r)) #I a mean Rand Index of .889 

# [ToDo] Report mean run time for one replication on your machine
# The mean run time is still incredibly slow, even with vectorization. 
# I was not able to run my function on the Zip data in a reasonable time. 
# However, to compare on a toy example MyKmeans ran at 31 milliseconds
# while base::kmeans ran at 515 microsecond. I am sorry I was not able to meet 
# the time requirements. 
