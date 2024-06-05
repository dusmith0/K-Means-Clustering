## K-means

K-means is one of the most popular clustering algorithms. Given n data
points
![x_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;x_i "x_i"),
![i=1,\dots, n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3D1%2C%5Cdots%2C%20n "i=1,\dots, n"),
in p dimensions,
![x_i\in \mathbb{R}^p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;x_i%5Cin%20%5Cmathbb%7BR%7D%5Ep "x_i\in \mathbb{R}^p"),
the algorithm iteratively divides the points into
![K](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;K "K")
clusters/groups such that the points within each group are most similar.
Specifically, it aims to minimize

![\sum\_{k=1}^K \sum\_{x_i \in \text{cluster k}}\\\|x_i - \mu_k\\\|\_2^2,](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Csum_%7Bk%3D1%7D%5EK%20%5Csum_%7Bx_i%20%5Cin%20%5Ctext%7Bcluster%20k%7D%7D%5C%7Cx_i%20-%20%5Cmu_k%5C%7C_2%5E2%2C "\sum_{k=1}^K \sum_{x_i \in \text{cluster k}}\|x_i - \mu_k\|_2^2,")

where

![\mu_k = \frac1{n_k}\sum\_{x_i \in \text{cluster k}}x_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu_k%20%3D%20%5Cfrac1%7Bn_k%7D%5Csum_%7Bx_i%20%5Cin%20%5Ctext%7Bcluster%20k%7D%7Dx_i "\mu_k = \frac1{n_k}\sum_{x_i \in \text{cluster k}}x_i")

is the center or **centroid** of the
![k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;k "k")th
cluster with
![n_k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n_k "n_k")
being the number of points in the cluster
![k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;k "k").
Here
![\\\|x_i - \mu_k\\\|\_2^2](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5C%7Cx_i%20-%20%5Cmu_k%5C%7C_2%5E2 "\|x_i - \mu_k\|_2^2")
is the squared Euclidean distance between
![x_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;x_i "x_i")
and
![\mu_k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu_k "\mu_k"),
although other distance metrics are possible. This particular program run through hand written ZIPCODE data in an attempt to predict what letter has been writtien. 

## Algorithm’s implementation

To minimize the above objective, K-means performs iterative adjustment
of cluster centers. The algorithm is not guaranteed to find the absolute
minimizer, but (hopefully) comes pretty close.

To start, the algorithm chooses random
![K](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;K "K")
points out of
![n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n "n")
as the cluster centers
![\mu_k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu_k "\mu_k").

Given the current cluster centers, at each iteration the algorithm

-   computes the Euclidean distance from each point
    ![i=1,\dots, n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3D1%2C%5Cdots%2C%20n "i=1,\dots, n")
    to each center
    ![\mu_k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu_k "\mu_k")
-   assigns each point to the cluster corresponding to the nearest
    center (among the
    ![K](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;K "K"))
-   after all
    ![n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n "n")
    points are assigned, the algorithm recomputes the centroid values
    ![\mu_k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu_k "\mu_k")
    based on new assignments

These iterations are repeated until either a **convergence criterion is
met** (i.e. the centroid values don’t change from one iteration to the
next), or the **maximal number of iterations is reached**, or **one of
the clusters has disappeared** (this indicated bad starting point, see
below). This specific implementation of K-means is sometimes referred to
as **Lloyd’s algorithm**.

## The function for completing this process is given below. 
MyKmeans(X, K, M, numIter) where;
1. X is a matrix of the data set in n x p 
2. K is the number of desired clusters
3. M is an optional starting cluster to begin in K x p matrix
4. numIter is the amount of iterations for the algorithm to run. 
    
### Exmaple of the implumentation of the algorithm:
```{r, echo = TRUE, eval = TRUE}
# Application of K-means algorithm to ZIPCODE data
# Rand Index Calculation example
require(fossil)
cluster1 <- c(2,2,1,3)
cluster2 <- c(3,3,2,1)
rand.index(cluster1, cluster2) # clusters match

# Load the ZIPCODE data
zipcode <- read.table("ZIPCODE.txt", header = F)

# Extract the true digits (the first Column are the true values)
Y <- zipcode[1:100 , 1]

# Extract the data points
X <- zipcode[1:100 , -1]

# on ZIPCODE data. Calculate Rand Index at each replicatio
nRep <- 50
r <- rep(0,nRep)

# With MyKmeans
nRep <- 50
r <- rep(NULL,nRep)

for(i in 1:nRep){
  cluster <- MyKmeans(X,10,numIter = 1)
  r <- rand.index(Y,cluster)
}
    
cluster
r  # The value of r was used to assess the accuracy of the clusters, with 1 being perfect.
```
    
    