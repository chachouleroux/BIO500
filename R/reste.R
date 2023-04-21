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
ncollab_centralite <-plot(nombre_de_liens,centralite,pch=20, xlab = "Nombre de liens", ylab= "Centralite")
cor.test(nombre_de_liens,centralite)
savePlotAsImage("figures/ncollab_centralite.png",format ="png", width = 1000, height = 1000)#enregistrer la figure obtenue####

# Calculer le bacon number des etudiants par rapport a magalie
par(mar=c(5,5,5,5))
distance=distances(g)
bacon_number=as.matrix(distance[,2])
bacon_number=bacon_number[bacon_number!=0]
b_number <- hist(bacon_number, xlab="Nombre de Bacon", ylab="Frequence", breaks = c(0.5,1.5,2.5,3.5,4.5), main=NULL)
savePlotAsImage("figures/b_number.png",format ="png", width = 1000, height = 1000)#enregistrer la figure obtenue####
}