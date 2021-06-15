#14/06/2021
#R_code_no2.r

# scarico la cartella zippata EN da Virtuale
#creo una nuova cartella nella cartella lab denominata EN
#estraggo i dati dalla cartella zip nella cartella EN 

# 1.  setwd("C:/lab/EN") for windows
# 2.carico le librerie che mi servono
library(raster)
library(RStoolbox)



# 3.uso la funzione raster per caricare 1 sola banda("primo strato"); la funzione brick invece carica un set multiplo di dati (ossia più bande)
EN01 <- raster("EN_0001.png")
# dunque ora ho selezionato una banda; ma la funzione raster può selezionare anche tante bande singole
# 4.plotto l'immagine con una colorRampPalette con la colorazione che più preferisco
cls <- colorRampPalette(c("red","pink","magenta","blue")) (200)
plot(EN01, col=cls)
#col blu visualizzo i valori più alti di no2 nel periodo di gennaio
EN01
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 432, 768, 331776  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/EN/EN_0001.png 
#names      : EN_0001 
#values     : 0, 255  (min, max)

# 5.importo l'ultima immagine EN_0013.png
EN13 <- raster("EN_0013.png")
cls <- colorRampPalette(c("red","pink","magenta","blue")) (200)
plot(EN13, col=cls)
#situazione migliorata per i valori di no2 nel periodo di marzo

# 6. ora facciamo la differenza tra l'immagine di gennaio e quella di marzo

ENdif<- EN13-EN01
plot(ENdif,col=cls)

# 7. Con par carico il set insieme e faccio tre colonne e non tre righe perchè le immagini sono troppo piccole!
par(mfrow=c(1,3))
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (January - March)")



# 8. Importo tutto il set insieme, ossia le 13 immagini:
rlist <- list.files(pattern="EN")
rlist
# [1] "EN_0001.png" "EN_0002.png" "EN_0003.png" "EN_0004.png" "EN_0005.png"
# [6] "EN_0006.png" "EN_0007.png" "EN_0008.png" "EN_0009.png" "EN_0010.png"
#[11] "EN_0011.png" "EN_0012.png" "EN_0013.png"
 

#Con la funzione lapplay applica una funziona (raster) a una lista di files
import <- lapply(rlist,raster)
import

 
# 9.impacchettare i dati che sono separati -> funzione stack
EN <- stack(import)
plot(EN, col=cls)


# 10. Faccio il par e lego EN che contiene tutte e tredici immagini tramite $ all'immagine 1 e 13
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)

# 11. analisi multivariata, PCA
ENpca <- rasterPCA(EN)
summary(ENpca$model)
plot(ENpca$map)

plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# 11.variabilità della prima banda della pca
pc1 <- ENpca$map$PC1
pc1sd <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(pc1sd, col=clsd)

