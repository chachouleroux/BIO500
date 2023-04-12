createSQL <- function(){
  #Création table SQL pour les étudiants.####
  dbSendQuery(con,etudiant_sql <- "
CREATE TABLE etudiant_tb(
    prenom_nom VARCHAR (40),            # Colonne avec caractères composant le prénom et le nom.
    prenom VARCHAR(40),                 # Colonne avec caractères composant le prénom.
    nom VARCHAR(40),                    # Colonne avec caractères composant le nom de famille.
    region_administrative VARCHAR(40),  # Colonne avec caractères composant la région administrative d'origine.
    regime_coop BOLEAN,	                # Colonne vrai ou faux sur la participation au régime COOP.
    formation_prealable VARCHAR(40),    # Colonne avec caractères composant la présence d'une formation préalable (preuniversitaire/technique).
    annee_debut  VARCHAR(20),           # Colonne avec caractères composant l'année de début.
    programme VARCHAR(20),	            # Colonne avec caractères composant le nom du programme.
    PRIMARY KEY (prenom_nom)            # Colonne avec la contrainte de la clé primaire simple.
);")
  dbSendQuery(con, etudiant_sql)
  dbListTables(con)
  
  # Création table SQL pour les collaborations entre étudiants.
  dbSendQuery(con, collaborations_sql <- '                      
CREATE TABLE collaboration_tb(                          
    etudiant1     VARCHAR(40),          # Colonne avec caractères 
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
  
  # Création table SQL pour les différents cours.
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
