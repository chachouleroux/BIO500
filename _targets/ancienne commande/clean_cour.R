clean_cour <- function(){
  cour <- rbind(cour_1, cour_2, cour_3, cour_4, cour_5, cour_6, cour_7, cour_8, cour_9, cour_10)
  rm(list = c('cour_1', 'cour_2', 'cour_3', 'cour_4', 'cour_5', 'cour_6', 'cour_7', 'cour_8', 'cour_9', 'cour_10'))
  #Espaces
  for (i in ncol(cour)){
    cour[,i] <- trimws(cour[,i])
  }
  cour <- cour[order(cour$sigle),]
  #VRAI/FAUX
  cour$optionnel <- gsub("TRUE", "VRAI", cour$optionnel)
  cour$optionnel <- gsub("FALSE", "FAUX", cour$optionnel)
  cour <- unique(cour)
  #changement dans la table cour####
  cour<-cour[-c(36),]#sup_ECL406 de trop
  cour<-cour[-c(68),]#sup_INS154 de trop
  cour[75,3]=2#changer nombre de crédits a ZOO302
  cour<-cour[-c(15),]#sup cour BIO400
  
  #Fusionner les dataframe####
  cour <- rbind(cour_1, cour_2, cour_3, cour_4, cour_5, cour_6, cour_7, cour_8, cour_9, cour_10)
  rm(list = c('cour_1', 'cour_2', 'cour_3', 'cour_4', 'cour_5', 'cour_6', 'cour_7', 'cour_8', 'cour_9', 'cour_10'))
}
