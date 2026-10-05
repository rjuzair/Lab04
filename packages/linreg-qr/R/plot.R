#' This function is being used to plot regression coefficients values form linreg
#'
#' @param x An object
#' @param ... Additional arguments
#' @examples
#' lm<-linreg(formula = Petal.Length ~ Species, data = iris)
#' plot(lm)
#'
#' @import ggplot2
#' @import cowplot
#' @importFrom stats median
#' @export

plot.linreg <- function(x, ...){
  df<- data.frame(x[["residuals"]], x[["fitted_values"]], x[["Sqrt_std_residuals"]])

  p1<- ggplot2::ggplot(df, ggplot2::aes(y = df[,1], x = df[,2])) +
    ggplot2::geom_point(shape = 1, size = 5) +
    ggplot2::stat_summary_bin(fun = median, geom = "line", color = "red")+
    ggplot2::xlab(paste0("Fitted values \n", "linreg(",deparse(x[["formula"]]),")" )) + ggplot2::ylab("Residuals") +
    ggplot2::ggtitle("Residuals vs Fitted") + ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))




  p2<- ggplot2::ggplot(df, ggplot2::aes(y = df[,3], x = df[,2])) +
    ggplot2::geom_point(shape = 1, size = 5) +
    ggplot2::stat_summary_bin(fun = mean, geom = "line", color = "red") +
    ggplot2::xlab(paste0("Fitted values \n", "linreg(",deparse(x[["formula"]]),")" )) + ggplot2::ylab(expression(sqrt("Standardized residuals"))) +
    ggplot2::ggtitle("Scale-Location") + ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))


  cowplot::plot_grid(p1, p2,
                     ncol = 1,
                     nrow = 2)


}

#plot(linreg(formula = Petal.Length ~ Species, data = iris))
