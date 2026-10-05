#' @title Brute force knapsack
#' 
#' The brute force knapsack algorithm
#' @name brute_force_knapsack
#' @param x data frame with value and weights
#' @param W the capacity of the knapsack
#' @return total value and elements
#' @description calculates the knapsack problem with a brute force algorithm.
#' @export 
#' @references https://en.wikipedia.org/wiki/Knapsack_problem
#' @import parallel
#' 
suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )

brute_force_knapsack <- function(x, W, parallel=FALSE) {
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  
  # define variables
  n <- nrow(x) 
  N <- 2^n
  elements <- 1:n
  
  # create matrix with all possibilities, either parallel or normal
  if (parallel == 'TRUE') { 
    
    # Check the number of cores on the computer
    OS <- Sys.info()['sysname']
    
    if (OS == "Windows") { 
      cores <- parallel::detectCores(logical = FALSE) - 2
    } else {
      cores <- parallel::detectCores() - 1
    }
    
    # set up cluster
    cluster <- makeCluster(cores, type = "PSOCK")
    
    N <- parLapply(cluster, N, function(N) intToBits(1:N))
    N <- parLapply(cluster, N, function(N) as.numeric(N))
    N <- parLapply(cluster, N, function(N) matrix(N, ncol = 32, byrow = TRUE))
    N <- N[[1]][,elements]
    
    # calculate every possibility
    vTmp <- parLapply(cluster, N, function(N) N%*%x$v )
    wTmp <- N%*%x$w
    
    # Shut down cluster
    stopCluster(cluster)
    
  } else {
    
    N <- matrix(as.numeric(intToBits(1:N)), ncol = 32, byrow = TRUE)
    N <- N[,elements]
    
    # calculate every possibility
    vTmp <- N%*%x$v 
    wTmp <- N%*%x$w

  }

  
  # choose the best possibility
  value <- max(vTmp[which(wTmp <= W)])
  elements <- elements[which(N[which(vTmp == value),] == 1)]
  
  result <- list(value=round(value), elements=elements)

  return(result) 
  
}

