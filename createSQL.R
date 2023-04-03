createSQL <- function(){
  #creation table SQL####
  dbSendQuery(con,etudiant_sql <- "
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
);")
  dbSendQuery(con, etudiant_sql)
  dbListTables(con)
  
  dbSendQuery(con, collaborations_sql <- '
CREATE TABLE collaboration_tb(
    etudiant1     VARCHAR(40),
    etudiant2     VARCHAR(40),
    sigle   VARCHAR(10),
    session  VARCHAR(10),
    PRIMARY KEY (etudiant1, etudiant2, sigle, session),
    FOREIGN KEY (etudiant1) REFERENCES etudiant(prenom_nom),
    FOREIGN KEY (etudiant2) REFERENCES etudiant(prenom_nom),
    FOREIGN KEY (sigle) REFERENCES cours(sigle)
); ')
  dbSendQuery(con, collaborations_sql)
  dbListTables(con)
  
  dbSendQuery(con,cours_sql <- '
CREATE TABLE cours_tb (
  sigle   VARCHAR(20),
  optionnel       BOLEAN NOT NULL,
  credit     VARCHAR(10),
  PRIMARY KEY (sigle)
); ')
  dbSendQuery(con, cours_sql)
  dbListTables(con)
}