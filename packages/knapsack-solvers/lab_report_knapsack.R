## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(Lab6)
library(profvis)
library(parallel)


## -----------------------------------------------------------------------------
brute_force_knapsack <- function(x, W) {
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  n <- nrow(x)  
  value <- 0
  
  # create binary matrix with all possibilities
  N <- matrix(as.numeric(intToBits(1:2^n)), ncol = 32, byrow = TRUE)
  N <- N[,1:n]
  nN <- nrow(N)
  
  for (i in 1:nN) {
    
    # check all possibilities
    if (any(N[i,] == 1)) {
      
      # store elements
      j <- which(N[i,] == 1)
      
      # sum values and weights
      vTmp <- sum(x$v[j])
      wTmp <- sum(x$w[j])
      
    }
    
    # store the value and elements of the best possibility
    if (vTmp > value && wTmp <= W) {
      
      value <- vTmp
      element <- j
      
    }
    
  }
  
  result <- list(value=round(value), elements=element)
  
  return(result) 
}


## ---- echo=FALSE--------------------------------------------------------------
suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )

brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500)
brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000)


## ---- echo=FALSE--------------------------------------------------------------
brute_force_knapsack <- function(x, W) {
  
  startTime <- Sys.time()
  Sys.sleep(1)
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  n <- nrow(x)  
  value <- 0
  
  # create binary matrix with all possibilities
  N <- matrix(as.numeric(intToBits(1:2^n)), ncol = 32, byrow = TRUE)
  N <- N[,1:n]
  nN <- nrow(N)
  
  for (i in 1:nN) {
    
    # check all possibilities
    if (any(N[i,] == 1)) {
      
      # store elements
      j <- which(N[i,] == 1)
      
      # sum values and weights
      vTmp <- sum(x$v[j])
      wTmp <- sum(x$w[j])
      
    }
    
    # store the value and elements of the best possibility
    if (vTmp > value && wTmp <= W) {
      
      value <- vTmp
      element <- j
      
    }
    
  }
  
  result <- list(value=round(value), elements=element)
  
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time)   
}

brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500)


## ---- echo=FALSE--------------------------------------------------------------
profvis({
  
  brute_force_knapsack <- function(x, W) {
    
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  n <- nrow(x)  
  value <- 0
  
  # create binary matrix with all possibilities
  N <- matrix(as.numeric(intToBits(1:2^n)), ncol = 32, byrow = TRUE)
  N <- N[,1:n]
  nN <- nrow(N)
  
  for (i in 1:nN) {
    
    # check all possibilities
    if (any(N[i,] == 1)) {
      
      # store elements
      j <- which(N[i,] == 1)
      
      # sum values and weights
      vTmp <- sum(x$v[j])
      wTmp <- sum(x$w[j])
      
    }
    
    # store the value and elements of the best possibility
    if (vTmp > value && wTmp <= W) {
      
      value <- vTmp
      element <- j
      
    }
    
  }
  
  result <- list(value=round(value), elements=element)
    
    return(result)
  }
  
  brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500)
  
})


## ---- echo=TRUE---------------------------------------------------------------
profvis({
  
  brute_force_knapsack <- function(x, W) {
    
    stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
    
    n <- nrow(x) 
    elements <- 1:n
    
    # create matrix with all possibilities
    N <- matrix(as.numeric(intToBits(1:2^n)), ncol = 32, byrow = TRUE)
    N <- N[,1:n]
    
    # calculate every possibility
    vTmp <- N%*%x$v 
    wTmp <- N%*%x$w
    
    # choose the best possibility
    value <- max(vTmp[which(wTmp <= W)])
    elements <- elements[which(N[which(vTmp == value),] == 1)]
    
    result <- list(value=round(value), elements=elements)
    
    return(result) 
  }
  
  brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500)
  
})


## ---- echo=FALSE--------------------------------------------------------------

brute_force_knapsack <- function(x, W) {
  
  startTime <- Sys.time()
  Sys.sleep(1)  
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  
  n <- nrow(x) 
  elements <- 1:n
  
  # create matrix with all possibilities
  N <- matrix(as.numeric(intToBits(1:2^n)), ncol = 32, byrow = TRUE)
  N <- N[,1:n]
  
  # calculate every possibility
  vTmp <- N%*%x$v 
  wTmp <- N%*%x$w
  
  # choose the best possibility
  value <- max(vTmp[which(wTmp <= W)])
  elements <- elements[which(N[which(vTmp == value),] == 1)]
  
  result <- list(value=round(value), elements=elements)
  
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time) 
  
}

brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500)



## -----------------------------------------------------------------------------
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


