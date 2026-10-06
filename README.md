# Statistical Computing with R

R packages and machine-learning reports from the MSc in Statistics and Machine Learning at **Linköping University** (Advanced R Programming and Machine Learning courses).

![R](https://img.shields.io/badge/R-276DC3?logo=r&logoColor=white)
[![R-CMD-check](https://github.com/rjuzair/Lab04/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/rjuzair/Lab04/actions/workflows/R-CMD-check.yml)
![Shiny](https://img.shields.io/badge/Shiny-blue?logo=rstudio&logoColor=white)

## R packages
Each package is a self-contained, documented R package with a `testthat` test suite.

| Package | What it does | Highlights |
|---|---|---|
| [**linregqr**](packages/linreg-qr) | Linear regression via QR decomposition | S3 class with `print`, `summary`, `coef`, `resid`, `pred`, `plot`; validated against `lm()` |
| [**knapsack**](packages/knapsack-solvers) | 0/1 knapsack solvers | Brute force (parallelised), dynamic programming and greedy; profiling with `profvis` |
| [**swedishairquality**](packages/swedish-air-quality) | PM10 air quality for six Swedish cities | REST API client (`httr`, `jsonlite`), offline simulated sample data, Shiny dashboard |
| [**classicalgorithms**](packages/classic-algorithms) | Euclidean GCD and Dijkstra shortest paths | Input validation, bundled example data |

Install any package straight from GitHub:
```r
remotes::install_github("rjuzair/statistical-computing-with-r", subdir = "packages/linreg-qr")
```

## Machine learning
| Report | Topics |
|---|---|
| [k-NN classification](machine-learning/knn-classification) | Handwritten digit recognition, model selection for *k*, cross-entropy |
| [Linear & ridge regression](machine-learning/linear-and-ridge-regression) | Parkinson's disease voice data, ridge regularisation from scratch and λ selection |
| [Logistic regression & basis expansion](machine-learning/logistic-regression) | Diabetes prediction, decision boundaries, threshold tuning |

## Development
```r
# run a package's tests
testthat::test_local("packages/linreg-qr")
```
Every push runs `R CMD check` on all four packages with GitHub Actions.

## Authors
Raja Uzair Saeed and Daniel Persson (packages were developed as pair-programming assignments).
