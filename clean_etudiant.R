clean_etudiant <- function(){
  #Fusionner les dataframe#### 
   etudiant <- rbind(etudiant_1, etudiant_2, etudiant_3, etudiant_4, etudiant_5, etudiant_6, etudiant_7, etudiant_8, etudiant_9, etudiant_10)
   #suppression des espaces (trailing et leading)####
   #et remplacement des traits d'union
   rm(list = c('etudiant_1', 'etudiant_2', 'etudiant_3', 'etudiant_4', 'etudiant_5', 'etudiant_6', 'etudiant_7', 'etudiant_8', 'etudiant_9', 'etudiant_10'))
    for (i in ncol(etudiant)){
    etudiant[,i] <- trimws(etudiant[,i])}
   #Ordre alphabetique####
    etudiant <- etudiant[order(etudiant$prenom_nom),]
    #correction####
    #traits d'union
    etudiant$prenom_nom <- gsub("-", "_", etudiant$prenom_nom)
    etudiant$prenom <- gsub("-", "_", etudiant$prenom)
    etudiant$nom <- gsub("-", "_", etudiant$nom)
    etudiant$region_administrative <- gsub("-", "_", etudiant$region_administrative)
    #VRAI/FAUX
    etudiant$regime_coop <- gsub("TRUE", "VRAI", etudiant$regime_coop)
    etudiant$regime_coop <- gsub("FALSE", "FAUX", etudiant$regime_coop)
    #Unique####
    etudiant <- unique(etudiant)
    ######retirer le nom mal écrit#####
    etudiant<-etudiant[-c(8),]#amelie_harbeck_bastien
    etudiant<-etudiant[-c(10),]#amelie_pelletier
    etudiant<-etudiant[-c(13),]#ariane_barrette
    etudiant<-etudiant[-c(19),]#beatrice_dupuis
    etudiant<-etudiant[-c(20),]#benjamin_auclair
    etudiant<-etudiant[-c(28),]#camille_gagnon
    etudiant<-etudiant[-c(30),]#cassandra_godin
    etudiant<-etudiant[-c(30),]#cassandra_godin
    etudiant<-etudiant[-c(35),]#charles_ferland
    etudiant<-etudiant[-c(42),]#daphnee_longworth
    etudiant<-etudiant[-c(42),]#daphnee_longworth
    etudiant<-etudiant[-c(43),]#denya_berard
    etudiant<-etudiant[-c(59),]#felix_olivier_dufour
    etudiant<-etudiant[-c(62),]#francis_boily
    etudiant<-etudiant[-c(65),]#frederic_laberge
    etudiant<-etudiant[-c(68),]#gabrielle_beauchesne
    etudiant<-etudiant[-c(72),]#guillaume_tardif
    etudiant<-etudiant[-c(75),]#hugo_morin_brassard
    etudiant<-etudiant[-c(81),]#jonathan_rondeau_leclaire
    etudiant<-etudiant[-c(82),]#juliette_larrivee
    etudiant<-etudiant[-c(84),]#justine_labelle
    etudiant<-etudiant[-c(88),]#kayla_trempe_kay
    etudiant<-etudiant[-c(93),]#laurianne_plante
    etudiant<-etudiant[-c(94),]#laurie_anne_cournoyer
    etudiant<-etudiant[-c(105),]#magalie_bosse
    etudiant<-etudiant[-c(108),]#marie_christine_arseneau
    etudiant<-etudiant[-c(109),]#marie_claude_mayotte
    etudiant<-etudiant[-c(110),]#marie_eve_gagne
    etudiant<-etudiant[-c(111),]#marilou_cournoyer
    etudiant<-etudiant[-c(116),]#mia_carriere
    etudiant<-etudiant[-c(116),]#mia_carriere
    etudiant<-etudiant[-c(120),]#naomie_aubut
    etudiant<-etudiant[-c(122),]#nicolas_beaudoin
    etudiant<-etudiant[-c(126),]#penelope_robert
    etudiant<-etudiant[-c(126),]#philippe_barrette
    etudiant<-etudiant[-c(127),]#philippe_bourassa
    etudiant<-etudiant[-c(129),]#philippe_leonard_dufour
    etudiant<-etudiant[-c(132),]#rosalie_gagnon
    etudiant<-etudiant[-c(132),]#rosalie_gagnon
    etudiant<-etudiant[-c(132),]#roxanne_bernier
    etudiant<-etudiant[-c(135),]#sabrina_leclercq
    etudiant<-etudiant[-c(136),]#samuel_beaulac
    etudiant<-etudiant[-c(137),]#samuel_fortin
    etudiant<-etudiant[-c(142),]#simon_bourgeois
    etudiant<-etudiant[-c(147),]#thomas_raymond
    etudiant<-etudiant[-c(154),]#yanick_sageau
    etudiant<-etudiant[-c(154),]#yanick_sageau
    etudiant<-etudiant[-c(155),]#yuriko_archambault
    #correction nom####
    etudiant$prenom_nom<-gsub("eve<a0>_dandonneau","eve_dandonneau",etudiant$prenom_nom)
}