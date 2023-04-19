#commande SQL####

commande_SQL<-function(){ 
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
moy.lien <- mean(nlien.paire$nb_collab)
moy.lien
var.lien<-var(nlien.paire$nb_collab)
var.lien

#deconnection
dbDisconnect(con)
#matrice adjacence####

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
}
