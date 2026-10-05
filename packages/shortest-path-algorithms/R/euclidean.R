#' @title euclidean
#' euclidiean calculates the Greatest Common Divisor (GCD) for 2 numbers
#'
#' @param b a number
#' @param a a number
#' @description euclidean use the euclidean algorithm to calculcate the GCD.
#' @source
#' see more at: \url{https://en.wikipedia.org/wiki/Euclidean_algorithm}
#'
#' @return The GCD of \code{b} and \code{a}.
#' @export
#' @examples
#' euclidean(123612, 13892347912)
#' euclidean(100, 1000)



euclidean <-
function(b, a) {

  stopifnot( class(a) == 'numeric' && length(a) == 1 && class(b) == 'numeric' && length(b) == 1 )

  while (b != 0) {

    q <- b
    b <- a %% b
    a <- q
    q <- abs(q)

    }

  return(q)

}
