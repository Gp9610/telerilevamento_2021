#R_code_esame.r




library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(rgdal)
library(raster)
setwd("C:/esame/")

oronville1<-brick("oroville_oli_2019155_lrg.jpg")
#carico l'immagine con la funzione brick per caricare il set di dati dell'immagine in questione
oronville1 
#class      : RasterBrick 
#dimensions : 3065, 3706, 11358890, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 3706, 0, 3065  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/esame/oroville_oli_2019155_lrg.jpg 
#names      : oroville_oli_2019155_lrg.1, oroville_oli_2019155_lrg.2, oroville_oli_2019155_lrg.3 
#min values :                          0,                          0,                          0 
#max values :                        255,                        255,                        255

plot(oronville1)
plotRGB(oronville1, r=3,g=2,b=1, stretch="lin")
#noto che in rosso sono evidenziati il lago e i vari corsi d'acqua

oronville2 <- brick("oroville_oli_2021160_lrg.jpg")
#class      : RasterBrick 
#dimensions : 3065, 3706, 11358890, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 3706, 0, 3065  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/esame/oroville_oli_2021160_lrg.jpg 
#names      : oroville_oli_2021160_lrg.1, oroville_oli_2021160_lrg.2, oroville_oli_2021160_lrg.3 
#min values :                          0,                          0,                          0 
#max values :                        255,                        255,                        255 


    
par(mfrow=c(2,1))
plotRGB(oronville1, r=1, g=2, b=3, stretch="lin")
plotRGB(oronville2, r=1, g=2, b=3, stretch="lin")


dvi1 <- oronville1$oroville_oli_2019155_lrg.1 - oronville1$oroville_oli_2019155_lrg.2
plot(dvi1)
#per ogni banda stiamo prendendo il valore dell'infrarosso a cui sottraiamo i valori delle bande del rosso
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)
#tutta la parte rossa è la vegetazione che negli anni si perde e diventa suolo agricolo

dvi2 <- oronville2$oroville_oli_2021160_lrg.1 - oronville2$oroville_oli_2021160_lrg.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")
#notiamo rispetto a defor1 il colore giallo molto più diffiso e ciò sta a significare che la vegetazione è stata distrutta
#ora con un par vediamo le 2 immagini a confronto
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 2019")
plot(dvi2, col=cl, main="DVI at time 2021")
#da questo confronto si possono cogliere impattanti differenze di come la vegetazione in soli 2 anni ha iniziato a soffrire
#allora faccio una differenza per capire nel dettaglio
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('red','white','black'))(100)
plot(difdvi, col=cld)
#colore rosso =soffrenza da parte della vegetazione nel tempo=deforestazione per urbanizzazione, invece notiamo che la parte in bianco è dove la vegetazione non ha subito gravi variazione(infatti siamo sullo 0))

#Ora posso normalizzare tramite il NDVI
# ndvi1 (NIR-RED) / (NIR+RED)
ndvi1 <- (oronville1$oroville_oli_2019155_lrg.1 - oronville1$oroville_oli_2019155_lrg.2) / (oronville1$oroville_oli_2019155_lrg.1 + oronville1$oroville_oli_2019155_lrg.2)
plot(ndvi1, col=cl)
# ndvi2 (NIR-RED) / (NIR+RED)
ndvi2 <- (oronville2$oroville_oli_2021160_lrg.1 - oronville2$oroville_oli_2021160_lrg.2) / (oronville2$oroville_oli_2021160_lrg.1 + oronville2$oroville_oli_2021160_lrg.2)
plot(ndvi2, col=cl)
# con il confronto del ndvi1 e ndvi2 si nota come la vegetazione sia molto stressata (colore arancio)

par(mfrow=c(2,1))
plot(ndvi1, col=cl)
plot(ndvi2, col=cl)

#Ora prendo le tante bande e riduco il sistema con la PCA
#PCA è analisi piuttosto impattante , quindi un'idea è quello di ricampionare un nostro dato in modo da renderlo più leggero
#funzione aggregate per aggregarei i pixel;fact=fattore lineare  di ricampionamento

oronville1res <- aggregate(oronville1, fact=10)

#PCA pricipal component analisys
#riduce n dimensioni a m dimensioni(numero piùpiccolo ovviamente!)
oronville1res_pca <- rasterPCA(oronville1res)
 
#ora leghiamo($) l'immagine pca al modello che si è creato in uscita insieme alla mappa
#summary ci serve per fare un sommario del nostro modello
summary(oronville1res_pca$model)
#Importance of components:
#                           Comp.1      Comp.2      Comp.3
#Standard deviation     86.2126378 16.68272799 7.619837825
#Proportion of Variance  0.9567028  0.03582361 0.007473545
#Cumulative Proportion   0.9567028  0.99252645 1.000000000
#come possiamo vedere la pc1 spiega tutta la varianza del sistema (il 95.67% della varianza)
#per arrivare al 100% mi ci vogliono tutte le bande 

plot(oronville1res_pca$map)
plotRGB(oronville1res_pca$map, r=1, g=2, b=3, stretch="lin")
#######faccio la stessa cosa per la seconda immagine#########################à
oronville2res <- aggregate(oronville2, fact=10)

#PCA pricipal component analisys
#riduce n dimensioni a m dimensioni(numero piùpiccolo ovviamente!)
oronville2res_pca <- rasterPCA(oronville2res)
 
#ora leghiamo($) l'immagine pca al modello che si è creato in uscita insieme alla mappa
#summary ci serve per fare un sommario del nostro modello
summary(oronville2res_pca$model)
#Importance of components:
#                            Comp.1      Comp.2      Comp.3
##Standard deviation     126.0999764 19.81927539 6.487891108
#Proportion of Variance   0.9733782  0.02404513 0.002576669
#Cumulative Proportion    0.9733782  0.99742333 1.000000000
#Anche qui la pc1 spiega la maggiore variabilità del sistema (97,33%)

plot(oronville2res_pca$map)
plotRGB(oronville2res_pca$map, r=1, g=2, b=3, stretch="lin")
#######################################################################################
#calcolo la variabilità di questa immagine a singolo strato
#funzione focal calcola la statistica che ci piace del movie window
#focal del dato appena creato ;w(window) matrice di 3x3 pixel =9,sd=deviazione standard
ndvi1sd <- focal(ndvi1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvi1sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvi1sd, col=clsd) #verde zone da roccia nuda a roccia vegetata, dev.standard molto omogenea 

# calcolo la media nell'indice di vegetazione NDVI

ndvi1mean <- focal(ndvi1, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvi1mean, col=clsd) # valori bassi per la roccia nuda 
##########faccio la stessa cosa con la seconda immagine##############à
ndvi2sd <- focal(ndvi2, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvi2sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvi2sd, col=clsd) #verde zone da roccia nuda a roccia vegetata, dev.standard molto omogenea 

# calcolo la media nell'indice di vegetazione NDVI

ndvi2mean <- focal(ndvi2, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvi2mean, col=clsd) # valori bassi per la roccia nuda 

#firme spettrali
click(oronville1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
