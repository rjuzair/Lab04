#' Graph for Dijkstra's algorithm.
#'
#' The example weighted graph from the Wikipedia article on Dijkstra's
#' algorithm, stored as an edge list.
#'
#' @docType data
#'
#' @usage data(wiki_graph)
#'
#' @format A data frame for a graph of 6 nodes and the distance/weight between them:
#' \describe{
#'   \item{v1}{vertices 1-6}
#'   \item{v2}{vertices 1-6}
#'   \item{w}{weight or distance for all vertices}
#'   }
#' @source https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
#' @examples
#' data(wiki_graph)
"wiki_graph"
