#' @title Dijikstra
#'
#' @param graph a graph as data frame.
#' @param init_node the initial node.
#' @description The \code{Dijkstra} algorithm calculates the shortest path of a graph with an initial node.
#' @return The shortest path of \code{graph} with the initial node \code{init_node}
#' @references https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
#' @export
#' @examples
#' dijkstra(wiki_graph, 1)
#' dijkstra(wiki_graph, 3)



dijkstra <- function(graph, init_node) {

  stopifnot( is.data.frame(graph) == TRUE && all(c("v1", "v2", "w") %in% colnames(graph)) == TRUE &&
               length(init_node) == 1 && is.numeric(init_node) == TRUE &&
               (init_node %in% graph$v1) == TRUE )

  # initial values
  Q <- 1:max(graph[, 1])

  distance <- c()

  for (i in 1:max(graph[, 1])) {
    distance[i] <- Inf
  }

  distance[init_node] <- 0

  node_u <- init_node
  u <- which(graph$v1==node_u)

  graph$cost <- Inf
  graph$cost <- replace(graph$cost, u, graph$w[u])

  while (length(Q) > 1) {

    # calculate distance/cost
    distance[graph$v2[u]] <- pmin(graph$cost[u], distance[graph$v2[u]])

    # remove node from set Q
    Q <- Q[!Q %in% node_u]

    # update node as min value of cost column
    node_u <- graph$v2[(which.min(graph$cost))]
    u <- which(graph$v1==node_u)

    # update distance/cost
    graph$cost <- replace(graph$cost, u, graph$w[u]+min(distance[Q]))

    # remove used row & update row and node names
    graph <- graph[-which.min(graph$cost),]
    rownames(graph) <- 1:nrow(graph)
    u <- which(graph$v1==node_u)

  }

  return(distance)

}


