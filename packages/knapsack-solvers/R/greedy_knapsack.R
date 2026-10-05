#' @title knapsack_greedy
#' 
#' The greedy knapsack algorithm
#' @name greedy_knapsack
#' @param x data frame with value and weights
#' @param W the capacity of the knapsack
#' @return total value and elements
#' @description calculates the knapsack problem with the greedy algorithm.
#' @export 
#' @references https://en.wikipedia.org/wiki/Knapsack_problem#Greedy_approximation_algorithm
#' 
suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )


greedy_knapsack <- function(x, W) {
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0 )
  
  n <- length(x$v)
  element <- 1:n
  weight <- 0
  wn <- x$v/x$w
  wn <- data.frame(wn, x$v, x$w, element)
  wn <- wn[order(wn$wn, decreasing = TRUE), ]
  rownames(wn) <- 1:n
  i <- 1    
  
  while (weight < W) {
    
    weight <- weight + wn$x.w[i]
    i <- i + 1
    
  }
  
  a <- i-2 # remove 2 last since went 1 too far and added 1 to i
  tmp <- wn[1:a,]
  result <- list(value=round(sum(tmp$x.v)), elements=tmp$element)
  
  
  return(result)
}

