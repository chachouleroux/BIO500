fonction_deg <- function(matrice_interact){
  deg <- apply(matrice_interact, 2, sum) + apply(matrice_interact, 1, sum)  
return(deg)
  }
