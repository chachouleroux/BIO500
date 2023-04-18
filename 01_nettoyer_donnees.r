
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

#changer nom de colonnes
colnames(etudiant_4) <- c("prenom_nom", "prenom", "nom", "region_administrative", "regime_coop", "formation_prealable", "annee_debut", "programme")
colnames(cour_4)[which(colnames(cour_4)=="?..sigle")]<-"sigle"

#changer les formats des colonnes
collaboration_7 <- collaboration_7[,-c(5:9)]

cour_5 <- cour_5[,-4]
cour_7 <- cour_7[,-c(4:9)]

etudiant_3 <- etudiant_3[,-9]
etudiant_4 <- etudiant_4[,-9]
etudiant_7 <- etudiant_7[,-9]
etudiant_9 <- etudiant_9[,-9]

#Fusionner les dataframe et supprimer les base de données initiale
collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)
rm(list = c('collaboration_1', 'collaboration_2', 'collaboration_3', 'collaboration_4', 'collaboration_5', 'collaboration_6', 'collaboration_7', 'collaboration_8', 'collaboration_9', 'collaboration_10'))

cour <- rbind(cour_1, cour_2, cour_3, cour_4, cour_5, cour_6, cour_7, cour_8, cour_9, cour_10)
rm(list = c('cour_1', 'cour_2', 'cour_3', 'cour_4', 'cour_5', 'cour_6', 'cour_7', 'cour_8', 'cour_9', 'cour_10'))
      
etudiant <- rbind(etudiant_1, etudiant_2, etudiant_3, etudiant_4, etudiant_5, etudiant_6, etudiant_7, etudiant_8, etudiant_9, etudiant_10)
rm(list = c('etudiant_1', 'etudiant_2', 'etudiant_3', 'etudiant_4', 'etudiant_5', 'etudiant_6', 'etudiant_7', 'etudiant_8', 'etudiant_9', 'etudiant_10'))
    
#enlever les lignes vides
collaboration <- subset(collaboration, etudiant1 !="")
etudiant <- subset(etudiant, prenom_nom !="")
cour <- subset(cour, sigle !="")

#correction des vrai ou faux
cour$optionnel<- ifelse(cour$optionnel== "VRAI", "TRUE", cour$optionnel)
cour$optionnel<- ifelse(cour$optionnel== "FAUX", "FALSE", cour$optionnel)

etudiant$regime_coop <- ifelse(etudiant$regime_coop== "FAUX", "FALSE", etudiant$regime_coop)
etudiant$regime_coop <- ifelse(etudiant$regime_coop== "VRAI", "TRUE", etudiant$regime_coop)

#retirer les lignes avec des cases vides
unique(collaboration$session)
collaboration <- subset(collaboration, session !="")

#enlever les traits d'union
collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("-", "_", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("-", "_", x) }))

cour <- data.frame(lapply(cour, function(x){
  gsub("-", "_", x) }))

