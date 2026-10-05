# linregqr

Multiple linear regression implemented from scratch with the **QR decomposition**, wrapped in an S3 class with the familiar `lm()`-style interface. Results are verified against `stats::lm` in the test suite.

```r
remotes::install_github("rjuzair/statistical-computing-with-r", subdir = "packages/linreg-qr")
library(linregqr)

fit <- linreg(Petal.Length ~ Sepal.Width + Sepal.Length, data = iris)
print(fit)      # call and coefficients
summary(fit)    # estimates, standard errors, t-values, p-values, significance stars
coef(fit); resid(fit); pred(fit)
plot(fit)       # Residuals vs Fitted and Scale-Location diagnostics (ggplot2)
```

**How it works:** the design matrix *X* is factorised as *X = QR*; coefficients solve *Rβ = Qᵀy*, and the coefficient covariance is σ̂²(RᵀR)⁻¹.
