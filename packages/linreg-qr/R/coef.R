#' This function is returning the regression coefficients form linreg
#'
#' @param object An object
#' @param ... Additional arguments
#' @examples
#' lm<-linreg(formula = Petal.Length ~ Species, data = iris)
#' coef(lm)
#' @export

coef.linreg <- function(object, ...) {

  return(object[["regression_coefficient"]])
}

