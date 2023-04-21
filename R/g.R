#graphique du reseau ####
fonction_g <- function(matrice_interact){
g <- graph.adjacency(matrice_interact)
return(g)
}