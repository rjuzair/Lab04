#' This function is returning the fitted values form linreg
#'
#' @param object An object
#' @param ... Additional arguments
#' @examples
#' lm<-linreg(formula = Petal.Length ~ Species, data = iris)
#' pred(lm)
#' @export

pred<- function(object, ...) {
  return(object[["fitted_values"]])
}
#pred(linreg(Petal.Length ~ Sepal.Width + Sepal.Length, data = iris))
