# Charger les données####
# Extraire le nom des fichers de chaque groupe
allFiles <- dir('data/raw')

# Tables à fusionner
tabNames <- c('collaboration', 'cour', 'etudiant')

# Nombre de groupes
nbGroupe <- length(grep(tabNames[1], allFiles))

# Charger les données
for(tab in tabNames) {
  # prendre seulement les fichiers de la table spécifique `tab`
  tabFiles <- allFiles[grep(tab, allFiles)]
  
  for(groupe in 1:nbGroupe) {
    # Définir le nom de l'objet dans lequel sauver les données de la table `tab` du groupe `groupe`
    tabName <- paste0(tab, "_", groupe)
    
    # Avant  de charger les données, il faut savoir quel est le séparateur utilisé car
    # il y a des données séparées par "," alors que d'autres le sont par ";"
    ficher <- paste0('data/raw/', tabFiles[groupe])
    L <- readLines(ficher, n = 1) # charger première ligne de données
    separateur <- ifelse(grepl(';', L), ';', ',') # S'il y a un ";", le séparateur est donc ";"
    
    # charger les données avec le bon séparateur et donner le nom `tabName`
    assign(tabName, read.csv(ficher, sep = separateur, stringsAsFactors = FALSE, na.strings = c("", "NA")))
    
  }
}

# nettoyer des objets temporaires utilisés dans la boucle
rm(list = c('allFiles', 'tab', 'tabFiles', 'tabName', 'ficher', 'groupe'))

#Format de la base de données (Largeurs et noms)####

collaboration_7 <- collaboration_7[, c(1:4)]

cour_5 <- cour_5[, c(1:3)]
cour_7 <- cour_7[, c(1:3)]

etudiant_3 <- etudiant_3[, c(1:8)]
etudiant_4 <- etudiant_4[, c(1:8)]
etudiant_7 <- etudiant_7[, c(1:8)]
etudiant_9 <- etudiant_9[, c(1:8)]

#noms des colonnes####
colnames(etudiant_4) <- c("prenom_nom", "prenom", "nom", "region_administrative",	"regime_coop", "formation_prealable", "annee_debut", "programme")
colnames(cour_4) <- c("sigle", "optionnel", "credits")
