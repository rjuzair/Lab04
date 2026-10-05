# knapsack

Three solvers for the **0/1 knapsack problem**, compared for speed and accuracy.

| Function | Approach | Complexity |
|---|---|---|
| `brute_force_knapsack(x, W, parallel = FALSE)` | Enumerates every subset (optionally across CPU cores with `parallel`) | O(2ⁿ) |
| `dynamic_knapsack(x, W)` | Dynamic programming over items × capacity | O(nW) |
| `greedy_knapsack(x, W)` | Greedy by value/weight ratio (fast approximation) | O(n log n) |

```r
remotes::install_github("rjuzair/statistical-computing-with-r", subdir = "packages/knapsack-solvers")
library(knapsack)

set.seed(42)
items <- data.frame(w = sample(1:4000, 2000, replace = TRUE), v = runif(2000, 0, 10000))
brute_force_knapsack(items[1:8, ], W = 3500)
dynamic_knapsack(items[1:8, ], W = 3500)
greedy_knapsack(items[1:800, ], W = 3500)
```
The vignette profiles each solver with `profvis` and measures the speed-up from parallelising the brute-force search.
