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
