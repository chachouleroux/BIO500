matrice_collab <- function(data) {
  con <- dbConnect(SQLite(), dbname="~/BAC/session 4/BIO500/travail/BIO500/projet1.db")
  matrice_sql.coll<- "
  SELECT etudiant1, etudiant2 
  FROM collaboration
  ;"
  data_matrice<- dbGetQuery(con, matrice_sql.coll)
  adjacence_coll <- table(data_matrice)
}
