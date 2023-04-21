graph_centralite <- function(g, nlien) {
  #propriete du reseau####
  # Évalue la présence communautés dans le graphe
  wtc = walktrap.community(g)
  #distance entre les noeuds
  distances(g)
  #centralité des personnes####
  centralite <- eigen_centrality(g)$vector
  #production d'un graphique avec la centralité
  par(mar=c(5,5,5,5))
  centralite=eigen_centrality(g)$vector 
  nombre_de_liens=nlien[,1]
  ncollab_centralite <-plot(nombre_de_liens,centralite,pch=20, xlab = "Nombre de liens", ylab= "Centralite")
  cor.test(nombre_de_liens,centralite)
  return(ncollab_centralite)
}
