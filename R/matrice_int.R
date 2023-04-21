#matrice adjacence####
#creattion de la matrice de reseau
matrice_int<- function(etudiant,nlien.paire){ 
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
return(matrice_interact)
}
