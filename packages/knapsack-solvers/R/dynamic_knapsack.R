#' @title knapsack_dynamic
#' 
#' The dynamic knapsack algorithm
#' @name dynamic_knapsack
#' @param x data frame with value and weights
#' @param W the capacity of the knapsack
#' @return total value and elements
#' @description calculates the knapsack problem with a dynamic algorithm.
#' @export 
#' @references https://en.wikipedia.org/wiki/Knapsack_problem#Dynamic_programming_in-advance_algorithm
#' 
suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )


dynamic_knapsack <- function(x, W) {
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0 )
  
  # creates a m matrix
  n <- nrow(x)
  m <- matrix(1:W, nrow = n, ncol = W)
  for (j in 1:W) {
    m[1, j] <- 0
  }
  for (i in 1:n) {
    m[i, 1] <- 0
  }
  
  # calculates the max value 
  for (i in 2:n) {
    
    for (j in 1:W) {
      
      if (x$w[i] > j) {
        
        m[i, j] <- m[i-1, j]
        
      } else {
        
        m[i, j] <- max(m[i-1, j], m[i-1, j-x$w[i]] + x$v[i])
        
      }
      
    }
    
  }
  
  result <- m[n, W]
  
  # Extracts the elements
  knapsack_elements <- function(i, j) {
    
    if (i == 1) {
      
      return()
      
    }
    
    if (m[i, j] > m[i-1, j]) {
      
      return(c(i, knapsack_elements(i-1, j-x$w[i])))
      
    } else {
      
      return(knapsack_elements(i-1, j))
      
    }
    
  }
  
  elements <- knapsack_elements(n, W)
  
  return(list(value=round(result), elements=sort(elements)))
}


