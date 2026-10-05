#' Linear Regression Model using QR decomposition
#'
#' @param formula A model formula equation
#' @param data A data set
#' @description It compute multiple regression model values to determine statistical parameters.
#' @return Multiple regression coefficients
#' @examples
#' lm<- linreg(Petal.Length ~ Sepal.Width + Sepal.Length, data = iris)
#' @import stats
#' @export

linreg <- function(formula, data) {

  ##Model Matrix
  X<-model.matrix(formula, data)
  y_var<-all.vars(formula)[1]
  y<-data[[y_var]]


  # Compute the QR decomposition
  QR<-qr(X)
  Q<-qr.Q(QR)
  R<-qr.R(QR)

  #calculating the regressions coefficients (beta_hat)
  #r_coeff<-solve.qr(QR, y)
  r_coeff<-qr.coef(QR, y)

  # calculate the fitted values (y_hat)
  f_values<-as.numeric(X%*%r_coeff)
  # print(f_values)

  # calculating the residuals (e_hat)
  residuals<-as.numeric(qr.resid(QR,y))

  # calculate the degrees of freedom (df)
  n<-nrow(data)
  p<-ncol(X)
  df<-n-p


  residual_var<- as.numeric((t(residuals) %*% residuals) / df)
  #residual_var<-residual_var[1,1]
  resid_var <- as.numeric((t(residuals) %*% residuals) / df)

  residual_std_e <- sqrt(resid_var)

  residual_std <- residuals / sqrt((1/(nrow(X)-1)) * sum(residuals^2))
  residual_std_sqrt <- sqrt(abs(residual_std))

  #calculating the variance of the regression coefficient
  #beta_var <- residual_var * chol2inv(R)
  #beta_Std_E <- sqrt(diag(beta_var))

  var_r_coeff<-residual_var*solve(t(R)%*%R)
  t_values<-r_coeff/sqrt(diag(var_r_coeff))
  p_values<- pt(-abs(t_values), df)


  #calculating standard error
  sigma2<-sum((y - X%*%r_coeff)^2)/df
  vcov<-sigma2*chol2inv(QR$qr)
  std_error <- sqrt(diag(vcov))

  # catch call
  call <- match.call()

  results <- list(
    "call" = call,
    "regression_coefficient" = r_coeff,
    "fitted_values" = f_values,
    "residuals" = residuals,
    "degree_of_freedom" = df,
    "residual_variance" = residual_var,
    "t_values" = t_values,
    "p_values" = p_values,
    "formula" = formula,
    "Sqrt_std_residuals" = residual_std_sqrt,
    "std_error" = std_error,
    "r_se" = residual_std_e
  )
  class(results) <- "linreg"
  return(results)
}