#erreurs dans collaboration
unique(sort(collaboration$etudiant1))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("ariane_barette", "ariane_barrette", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("arianne_barette", "ariane_barrette", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("cassandra_gobin", "cassandra_godin", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("edouard_nadon_baumier", "edouard_nadon_beaumier", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("eve\xa0_dandonneau", "eve_dandonneau", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("francis_bolly", "francis_boily", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("francis_bourrassa", "francis_bourassa", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("frederick_laberge", "frederic_laberge", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("juliette_meilleur\xa0", "juliette_meilleur", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("justine_lebelle", "justine_labelle", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("laurianne_plante ", "laurianne_plante", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("louis_phillippe_theriault", "louis_philippe_theriault", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("madyson_mcclean", "madyson_mclean", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("mael_guerin", "mael_gerin", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("marie_burghin", "marie_bughin", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("mia_carriere\xa0", "mia_carriere", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("noemie_perrier_mallette", "noemie_perrier_malette", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("peneloppe_robert", "penelope_robert", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("philippe_barette", "philippe_barrette", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("phillippe_bourassa", "philippe_bourassa", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("philippe_bourrassa", "philippe_bourassa", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("raphael_charlesbois", "raphael_charlebois", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("sabrica_leclercq", "sabrina_leclercq", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("savier_samson", "xavier_samson", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("yanick_sagneau", "yannick_sageau", x) }))

collaboration <- data.frame(lapply(collaboration, function(x){
  gsub("yanick_sageau", "yannick_sageau", x) }))

#enlever collaboration multiple
collaboration <- subset(collaboration, etudiant1 != etudiant2)

#erreurs dans etudiant
unique(sort(etudiant$prenom_nom))
unique(sort(etudiant$region_administrative))
 
#correction prénom et nom dans etudiant
etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("arianne_barette", "ariane_barrette", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("amelie_harbeck bastien", "amelie_harbeck_bastien", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("cassandra_gobin", "cassandra_godin", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("edouard_nadon_baumier", "edouard_nadon_beaumier", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("eve\xa0_dandonneau", "eve_dandonneau", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("francis_bolly", "francis_boily", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("juliette_meilleur\xa0", "juliette_meilleur", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("laurianne_plante ", "laurianne_plante", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("louis_phillippe_theriault", "louis_philippe_theriault", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("louis_philipe_raymond", "louis_philippe_raymond", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("louis_phillipe", "louis_philippe", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("mael_guerin", "mael_gerin", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("marie_burghin", "marie_bughin", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("mia_carriere\xa0", "mia_carriere", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("peneloppe_robert", "penelope_robert", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("philippe_barette", "philippe_barrette", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("phillippe_bourassa", "philippe_bourassa", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("raphael_charlesbois", "raphael_charlebois", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("roxanne_bernier\t\t\t\t\t\t\t", "roxanne_bernier", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("sabrina_leclerc", "sabrina_leclercq", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("sabrina_leclercqq", "sabrina_leclercq", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("samule_fortin", "samuel_fortin", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("yanick_sagneau", "yannick_sageau", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("yanick_sageau", "yannick_sageau", x) }))
etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("yanick_sageau", "yannick_sageau", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("bas_st_laurent", "bas_saint_laurent", x) }))

etudiant <- data.frame(lapply(etudiant, function(x){
  gsub("monterigie", "monteregie", x) }))

#supprimer les lignes qui se répeter dans etudiant
# Faire un tableau avec les étudiant qui ont les infos supp
etudiant_info <- subset(etudiant, complete.cases(etudiant$region_administrative))

# Faire un tableau avec les étudiant qui n'ont pas les infos supp
etudiant_vide <- subset(etudiant, !complete.cases(etudiant$region_administrative))

# Voir si etudiant vide se trouve dans etudiant info et l'ajouter dans 9e col de etudiant vide
etudiant_vide$doublon <- is.element(etudiant_vide$prenom_nom, etudiant_info$prenom_nom)

#Enlever les TRUE puis enlever la colonne ajoutée
etudiant_vide <- subset(etudiant_vide, etudiant_vide$doublon != TRUE)
etudiant_vide <- etudiant_vide[,-9]

#fusionner les tableaux
etudiant <- rbind(etudiant_info, etudiant_vide) 

rm(etudiant_info, etudiant_vide)

#correction dans cour
cour <- cour[!(cour$sigle=="BCM112" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="BCM113" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="BIO109" & cour$credits=="2"),]
cour <- cour[!(cour$sigle=="BIO401" & cour$optionnel=="FALSE"),]
cour <- cour[!(cour$sigle=="ECL215" & cour$optionnel=="FALSE"),]
cour <- cour[!(cour$sigle=="ECL315" & cour$optionnel=="FALSE"),]
cour <- cour[!(cour$sigle=="ECL406" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="ECL515" & cour$credits=="1"),]
cour <- cour[!(cour$sigle=="ECL522" & cour$optionnel=="FALSE"),]
cour <- cour[!(cour$sigle=="ECL527" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="ECL544" & cour$optionnel=="FALSE"),]
cour <- cour[!(cour$sigle=="ECL610" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="ECL611" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="INS154 "),]
cour <- cour[!(cour$sigle=="TSB303" & cour$optionnel=="TRUE"),]
cour <- cour[!(cour$sigle=="TSB303" & cour$credits=="1"),]
cour <- cour[!(cour$sigle=="ZOO304" & cour$optionnel=="FALSE"),]

#retirer les lignes identiques dans collaboration, cour et etudiant
collaboration <- unique(collaboration[!duplicated(collaboration),])
cour <- unique(cour[!duplicated(cour),])
etudiant <- unique(etudiant[!duplicated(etudiant$prenom_nom),])

#rajouter les lignes manquant dans etudiant
unique_et1_c<-unique(collaboration$etudiant1)
unique_etudiant<-unique(etudiant$prenom_nom)
setdiff(unique_et1_c, unique_etudiant)
#ajouter les cases manquantes
donnees_abs <- c("eloise_bernier", "eloise", "bernier", NA, NA, NA, NA, NA, "naomie_morin", "naomie", "morin", NA, NA, NA, NA, NA, "karim_hamzaoui", "karim", "hamzaoui", NA, NA, NA, NA, NA, "gabrielle_moreault", "gabrielle", "moreault", NA, NA, NA, NA, NA, "maxence_comyn", "maxence", "comyn", NA, NA, NA, NA, NA, "maude_viens", "maude", "viens", NA, NA, NA, NA, NA)
etudiant_abs <- matrix(donnees_abs, nrow = 6, ncol = 8, byrow = TRUE)
colnames(etudiant_abs) <- c("prenom_nom", "prenom", "nom", "region_administrative", "regime_coop", "formation_prealable", "annee_debut", "programme")
etudiant <- rbind(etudiant, etudiant_abs)
rm(donnees_abs, etudiant_abs, unique_et1_c, unique_etudiant, L, nbGroupe, separateur, tabNames)

#enlever les fausses collaborations
collaboration <- subset(collaboration, etudiant1 != etudiant2)

#enregistrer les donnees nettoyer en CSV
write.csv(collaboration, 'data/collaboration_clean.csv',row.names = FALSE)
write.csv(etudiant, 'data/etudiant_clean.csv',row.names = FALSE) 
write.csv(cour, 'data/cour_clean.csv',row.names = FALSE)


#commande SQL####
library(RSQLite)
con <- dbConnect(SQLite(), dbname ="projet1.db")
#creation table SQL####
#table etudiant
etudiant_sql <- "
CREATE TABLE etudiant_tb(
    prenom_nom VARCHAR (40),
    prenom VARCHAR(40),
    nom VARCHAR(40),
    region_administrative VARCHAR(40),
    regime_coop BOLEAN,	
    formation_prealable VARCHAR(40),
    annee_debut  VARCHAR(20),
    programme VARCHAR(20),	
    PRIMARY KEY (prenom_nom)
);"
dbSendQuery(con, etudiant_sql)

#table collaboration
collaborations_sql <- "
CREATE TABLE collaboration_tb(
    etudiant1     VARCHAR(40),
    etudiant2     VARCHAR(40),
    sigle   VARCHAR(10),
    session  VARCHAR(10),
    PRIMARY KEY (etudiant1, etudiant2, sigle, session),
    FOREIGN KEY (etudiant1) REFERENCES etudiant(prenom_nom),
    FOREIGN KEY (etudiant2) REFERENCES etudiant(prenom_nom),
    FOREIGN KEY (sigle) REFERENCES cour(sigle)
); "
dbSendQuery(con, collaborations_sql)

#table cour
cour_sql <- "
CREATE TABLE cour_tb (
  sigle   VARCHAR(20),
  optionnel       BOLEAN NOT NULL,
  credit     VARCHAR(10),
  PRIMARY KEY (sigle)
); "
dbSendQuery(con, cour_sql)


#####
dbWriteTable(con, append = TRUE, name = "etudiant", value = etudiant, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "collaboration", value = collaboration, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cour", value = cour, row.names = FALSE)

#requeteSQL####
#nombre de lien par etudiant
nlien_sql<-"
SELECT count(etudiant1) AS nb_collab, etudiant1
FROM collaborations
GROUP BY etudiant1
ORDER BY nb_collab DESC
;"
nlien<-dbGetQuery(con,nlien_sql)
head(nlien)

#nombre de lien par paire d'etudiant
nlien.paire_sql<-"
SELECT etudiant1, etudiant2, COUNT(*) AS nb_collab
FROM collaborations
GROUP BY etudiant1, etudiant2
ORDER BY nb_collab DESC
;"
nlien.paire<-dbGetQuery(con,nlien.paire_sql) 
head(nlien.paire)

#enregistrer les requetes en CSV
write.csv(nlien, 'data/nlien.csv', row.names = FALSE)
write.csv(nlien.paire,  'data/nlien.paire.csv', row.names = FALSE)

#connectance
netudiant<-nrow(etudiant)
nlien<-nrow(collaboration)
connectance<-nlien/netudiant
#moyenne et variance 
moy.lien <- mean(nlien.paire$nlien)
moy.lien
var.lien<-var(nlien.paire$nlien)
var.lien

#deconnection
dbDisconnect(con)
#matrice adjacence####
#librarie
library(igraph)
library(ggplot2)

#creattion de la matrice de reseau
r<-nrow(etudiant)
matrice_interact <- matrix(0, nr = r, nc = r)
noms<-etudiant[, 1]
colnames(matrice_interact)<-noms#nom de la colonne
rownames(matrice_interact)<-noms#nom de la ligne

#insertion des interactions entre etudiant (1=interaction et 0=pas d'interaction)
n<-nrow(nlien.paire)
for (i in 1:n){
  if (nlien.paire[i,3]>0) {
    matrice_interact[nlien.paire[i,1],nlien.paire[i,2]]<-1 }
}
#graphique du reseau ####
g <- graph.adjacency(matrice_interact)
deg <- apply(matrice_interact, 2, sum) + apply(matrice_interact, 1, sum)
# Le rang 
rk <- rank(deg)
# Faire un code de couleur
col.vec <- heat.colors(r)
# Attribuer aux liens une couleur
V(g)$color = col.vec[rk]
#Taille
col.vec <- seq(1, 5, length.out = r)
# Attribuer aux liens la taille
V(g)$size = col.vec[rk]

#afficher le graphique de reseau####
plot(g,vertex.label = NA, edge.arrow.mode = 0,
     vertex.frame.color = NA,
     layout = layout.kamada.kawai(g))
ggsave("figures/visualisation.png", device = "png", dpi=300)
#enregistrer la figure obtenue####

#propriete du reseau####
# Évalue la présence communautés dans le graphe
wtc = walktrap.community(g)
#distance entre les noeuds
distances(g)
#centralité des personnes####
centralite <- eigen_centrality(g)$vector
#production d'un graphique avec la centralité
  par(mar=c(5,5,5,5))
  centralite=eigen_centrality(g)$vector 
  nombre_de_liens=nlien[,1]
  plot(nombre_de_liens,centralite,pch=20, 
       xlab = "Nombre de liens", ylab= "Centralite")
  cor.test(nombre_de_liens,centralite)
  
  # Calculer le bacon number des etudiants par rapport a magalie
    par(mar=c(5,5,5,5))
    distance=distances(g)
    bacon_number=as.matrix(distance[,2])
    bacon_number=bacon_number[bacon_number!=0]
    hist(bacon_number, xlab="Nombre de Bacon", ylab="Frequence", breaks = c(0.5,1.5,2.5,3.5,4.5), main=NULL)
  
