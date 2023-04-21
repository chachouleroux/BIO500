graph_bacon <- function (g){
  # Calculer le bacon number des etudiants par rapport a magalie
  pdf(file = "figures/bacon.pdf")
  par(mar=c(5,5,5,5))
  distance=distances(g)
  bacon_number=as.matrix(distance[,2])
  bacon_number=bacon_number[bacon_number!=0]
  b_number <- hist(bacon_number, xlab="Nombre de Bacon", ylab="Frequence", breaks = c(0.5,1.5,2.5,3.5,4.5), main=NULL)
}
