#' Printing the summary of linreg object
#'
#' @param object An object
#' @param ... Additional arguments
#' @examples
#' lm <- linreg(Petal.Length ~ Sepal.Width + Sepal.Length, data = iris)
#' summary(lm)
#' @export
#'
#
summary.linreg <- function(object, ...) {

   smry<- as.data.frame(object[["regression_coefficient"]])
   smry[,1]<-round(as.numeric(object[["regression_coefficient"]]), 5)
   smry[,2]<-round(as.numeric(object[["std_error"]]), 5)
   smry[,3]<-round(as.numeric(object[["t_values"]]), 5)
   smry[,4]<-object[["p_values"]]
   smry[,5]<-sapply(object[["p_values"]],
                    function(x) if(x<0.001) {"***"}
                    else if (x<0.01) {"**"}
                    else if (x<0.05) {"*"}
                    else if (x<0.1) {"."}
                    else {""})
   cat("Call: \n")
   print(object[["call"]])
   colnames(smry)<-c("Estimate", "Std. Error", "t value", "Pr(>|t|)", " ")
   cat("\nCoefficients: \n")
   print(smry)
   cat("---\n")
   cat(paste("Residual standard error:", round(object[["r_se"]], 5), "on",
       object[["degree_of_freedom"]], "degrees of freedom"))

}

#summary(linreg(formula = Petal.Length ~ Sepal.Width + Sepal.Length, data = iris))
