setwd()
library(targets)
library(tarchetypes)
library(rmarkdown)
library(tarchet)

tar_option_set(packages = c("RSQLite","igraph","dplyr"))

source("donnees.r")

list(
  tar_target(data,
             donnees.r()#lien
             ),
  tar_target(coll_raw,
                datacoll()
),
tar_target(collaboration,
           clean_collaboration(coll_raw)
           ),
tar_target(cour_raw,
           data_cours()
           ),
tar_target(cour, 
           clean_cour(cour_raw)
           ),
tar_target(etudiant_raw,
           data_etudiant()
           ),
tar_target(etudiant,
           clean_etudiant(etudiant_raw)
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
tar_target(table_nbcollab,
           read.csv()#lien
           ),
tar_target(table_reseaucollab,
           read.csv()#lien
             ),           
)
  
