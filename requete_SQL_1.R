requete1 <- function() {
  nlien_sql<-"
SELECT etudiant1,
count(etudiant2) AS nlien
FROM collaboration
GROUP BY etudiant1
ORDER BY nlien DESC;"
  nb_lien<-dbGetQuery(con,nlien_sql)
  nb_lien
  write.csv(nb_lien,file = "nb_lien.csv")
}