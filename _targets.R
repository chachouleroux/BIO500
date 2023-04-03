setwd()
library(targets)
library(tarchetypes)
library(rmarkdown)


tar_option_set(packages = c("RSQLite","igraph","dplyr"))

source("donnees.r")

list(
  tar_target(data,
             donnees.r()#lien
             ),
tar_target(collaboration,
           clean_collaboration()
           ),
tar_target(cour, 
           clean_cour()
           ),
tar_target(etudiant,
           clean_etudiant()
           ),
tar_target(connectionSQL,
           conSQL()
           ),
tar_target(SQL,
           createSQL(etudiant,collaboration,cour,connectionSQL)
           ),
tar_target(nd_collab,
           requete1()
           ),
tar_target(reseau_collab,
           requete2()
           ),
tar_target(post_traitement,
           connectance()
           ),
tar_target(table_nbcollab,
           read.csv()#lien
           ),
tar_target(table_reseaucollab,
           read.csv()#lien
             ),           
)
  