## -----------------------------------------------------------------------------
dynamic_knapsack(x = knapsack_objects[1:8,], W = 3500)
dynamic_knapsack(x = knapsack_objects[1:12,], W = 3500)
dynamic_knapsack(x = knapsack_objects[1:8,], W = 2000)
dynamic_knapsack(x = knapsack_objects[1:12,], W = 2000)


## ---- echo=FALSE--------------------------------------------------------------
dynamic_knapsack <- function(x, W) {
  
  startTime <- Sys.time()
  Sys.sleep(1)
  
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
  
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time)
  
}

dynamic_knapsack(x = knapsack_objects[1:500,], W = 3500)



## ---- echo=FALSE--------------------------------------------------------------
profvis({
  
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
  
  dynamic_knapsack(x = knapsack_objects[1:500,], W = 3500)
  
  
})


## ---- echo=FALSE--------------------------------------------------------------
dynamic_knapsack <- function(x, W) {
  
  startTime <- Sys.time()
  Sys.sleep(1)
  
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
  
  v <- x$v
  w <- x$w
  
  # calculates the max value 
  for (i in 2:n) {
    
    for (j in 1:W) {
      
      if (w[i] > j) {
        
        m[i, j] <- m[i-1, j]
        
      } else {
        
        m[i, j] <- max(m[i-1, j], m[i-1, j-w[i]] + v[i])
        
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
      
      return(c(i, knapsack_elements(i-1, j-w[i])))
      
    } else {
      
      return(knapsack_elements(i-1, j))
      
    }
    
  }
  
  elements <- knapsack_elements(n, W)
  
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time)
  
}

dynamic_knapsack(x = knapsack_objects[1:500,], W = 3500)



## ---- echo=FALSE--------------------------------------------------------------
profvis({
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
    
    # pre define data frame columns
    v <- x$v
    w <- x$w
    
    # calculates the max value 
    for (i in 2:n) {
      
      for (j in 1:W) {
        
        if (w[i] > j) {
          
          m[i, j] <- m[i-1, j]
          
        } else {
          
          m[i, j] <- max(m[i-1, j], m[i-1, j-w[i]] + v[i])
          
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
        
        return(c(i, knapsack_elements(i-1, j-w[i])))
        
      } else {
        
        return(knapsack_elements(i-1, j))
        
      }
      
    }
    
    elements <- knapsack_elements(n, W)
    
    return(list(value=round(result), elements=sort(elements)))
    
  }
  
  
  dynamic_knapsack(x = knapsack_objects[1:500,], W = 3500)
  
  
})


## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------

greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
greedy_knapsack(x = knapsack_objects[1:1200,], W = 2000)


## ---- echo=FALSE--------------------------------------------------------------

greedy_knapsack <- function(x, W) {
  
  startTime <- Sys.time()
  Sys.sleep(1)
  
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
  
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time)
  
}

suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 1000000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )

greedy_knapsack(x = knapsack_objects[1:1000000,], W = 3500)


## ---- echo=FALSE--------------------------------------------------------------
profvis({
  
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
  
  suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
  set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
  n <- 1000000
  knapsack_objects <-
    data.frame(
      w=sample(1:4000, size = n, replace = TRUE),
      v=runif(n = n, 0, 10000)
    )
  
  greedy_knapsack(x = knapsack_objects[1:1000000,], W = 3500)
  
})


## ---- echo=FALSE--------------------------------------------------------------

greedy_knapsack <- function(x, W) {
  
  startTime <- Sys.time()
  Sys.sleep(1)
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0 )
  
  n <- length(x$v)
  element <- 1:n
  weight <- 0
  wn <- x$v/x$w
  wn <- data.frame(wn, x$v, x$w, element)
  wn2 <- wn$wn
  wn <- wn[order(wn2, decreasing = TRUE), ]
  rownames(wn) <- 1:n
  i <- 1    
  
  while (weight < W) {
    
    weight <- weight + wn$x.w[i]
    i <- i + 1
    
  }
  
  a <- i-2 # remove 2 last since went 1 too far and added 1 to i
  tmp <- wn[1:a,]
  result <- list(value=round(sum(tmp$x.v)), elements=tmp$element)
  
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time)
  
}

suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 1000000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )

greedy_knapsack(x = knapsack_objects[1:1000000,], W = 3500)


## -----------------------------------------------------------------------------

cores <- parallel::detectCores(logical = FALSE)
print(cores)


