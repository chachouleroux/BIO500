
# Charger les données####
# Extraire le nom des fichers de chaque groupe
allFiles <- dir('data/raw')

# Tables à fusioner
tabNames <- c('collaboration', 'cour', 'etudiant')

# Nombre de groupes
nbGroupe <- length(grep(tabNames[1], allFiles))

# Charger les donnees
for(tab in tabNames) {
  # prendre seulement les fichers de la table specifique `tab`
  tabFiles <- allFiles[grep(tab, allFiles)]
  
  for(groupe in 1:nbGroupe) {
    # Definir le nom de l'obj dans lequel sauver les donnees de la table `tab` du groupe `groupe`
    tabName <- paste0(tab, "_", groupe)
    
    # Avant  de charger les données, il faut savoir c'est quoi le séparateur utilisé car
    # il y a eu des données separées par "," et des autres separes par ";"
    ficher <- paste0('data/raw/', tabFiles[groupe])
    L <- readLines(ficher, n = 1) # charger première ligne du donnée
    separateur <- ifelse(grepl(';', L), ';', ',') # S'il y a un ";", separateur est donc ";"
    
    # charger le donnée avec le bon séparateur et donner le nom `tabName`
    assign(tabName, read.csv(ficher, sep = separateur, stringsAsFactors = FALSE, na.strings = c("", "NA")))
    
  }
}

# nettoyer des objets temporaires utilisé dans la boucle
rm(list = c('allFiles', 'tab', 'tabFiles', 'tabName', 'ficher', 'groupe'))




#Format de la base de donnees (Largeurs et noms)####

collaboration_7 <- collaboration_7[, c(1:4)]

cour_5 <- cour_5[, c(1:3)]
cour_7 <- cour_7[, c(1:3)]

etudiant_3 <- etudiant_3[, c(1:8)]
etudiant_4 <- etudiant_4[, c(1:8)]
etudiant_7 <- etudiant_7[, c(1:8)]
etudiant_9 <- etudiant_9[, c(1:8)]


#nom des colonnes####
colnames(etudiant_4) <- c("prenom_nom", "prenom", "nom", "region_administrative",	"regime_coop", "formation_prealable", "annee_debut", "programme")
colnames(cour_4) <- c("sigle", "optionnel", "credits")

#Fusionner les dataframe####
collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)
rm(list = c('collaboration_1', 'collaboration_2', 'collaboration_3', 'collaboration_4', 'collaboration_5', 'collaboration_6', 'collaboration_7', 'collaboration_8', 'collaboration_9', 'collaboration_10'))

cour <- rbind(cour_1, cour_2, cour_3, cour_4, cour_5, cour_6, cour_7, cour_8, cour_9, cour_10)
rm(list = c('cour_1', 'cour_2', 'cour_3', 'cour_4', 'cour_5', 'cour_6', 'cour_7', 'cour_8', 'cour_9', 'cour_10'))
      
etudiant <- rbind(etudiant_1, etudiant_2, etudiant_3, etudiant_4, etudiant_5, etudiant_6, etudiant_7, etudiant_8, etudiant_9, etudiant_10)
rm(list = c('etudiant_1', 'etudiant_2', 'etudiant_3', 'etudiant_4', 'etudiant_5', 'etudiant_6', 'etudiant_7', 'etudiant_8', 'etudiant_9', 'etudiant_10'))
      
#suppression des espaces (trailing et leading)####
#et remplacement des traits d'union
for (i in ncol(collaboration)){
  collaboration[,i] <- trimws(collaboration[,i])
  collaboration[,i] <- gsub('-', '_', collaboration[,i])
}
      
for (i in ncol(cour)){
  cour[,i] <- trimws(cour[,i])
}
      
for (i in ncol(etudiant)){
  etudiant[,i] <- trimws(etudiant[,i])
}
      
#Ordre alphabetique####
collaboration <- collaboration[order(collaboration$etudiant1),]
cour <- cour[order(cour$sigle),]
etudiant <- etudiant[order(etudiant$prenom_nom),]

#correction####
  #traits d'union
  collaboration$etudiant1 <- gsub("-", "_", collaboration$etudiant1) 
  collaboration$etudiant2 <- gsub("-", "_", collaboration$etudiant2)
  
  etudiant$prenom_nom <- gsub("-", "_", etudiant$prenom_nom)
  etudiant$prenom <- gsub("-", "_", etudiant$prenom)
  etudiant$nom <- gsub("-", "_", etudiant$nom)
  etudiant$region_administrative <- gsub("-", "_", etudiant$region_administrative)
  
  #VRAI/FAUX
  cour$optionnel <- gsub("TRUE", "VRAI", cour$optionnel)
  cour$optionnel <- gsub("FALSE", "FAUX", cour$optionnel)
  
  etudiant$regime_coop <- gsub("TRUE", "VRAI", etudiant$regime_coop)
  etudiant$regime_coop <- gsub("FALSE", "FAUX", etudiant$regime_coop)
  
  
#Unique####
collaboration <- unique(collaboration)
cour <- unique(cour)
etudiant <- unique(etudiant)

