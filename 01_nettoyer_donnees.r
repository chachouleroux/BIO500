######################################################
# Script pour nettoyer et assembler les données
# Victor Cameron
# 15 mars 2023
######################################################


######################################################
## Etapes (! ADAPTER)
# 1. Corriger les noms et les irr?gularit? dans les donn?es sur excel 
# 2. Charger tous les donnees provenants du dossier data/raw
# 3. Pour chaque table (etudiant, cours, collaborations):
# 	- Vérifier si les noms de colonnes sont standardisees
# 	- Vérifier si chacune des valeurs pour chaque colonne respecte le formatage
# 	- Réparer les colonnes que ne respectent pas le format (travail manuel ici)
# 	- Autres vérifications dans et entre les groupes
# 	- Fusionner les donnees de chaque groupe en un seul data.frame
# 4. Sauvegarder les données fusionnées de chaque table dans le dossier data/clean
######################################################


#-----------------------------------------------------
# 2. Charger les données
#-----------------------------------------------------

setwd("~/Ecole/uni/H23/methode/projet")

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
    assign(tabName, read.csv(ficher, sep = separateur, stringsAsFactors = FALSE))
    
  }
}

# nettoyer des objets temporaires utilisé dans la boucle
rm(list = c('allFiles', 'tab', 'tabFiles', 'tabName', 'ficher', 'groupe'))


#-----------------------------------------------------
# 3. v?rification
#-----------------------------------------------------

#Format de la base de donnees (Largeurs et noms)

collaboration_7 <- collaboration_7[, c(1:4)]

cour_5 <- cour_5[, c(1:3)]
cour_7 <- cour_7[, c(1:3)]

etudiant_3 <- etudiant_3[, c(1:8)]
etudiant_4 <- etudiant_4[, c(1:8)]
etudiant_7 <- etudiant_7[, c(1:8)]
etudiant_9 <- etudiant_9[, c(1:8)]


#nom des colonnes
colnames(etudiant_4) <- c("prenom_nom", "prenom", "nom", "region_administrative",	"regime_coop", "formation_prealable", "annee_debut", "programme")
colnames(cour_4) <- c("sigle", "optionnel", "credits")

#Fusion des donn?es
  #Fusion des collaborations
    #Fusionner les dataframe
      collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)
    #suppression des espaces
      for (i in ncol(collaboration)){
        collaboration[,i] <- trimws(collaboration[,i])
      }
      collaboration_unique <- unique(collaboration)
      rm(list = c('collaboration_1', 'collaboration_2', 'collaboration_3', 'collaboration_4', 'collaboration_5', 'collaboration_6', 'collaboration_7', 'collaboration_8', 'collaboration_9', 'collaboration_10'))
      collaboration_unique <- collaboration_unique[order(collaboration_unique$etudiant1),]
  
      #Fusion des cours
      cour <- rbind(cour_1, cour_2, cour_3, cour_4, cour_5, cour_6, cour_7, cour_8, cour_9, cour_10)
      for (i in ncol(cour)){
        cour[,i] <- trimws(cour[,i])
      }
      cour_unique <- unique(cour)
      rm(list = c('cour_1', 'cour_2', 'cour_3', 'cour_4', 'cour_5', 'cour_6', 'cour_7', 'cour_8', 'cour_9', 'cour_10'))
      cour_unique <- cour_unique[order(cour_unique$sigle),]
     
       #Fusion des etudiants
      
      #Fusionner les dataframe
      etudiant <- rbind(etudiant_1, etudiant_2, etudiant_3, etudiant_4, etudiant_5, etudiant_6, etudiant_7, etudiant_8, etudiant_9, etudiant_10)
      for (i in ncol(etudiant)){
        etudiant[,i] <- trimws(etudiant[,i])
        
      }
      etudiant_unique <- unique(etudiant)
      rm(list = c('etudiant_1', 'etudiant_2', 'etudiant_3', 'etudiant_4', 'etudiant_5', 'etudiant_6', 'etudiant_7', 'etudiant_8', 'etudiant_9', 'etudiant_10'))
      etudiant_unique <- etudiant_unique[order(etudiant_unique$prenom_nom),]
      
# Format (NA)
      
      