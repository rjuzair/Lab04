# Machine Learning in R

Supervised learning case studies written as reproducible R Markdown reports.

| Report | Dataset | Topics |
|---|---|---|
| [k-NN classification](knn-classification) | Optical digit recognition (8×8 images, 10 classes) | k-nearest neighbours, train/validation/test split, confusion matrices, choosing *k*, cross-entropy |
| [Linear & ridge regression](linear-and-ridge-regression) | Parkinson's telemonitoring voice measurements | Linear regression, ridge regularisation implemented with `optim` (BFGS), effective degrees of freedom, choosing λ |
| [Logistic regression & basis expansion](logistic-regression) | Pima Indians diabetes | Logistic regression, decision boundaries, classification thresholds, polynomial basis functions |

Datasets are in [`data/`](data). Knit any report from its own folder:
```r
rmarkdown::render("logistic-regression/logistic_regression.Rmd")
```