## -----------------------------------------------------------------------------
# updated function
brute_force_knapsack <- function(x, W, parallel = FALSE) {

  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  
  # define variables
  n <- nrow(x) 
  N <- 2^n
  elements <- 1:n

  # create matrix with all possibilities, either parallel or normal
  if (parallel == 'TRUE') { 
    
    # Check the number of cores on the computer
    OS <- Sys.info()['sysname']
    
    if (OS == "Windows" | OS == "Solaris") { 
      cores <- parallel::detectCores(logical = FALSE) - 2
    } else {
      cores <- parallel::detectCores() - 2
    }
    
    # set up cluster
    cluster <- makeCluster(cores, type = "PSOCK")
    
    N <- parLapply(cluster, N, function(N) intToBits(1:N))
    N <- parLapply(cluster, N, function(N) as.numeric(N))
    N <- parLapply(cluster, N, function(N) matrix(N, ncol = 32, byrow = TRUE))
    N <- N[[1]][,elements]
    
    # Shut down cluster
    stopCluster(cluster)
    
  } else {
    
    N <- matrix(as.numeric(intToBits(1:N)), ncol = 32, byrow = TRUE)
    N <- N[,elements]
    
  }

  # calculate every possibility
  vTmp <- N%*%x$v 
  wTmp <- N%*%x$w

  # choose the best possibility
  value <- max(vTmp[which(wTmp <= W)])
  elements <- elements[which(N[which(vTmp == value),] == 1)]
  
  result <- list(value=round(value), elements=elements)
  
  return(result)
  
}

brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500, parallel = TRUE)



## ---- echo=FALSE--------------------------------------------------------------
brute_force_knapsack <- function(x, W, parallel = FALSE) {

  startTime <- Sys.time()
  Sys.sleep(1)
  
  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  
  # define variables
  n <- nrow(x) 
  N <- 2^n
  elements <- 1:n

  # create matrix with all possibilities, either parallel or normal
  if (parallel == 'TRUE') { 
    
    # Check the number of cores on the computer
    OS <- Sys.info()['sysname']
    
    if (OS == "Windows" | OS == "Solaris") { 
      cores <- parallel::detectCores(logical = FALSE) - 2
    } else {
      cores <- parallel::detectCores() - 2
    }
    
    # set up cluster
    cluster <- makeCluster(cores, type = "PSOCK")
    
    N <- parLapply(cluster, N, function(N) intToBits(1:N))
    N <- parLapply(cluster, N, function(N) as.numeric(N))
    N <- parLapply(cluster, N, function(N) matrix(N, ncol = 32, byrow = TRUE))
    N <- N[[1]][,elements]
    
    # Shut down cluster
    stopCluster(cluster)
    
  } else {
    
    N <- matrix(as.numeric(intToBits(1:N)), ncol = 32, byrow = TRUE)
    N <- N[,elements]
    
  }

  # calculate every possibility
  vTmp <- N%*%x$v 
  wTmp <- N%*%x$w

  # choose the best possibility
  value <- max(vTmp[which(wTmp <= W)])
  elements <- elements[which(N[which(vTmp == value),] == 1)]
  
  result <- list(value=round(value), elements=elements)
    
  endTime <- Sys.time()
  Time <- endTime-startTime-1
  
  return(Time)
  
}

brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500, parallel = TRUE)


## ---- echo=FALSE--------------------------------------------------------------
profvis({
  
brute_force_knapsack <- function(x, W, parallel = FALSE) {

  stopifnot( class(x) == 'data.frame' & all(x$v >= 0) & all(x$w >= 0) & W > 0)
  
  # define variables
  n <- nrow(x) 
  N <- 2^n
  elements <- 1:n

  # create matrix with all possibilities, either parallel or normal
  if (parallel == 'TRUE') { 
    
    # Check the number of cores on the computer
    OS <- Sys.info()['sysname']
    
    if (OS == "Windows" | OS == "Solaris") { 
      cores <- parallel::detectCores(logical = FALSE) - 2
    } else {
      cores <- parallel::detectCores() - 2
    }
    
    # set up cluster
    cluster <- makeCluster(cores, type = "PSOCK")
    
    N <- parLapply(cluster, N, function(N) intToBits(1:N))
    N <- parLapply(cluster, N, function(N) as.numeric(N))
    N <- parLapply(cluster, N, function(N) matrix(N, ncol = 32, byrow = TRUE))
    N <- N[[1]][,elements]
    
    # Shut down cluster
    stopCluster(cluster)

  } else {
    
    N <- matrix(as.numeric(intToBits(1:N)), ncol = 32, byrow = TRUE)
    N <- N[,elements]
    
  }

  # calculate every possibility
  vTmp <- N%*%x$v 
  wTmp <- N%*%x$w

  # choose the best possibility
  value <- max(vTmp[which(wTmp <= W)])
  elements <- elements[which(N[which(vTmp == value),] == 1)]
  
  result <- list(value=round(value), elements=elements)
  
  return(result)
  
}

brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500, parallel = TRUE)

})


