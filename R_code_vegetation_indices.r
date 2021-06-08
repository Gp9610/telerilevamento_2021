#R_code_vegetation_indices.r

#INDICI DI VEGETAZIONE


#INDICI DI VEGETAZIONE
#IL CASO DELLA FORESTA AMAZZONICA
#DATI PREPROCESSATI LANSAT 30M    

library(raster)


setwd("C:/lab/") 
# Windows


defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#b1=NIR, b2=red, b3= green
    
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#tutta la parte rossa è la vegetazione che negli anni si perde e diventa suolo agricolo

#30/04/2021
library(raster) #un'alternativa è require(raster)
# Windows setwd("C:/lab/") 
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1=NIR; b2=red; B3=green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# calcolo l'indice di vegetazione prima e dopo; defor1 (infrarosso - rosso)
defor1
#class      : RasterBrick 
#dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/defor1.jpg 
#names      : defor1.1, defor1.2, defor1.3 
#min values :        0,        0,        0 
#max values :      255,      255,      255 

#infrarosso defor1.1; rosso=defor1.2

#different vegetation index
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)
#per ogni banda stiamo prendendo il valore dell'infrarosso a cui sottraiamo i valori delle bande del rosso
#dev.off()
#cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)
# specifying a color scheme
# plot(dvi1, col=cl, main="DVI at time 1") così abbiamo il modo di visualizzare il DVI appena calcolato

#ora calcoliamo il secondo dvi2
defor2
#class      : RasterBrick 
#dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/defor2.jpg 
#names      : defor2.1, defor2.2, defor2.3 
#min values :        0,        0,        0 
#max values :      255,      255,      255 

#infrarosso defor2.1 e rosso 2.2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")
#notiamo rispetto a defor1 il colore giallo molto più diffiso e ciò sta a significare che la vegetazione è stata distrutta
#ora con un par vediamo le 2 immagini a confronto
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#se il DVI è calato nella prima mappa dovrei avere un alto valore (255-20=235)
difdvi <- dvi1 - dvi2
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
#colore rosso =soffrenza da parte della vegetazione nel tempo=deforestazione)

#Ora posso normalizzare tramite il NDVI
# ndvi1 (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)
# ndvi2 (NIR-RED) / (NIR+RED)
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

library(RStoolbox)
# for vegetation indices calculation
# RStoolbox::spectralIndices dove calcoliamo in modo efficiente indici multispettrali come NDVI

vi <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

#05/05/2021
install.packages("rasterdiv")
library(rasterdiv)
#questo nuovo pacchetto Diversity Indices for Numerical Matrices
#rasterdiv è stato realizzato per costruire serie di indici di diversità globali basato sulla teoria dell'informazione
#Il set di dati input è quello del Copernicus Long-Term con dati dal 1999 al 2017 con una media dell indice NDVI di ogni 21 Giugno
#copNDVI->copernicus NDVI
setwd("C:/lab/")
#wordwide NDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
#togliere la parte che riguarda l'acqua cbing i valori 253,254 e 255 sono eliminati
#mappa NDVI a scala globale
install.packages("rasterVis")
library(rasterVis)

levelplot(copNDVI)
#situazione di come respira la terra; valori più altri foresta amazzonica ecc... tutto il resto ha valori bassi(es.deserti) 
#
