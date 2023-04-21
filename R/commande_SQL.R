#commande SQL####

commande_SQL<-function(collaboration, etudiant, cour){ 
con <- dbConnect(SQLite(), dbname ="projet1.db")

#table etudiant

etudiant_sql <- "
CREATE TABLE etudiant_tb(
    prenom_nom VARCHAR (40),
    prenom VARCHAR(40),
    nom VARCHAR(40),
    region_administrative VARCHAR(40),
    regime_coop BOLEAN,	
    formation_prealable VARCHAR(40),
    annee_debut  VARCHAR(20),
    programme VARCHAR(20),	
    PRIMARY KEY (prenom_nom)
);"
dbSendQuery(con, etudiant_sql)
dbWriteTable(con, append = TRUE, name = "etudiant", value = etudiant, row.names = FALSE)


#table collaboration
collaborations_sql <- "
CREATE TABLE collaboration_tb(
    etudiant1     VARCHAR(40),
    etudiant2     VARCHAR(40),
    sigle   VARCHAR(10),
    session  VARCHAR(10),
    PRIMARY KEY (etudiant1, etudiant2, sigle, session),
    FOREIGN KEY (etudiant1) REFERENCES etudiant(prenom_nom),
    FOREIGN KEY (etudiant2) REFERENCES etudiant(prenom_nom),
    FOREIGN KEY (sigle) REFERENCES cour(sigle)
); "
dbSendQuery(con, collaborations_sql)


#table cour
cour_sql <- "
CREATE TABLE cour_tb (
  sigle   VARCHAR(20),
  optionnel       BOLEAN NOT NULL,
  credit     VARCHAR(10),
  PRIMARY KEY (sigle)
); "
dbSendQuery(con, cour_sql)

#####
dbWriteTable(con, append = TRUE, name = "etudiant", value = etudiant, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "collaboration", value = collaboration, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cour", value = cour, row.names = FALSE)


#requeteSQL####
#nombre de lien par etudiant
nlien_sql<-"
SELECT count(etudiant1) AS nb_collab, etudiant1
FROM collaborations
GROUP BY etudiant1
ORDER BY nb_collab DESC
;"
nlien<-dbGetQuery(con,nlien_sql)
head(nlien)

#nombre de lien par paire d'etudiant
nlien.paire_sql<-"
SELECT etudiant1, etudiant2, COUNT(*) AS nb_collab
FROM collaborations
GROUP BY etudiant1, etudiant2
ORDER BY nb_collab DESC
;"
nlien.paire<-dbGetQuery(con,nlien.paire_sql) 
head(nlien.paire)

#enregistrer les requetes en CSV
write.csv(nlien, 'data/nlien.csv', row.names = FALSE)
write.csv(nlien.paire,  'data/nlien.paire.csv', row.names = FALSE)

#connectance
netudiant<-nrow(etudiant)
n.lien<-nrow(collaboration)
connectance<-n.lien/netudiant
#moyenne et variance 
moy.lien <- mean(nlien.paire$nb_collab)
moy.lien
var.lien<-var(nlien.paire$nb_collab)
var.lien

dbSendQuery(con, "DROP TABLE etudiant_tb;")
dbSendQuery(con, "DROP TABLE collaboration_tb;")
dbSendQuery(con, "DROP TABLE cour_tb;")
#deconnection
dbDisconnect(con)
}
