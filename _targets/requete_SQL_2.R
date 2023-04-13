requête2 <- function () {       # Extraction de l'information sur le nombre de liens par paire d'étudiant. 
  nlien.paire_sql<-"
SELECT etudiant1,etudiant2,     # Sélectionne les colonnes 'etudiant1' et 'etudiant2'.
count(etudiant2) AS nlien       # Renomme la colonne 'etudiant2' comme étant 'nlien'.
FROM collaboration              # À partir de la table 'collaboration'.
GROUP BY etudiant1,etudiant2    # Données agrégées sur les champs 'etudiant1' et 'etudiant2'.
ORDER BY nlien DESC;"           # Ordonne par ordre décroissant.
  nlien.paire<-dbGetQuery(con,nlien.paire_sql) 
  nlien.paire
  write.csv(nlien.paire,file = "nb_lien_paire.csv") # Sauvegarde de la requête SQL 2.
  
}