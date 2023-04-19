#collaboration
clean_collaboration <- function(){
  
  #format
  collaboration_7 <- collaboration_7[, c(1:4)]
  
  #fusion
  collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)
  rm(list = c('collaboration_1', 'collaboration_2', 'collaboration_3', 'collaboration_4', 'collaboration_5', 'collaboration_6', 'collaboration_7', 'collaboration_8', 'collaboration_9', 'collaboration_10'))
  
  #ordre alphabétique
  collaboration <- collaboration[order(collaboration$etudiant1),]
  
  #Remplacement espaces
  for (i in ncol(collaboration)){
    collaboration[,i] <- trimws(collaboration[,i])
  }
  
  #traits d'union
  collaboration$etudiant1 <- gsub("-", "_", collaboration$etudiant1) 
  collaboration$etudiant2 <- gsub("-", "_", collaboration$etudiant2)
  
  #gestion des doublons
  collaboration <- unique(collaboration)
  
  #correction des noms mal écris
  collaboration$etudiant1<-gsub("eve<a0>_dandonneau","eve_dandonneau",collaboration$etudiant1)
  collaboration$etudiant2<-gsub("eve<a0>_dandonneau","eve_dandonneau",collaboration$etudiant2)
  
  ##changement dans la table collaboration####
  collaboration[2578,3]="BOT400"
  collaboration[2916,3]="BOT400"
  collaboration[991,4]="E2022"#changement de E2023 en E2022
  collaboration[2593,4]="E2022"#changement de E2023 en E2022
  collaboration[2594,4]="E2022"#changement de E2023 en E2022
  collaboration[2648,4]="E2022"#changement de E2023 en E2022
  collaboration<-collaboration[-c(2504),]#sup cas avec des NA pour les cours et annee
  collaboration<-collaboration[-c(2504),]#sup cas avec des NA pour les cours et annee
  
  #Fusionner les dataframe####
collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)
rm(list = c('collaboration_1', 'collaboration_2', 'collaboration_3', 'collaboration_4', 'collaboration_5', 'collaboration_6', 'collaboration_7', 'collaboration_8', 'collaboration_9', 'collaboration_10'))
}
