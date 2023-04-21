


#librarie utiliser

library(targets)
library(tarchetypes)
tar_option_set(packages = c('rstudioapi','dplyr','ggplot2','igraph','RSQLite','rmarkdown'))
## fichier doit obligatoirement s'appeller "_targets.R"
# Scripts R
source("R/nettoyage_donnees.R")
source("R/commande_SQL.R")
source("R/matrice_int.R")
source("R/g.R")
source("R/deg.R")
source("R/reseau.R")

# Pipeline
list(
  tar_target(
    name = donnees_clean, #Cible pour le modèle
    command = nettoyage_donnees() #Exécuter
  ),
  tar_target(
    name = collaboration,
    command = read.csv('data/collaboration_clean.csv')
  ),
  tar_target(
    name = etudiant,
    command = read.csv('data/etudiant_clean.csv')
  ),
  tar_target(
    name = cour,
    command = read.csv('data/cour_clean.csv')
  ),
  tar_target(
    name = commande,
    command = commande_SQL(collaboration,etudiant,cour)
  ),
  tar_target(
    name = nlien,
    command = read.csv('data/nlien.csv')
  ),
  tar_target(
    name = nlien.paire,
    command = read.csv('data/nlien.paire.csv')
  ),
  tar_target(
    name= matrice,
    command = matrice_int(etudiant, nlien.paire)
  ),
  tar_target(
    name= g,
    command = fonction_g(matrice)
  ),
  tar_target(
    name= deg,
    command = fonction_deg(matrice)
  ),
  tar_target(
    name= reseau,
    command = graph_reseau(deg, etudiant, g)
  )
)



