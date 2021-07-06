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
plotRGB(oronville1, r=3,g=2,b=1, stretch="hist")
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
#tutta la parte rossa è la vegetazione che negli anni si perde e diventa suolo agricolo

dvi1 <- oronville1$oroville_oli_2019155_lrg.1 - oronville1$oroville_oli_2019155_lrg.2
plot(dvi1)
#per ogni banda stiamo prendendo il valore dell'infrarosso a cui sottraiamo i valori delle bande del rosso
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)

dvi2 <- oronville2$oroville_oli_2021160_lrg.1 - oronville2$oroville_oli_2021160_lrg.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")
#notiamo rispetto a defor1 il colore giallo molto più diffiso e ciò sta a significare che la vegetazione è stata distrutta
#ora con un par vediamo le 2 immagini a confronto
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
#da questo confronto si possono cogliere impattanti differenze di come la vegetazione in soli 2 anni ha iniziato a soffrire
#allora faccio una differenza per capire nel dettaglio
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
#colore rosso =soffrenza da parte della vegetazione nel tempo=deforestazione per urbanizzazione, invece notiamo una colorazione violetta dove la vegetazione non ha subito gravi variazione(intorno -30))

#Ora posso normalizzare tramite il NDVI
# ndvi1 (NIR-RED) / (NIR+RED)
ndvi1 <- (oronville1$oroville_oli_2019155_lrg.1 - oronville1$oroville_oli_2019155_lrg.2) / (oronville1$oroville_oli_2019155_lrg.1 + oronville1$oroville_oli_2019155_lrg.2)
plot(ndvi1, col=cl)
# ndvi2 (NIR-RED) / (NIR+RED)
ndvi2 <- (oronville2$oroville_oli_2021160_lrg.1 - oronville2$oroville_oli_2021160_lrg.2) / (oronville2$oroville_oli_2021160_lrg.1 + oronville2$oroville_oli_2021160_lrg.2)
plot(ndvi2, col=cl)
# con il confronto del ndvi1 e ndvi2 si nota come la vegetazione sia molto stressata (colore arancio)

####################################################################
#ora andrò a vedere le firme spattrali di alcuni punti ramdom presi dalle due diverse immagini
#la funzione per creare le firme spettrali è la funzione click
#serve il pacchetto rgdal che è la libreria che serve a leggere qualsiasi tipo di dato
#viene usata in R per la parte vettoriale (punti, linee, ecc..)
#click fa parte del pacchetto raster serva a cliccare su una mappa e richiedere qualiasi tipo di informazioni
#l'informazione che nel nostro caso verrà fuori è relativa alla RIFLETTANZA

click(oronville2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
