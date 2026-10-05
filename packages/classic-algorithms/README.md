# classicalgorithms

R implementations of two classic algorithms, with unit tests.

| Function | Algorithm |
|---|---|
| `euclidean(a, b)` | [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm) — greatest common divisor |
| `dijkstra(graph, init_node)` | [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) — shortest distance from a start node to every node in a weighted graph |

```r
remotes::install_github("rjuzair/statistical-computing-with-r", subdir = "packages/classic-algorithms")
library(classicalgorithms)

euclidean(123612, 13892347912)   # 4
dijkstra(wiki_graph, 1)          # 0 7 9 20 20 11
```
`wiki_graph` is the example graph from Wikipedia, stored as an edge list (`v1`, `v2`, `w`).
