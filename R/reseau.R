graph_reseau <- function(deg, etudiant, g) {
  pdf(file = "figures/reseau.pdf")
  r<-nrow(etudiant)
  # Le rang 
  rk <- rank(deg)
  # Faire un code de couleur
  col.vec <- heat.colors(r)
  # Attribuer aux liens une couleur
  V(g)$color = col.vec[rk]
  #Taille
  col.vec <- seq(1, 5, length.out = r)
  # Attribuer aux liens la taille
  V(g)$size = col.vec[rk]
  
  #afficher le graphique de reseau####
  visualisation <-plot(g,vertex.label = NA, edge.arrow.mode = 0,
                       vertex.frame.color = NA,
                       layout = layout.kamada.kawai(g))
  }





