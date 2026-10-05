#' This function printing the regression coefficients form linreg
#'
#' @param x An object
#' @param ... Additional arguments
#' @examples
#' lm<-linreg(formula = Petal.Length ~ Species, data = iris)
#' print(lm)
#' @export

print.linreg <- function(x, ...) {

  cat("Call:\n")
  print(x[["call"]])
  cat("\nCoefficients: \n")
  print(x[["regression_coefficient"]])

}

#print(linreg(Petal.Length~Species, data = iris))
