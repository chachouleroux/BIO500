requête2 <- function () {
  nlien.paire_sql<-"
SELECT etudiant1,etudiant2,
count(etudiant2) AS nlien
FROM collaboration
GROUP BY etudiant1,etudiant2
ORDER BY nlien DESC;"
  nlien.paire<-dbGetQuery(con,nlien.paire_sql) 
  nlien.paire
  write.csv(nlien.paire,file = "nb_lien_paire.csv")
  
}