connectance() <- function () {
  
  netudiant<-nrow(etudiant)
  nlien<-nrow(collaboration)
  connectance<-nlien/netudiant
  
  moy.lien <- mean(nlien.paire$nlien)
  moy.lien
  var.lien<-var(nlien.paire$nlien)
  var.lien
}