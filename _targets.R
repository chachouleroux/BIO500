setwd()

## fichier doit obligatoirement s'appeller "_targets.R"
# Scripts R
source("R/nettoyage_donnees.R")
source("R/commande_SQL.R")

#librarie utiliser
library(rmarkdown)
library(RSQLite)
library(targets)
library(tarchetypes)
library(igraph)
library(ggplot2)
library(dplyr)
library(rstudioapi)

tar_option_set(packages = c("rmarkdown","targets","tarchetypes","ggplot2","RSQLite","igraph","dplyr"))

# Pipeline
list(
  tar_target(
    name = donnees,
    command = read_data("./BIO500/_targets/nettoyage_donnees.R"),
    format = "file"
  ), 
  tar_target(
    name = file_paths, #Cible
    command = list.files(donnees, full.names = TRUE) # Liste les fichers dans le dossier
  ),
  tar_target(
    name = donnees_clean, #Cible pour le modèle
    command = nettoyage_donnees() #Exécuter
  ),
  tar_target(
    name = commande,
    command = commande_SQL()
  ),
  tar_target(
    name = table_nbcollab,
    command = read.csv('data/nlien.csv', row.names = FALSE)
  ),
  tar_target(
    name = table_reseaucollab,
    command = read.csv('data/nlien.paire.csv', row.names = FALSE)
  ),
  tar_target(
    name = rapport_rmd,
    command = render("Rapport/Rapport_final.Rmd")
  )
)

