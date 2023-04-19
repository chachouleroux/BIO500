
r<-nrow(nlien.paire)
matrice_interact <- matrix(0, nr = r, nc = r)
noms<-unique(nlien.paire$etudiant1)
colnames(matrice_interact)=(nlien.paire$etudiant1)
rownames(matrice_interact)=(nlien.paire$etudiant2)

#
for(et_1 in nlien.paire$etudiant1){
  sub_data<- subset(nlien.paire,etudiant1==et_1)
  et_2=sub.data$etudiant2
  matrice_interact[et_2,et_1]<-1
  print(sub_data)
}
#
network <- graph_from_adjacency_matrix(matrice_interact)
#
figure_un_f <- function(network,matrice_interact) {
  pdf(file = "travail/BIO500/reseau.pdf")
  #Réduire les marges 
  par(mar=c(0.1,0.1,2,0.1))
  # Calculer le degré 
  deg=apply(matrice_interact, 2, sum) + apply(matrice_interact, 1, sum) 
  # Le rang pour chaque noeud
  rk=rank(deg)
  # Faire un code de couleur
  col.vec=rainbow(nrow(matrice_interact))
  # Attribuer aux noeuds la couleur
  V(network)$color = col.vec[rk]
  # Faire un code de taille
  col.vec.taille=seq(2, 10, length.out = nrow(matrice_interact))
  # Attribuer aux noeuds la couleur
  V(network)$size = col.vec.taille[rk]
  # Refaire la figure
  plot(network, vertex.label=NA, edge.arrow.mode = 0,
       vertex.frame.color = NA)
  return()
}