######retirer le nom mal écrit#####
etudiant<-etudiant[-c(8),]#amelie_harbeck_bastien
etudiant<-etudiant[-c(10),]#amelie_pelletier
etudiant<-etudiant[-c(13),]#ariane_barrette
etudiant<-etudiant[-c(19),]#beatrice_dupuis
etudiant<-etudiant[-c(20),]#benjamin_auclair
etudiant<-etudiant[-c(28),]#camille_gagnon
etudiant<-etudiant[-c(30),]#cassandra_godin
etudiant<-etudiant[-c(30),]#cassandra_godin
etudiant<-etudiant[-c(35),]#charles_ferland
etudiant<-etudiant[-c(42),]#daphnee_longworth
etudiant<-etudiant[-c(42),]#daphnee_longworth
etudiant<-etudiant[-c(43),]#denya_berard
etudiant<-etudiant[-c(59),]#felix_olivier_dufour
etudiant<-etudiant[-c(62),]#francis_boily
etudiant<-etudiant[-c(65),]#frederic_laberge
etudiant<-etudiant[-c(68),]#gabrielle_beauchesne
etudiant<-etudiant[-c(72),]#guillaume_tardif
etudiant<-etudiant[-c(75),]#hugo_morin_brassard
etudiant<-etudiant[-c(81),]#jonathan_rondeau_leclaire
etudiant<-etudiant[-c(82),]#juliette_larrivee
etudiant<-etudiant[-c(84),]#justine_labelle
etudiant<-etudiant[-c(88),]#kayla_trempe_kay
etudiant<-etudiant[-c(93),]#laurianne_plante
etudiant<-etudiant[-c(94),]#laurie_anne_cournoyer
etudiant<-etudiant[-c(105),]#magalie_bosse
etudiant<-etudiant[-c(108),]#marie_christine_arseneau
etudiant<-etudiant[-c(109),]#marie_claude_mayotte
etudiant<-etudiant[-c(110),]#marie_eve_gagne
etudiant<-etudiant[-c(111),]#marilou_cournoyer
etudiant<-etudiant[-c(116),]#mia_carriere
etudiant<-etudiant[-c(116),]#mia_carriere
etudiant<-etudiant[-c(120),]#naomie_aubut
etudiant<-etudiant[-c(122),]#nicolas_beaudoin
etudiant<-etudiant[-c(126),]#penelope_robert
etudiant<-etudiant[-c(126),]#philippe_barrette
etudiant<-etudiant[-c(127),]#philippe_bourassa
etudiant<-etudiant[-c(129),]#philippe_leonard_dufour
etudiant<-etudiant[-c(132),]#rosalie_gagnon
etudiant<-etudiant[-c(132),]#rosalie_gagnon
etudiant<-etudiant[-c(132),]#roxanne_bernier
etudiant<-etudiant[-c(135),]#sabrina_leclercq
etudiant<-etudiant[-c(136),]#samuel_beaulac
etudiant<-etudiant[-c(137),]#samuel_fortin
etudiant<-etudiant[-c(142),]#simon_bourgeois
etudiant<-etudiant[-c(147),]#thomas_raymond
etudiant<-etudiant[-c(154),]#yanick_sageau
etudiant<-etudiant[-c(154),]#yanick_sageau
etudiant<-etudiant[-c(155),]#yuriko_archambault

#correction nom####
etudiant$prenom_nom<-gsub("eve<a0>_dandonneau","eve_dandonneau",etudiant$prenom_nom)
collaboration$etudiant1<-gsub("eve<a0>_dandonneau","eve_dandonneau",collaboration$etudiant1)
collaboration$etudiant2<-gsub("eve<a0>_dandonneau","eve_dandonneau",collaboration$etudiant2)
#changement dans la table cour####
cour<-cour[-c(36),]#sup_ECL406 de trop
cour<-cour[-c(68),]#sup_INS154 de trop
cour[75,3]=2#changer nombre de crédits a ZOO302
cour<-cour[-c(15),]#sup cour BIO400
#changement dans la table collaboration####
collaboration[2578,3]="BOT400"
collaboration[2916,3]="BOT400"
collaboration[991,4]="E2022"#changement de E2023 en E2022
collaboration[2593,4]="E2022"#changement de E2023 en E2022
collaboration[2594,4]="E2022"#changement de E2023 en E2022
collaboration[2648,4]="E2022"#changement de E2023 en E2022
collaboration<-collaboration[-c(2504),]#sup cas avec des NA pour les cours et annee
collaboration<-collaboration[-c(2504),]#sup cas avec des NA pour les cours et annee


#SQL####
library(RSQLite)
con <- dbConnect(SQLite(), dbname="~/BAC/session 4/BIO500/travail/BIO500/projet1.db")
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

#####
dbWriteTable(con, append = TRUE, name = "etudiant", value = etudiant, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "collaboration", value = collaboration, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cour", value = cour, row.names = FALSE)
#requeteSQL####
nlien_sql<-"
SELECT etudiant1,
count(etudiant2) AS nlien
FROM collaboration
GROUP BY etudiant1
ORDER BY nlien DESC;"
nb_lien<-dbGetQuery(con,nlien_sql)
nb_lien
write.csv(nb_lien,file = "nb_lien.csv")
#
nlien.paire_sql<-"
SELECT etudiant1,etudiant2,
count(etudiant2) AS nlien
FROM collaboration
GROUP BY etudiant1,etudiant2
ORDER BY nlien DESC;"
nlien.paire<-dbGetQuery(con,nlien.paire_sql) 
nlien.paire
write.csv(nlien.paire,file = "nb_lien_paire.csv")
