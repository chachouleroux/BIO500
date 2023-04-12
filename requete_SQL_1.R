requete1 <- function() {    # Extraction de l'information sur les collaborations.
  nlien_sql<-"
SELECT etudiant1,           # Sélectionne la colonne etudiant1.
count(etudiant2) AS nlien   # Renomme la colonne etudiant2 comme était nlien.
FROM collaboration          # À partir de la table collaboration.
GROUP BY etudiant1          # Données agrégées sur le champ etudiant1.
ORDER BY nlien DESC;"       # Tri des données en ordre décroissant.
  nb_lien<-dbGetQuery(con,nlien_sql)
  nb_lien
  write.csv(nb_lien,file = "nb_lien.csv") # Sauvegarde de la requête 1.
}
