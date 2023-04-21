#matrice adjacence####
#creattion de la matrice de reseau

r<-nrow(etudiant)
matrice_interact <- matrix(0, nr = r, nc = r)
noms<-etudiant[, 1]
colnames(matrice_interact)<-noms#nom de la colonne
rownames(matrice_interact)<-noms#nom de la ligne

#insertion des interactions entre etudiant (1=interaction et 0=pas d'interaction)
n<-nrow(nlien.paire)
for (i in 1:n){
  if (nlien.paire[i,3]>0) {
    matrice_interact[nlien.paire[i,1],nlien.paire[i,2]]<-1 }
}
#graphique du reseau ####
g <- graph.adjacency(matrice_interact)
deg <- apply(matrice_interact, 2, sum) + apply(matrice_interact, 1, sum)
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
savePlotAsImage("figures/visualisation.png",format ="png", width = 1000, height = 1000)#enregistrer la figure obtenue####





