#' This function is returning the Residuals form linreg
#'
#' @param object An object
#' @param ... Additional arguments
#' @examples
#' lm<-linreg(formula = Petal.Length ~ Species, data = iris)
#' resid(lm)
#' @export

residuals.linreg <- function(object, ...) {

  return(object[["residuals"]])
}

#resid(linreg(Petal.Length ~ Sepal.Width + Sepal.Length, data = iris))

