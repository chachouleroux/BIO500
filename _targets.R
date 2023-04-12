setwd()
library(targets)
library(tarchetypes)
library(rmarkdown)


tar_option_set(packages = c("RSQLite","igraph","dplyr"))

source("donnees.r")
source("clean_collab.r")
source("clean_cour.r")
source("clean_etudiant.r")
source("conSQL.r")
source("createSQL.r")
source("requete_SQL_1.r")
source("requete_SQL_2.r")
source("connectance.r")


list(
  tar_target(data,
             donnees.r("~/BAC/session 4/BIO500/travail/BIO500")#lien
             ),
tar_target(collaboration,
           clean_collab()
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
           createSQL()
           ),
tar_target(nd_collab,
           requete_SQL_1()
           ),
tar_target(reseau_collab,
           requete_SQL_2()
           ),
tar_target(post_traitement,
           connectance()
           ),
tar_target(table_nbcollab,
           read.csv("~/BAC/session 4/BIO500/travail/BIO500")#lien
           ),
tar_target(table_reseaucollab,
           read.csv("~/BAC/session 4/BIO500/travail/BIO500")#lien
             )          
)
  
