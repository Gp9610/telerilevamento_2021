#R_code_esame.r
#Appena quattro anni dopo essere emersa da una grave siccità pluriennale, la California è tornata in
#condizioni di siccità che non si vedevano dal 1976-77. La prova della nuova siccità risalta nelle
#immagini satellitari di uno dei due più grandi serbatoi dello stato: Shasta Lake.
#Le immagini sono state acquisite dall'Operational Land Imager (OLI) su Landsat 8, mostrano il
#lago Shasta quest'anno e nel giugno 2019 (condizioni più tipiche).
#https://landsat.visibleearth.nasa.gov/view.php?id=148447


library(RStoolbox)
library(rasterVis)
library(ggplot2)
library(gridExtra)
library(raster)
setwd("C:/esame/")

#  land cover
shasta1<-brick("shasta_oli_2019194_lrg.jpg")
#carico l'immagine con la funzione brick per caricare il set di dati dell'immagine in questione
shasta1 
# shasta1 
#class      : RasterBrick 
#dimensions : 1681, 2017, 3390577, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/esame/shasta_oli_2019194_lrg.jpg 
#names      : shasta_oli_2019194_lrg.1, shasta_oli_2019194_lrg.2, shasta_oli_2019194_lrg.3 
#min values :                        0,                        0,                        0 
#max values :                      255,                      255,                      255 
plot(shasta1)
plotRGB(shasta1, r=3,g=2,b=1, stretch="lin")
#noto che in rosso sono evidenziati il lago e i vari corsi d'acqua
shasta2 <- brick("shasta_oli_2021167_lrg.jpg")
plotRGB(shasta2, r=3,g=2,b=1, stretch="lin")
# shasta2
#class      : RasterBrick 
#dimensions : 1681, 2017, 3390577, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/esame/shasta_oli_2021167_lrg.jpg 
#names      : shasta_oli_2021167_lrg.1, shasta_oli_2021167_lrg.2, shasta_oli_2021167_lrg.3 
#min values :                        0,                        0,                        0 
#max values :                      255,                      255,                      255 




    
par(mfrow=c(1,2))
plotRGB(shasta1, r=1, g=2, b=3, stretch="lin", main= "2019")
plotRGB(shasta2, r=1, g=2, b=3, stretch="lin",main="2021")
#confronto tra immagini ggRGB grazie al pacchetto gridExtra
#grid.arrange plotta le immagini raster
p1<-ggRGB(shasta1,r=1,g=2,b=3,stretch='lin')
p2<-ggRGB(shasta2,r=1,g=2,b=3,stretch='lin')
grid.arrange(p1,p2,nrow=2)  #immagini disposte su 2 righe

#Unsupervised Classification con 2 classi: l'inizio non viene supervisionato da noi, è il programma che prende in modo random i training sites
shasta1c<-unsuperClass(shasta1,nClasses=2) 
shasta1c
#unsuperClass results

#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 1681, 2017, 3390577  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 2  (min, max)
plot(shasta1c$map)# classe 1=suolo nudo, classe 2=vegetazione


shasta2c<-unsuperClass(shasta2,nClasses=2)
shasta2c
#unsuperClass results

#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 1681, 2017, 3390577  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 2  (min, max)
plot(shasta2c$map) #classe 1=suolo nudo (bianco), classe 2=vegetazione(verde)

par(mfrow=c(1,2))
plot(shasta1c$map)
plot(shasta2c$map)

#quanto la siccità ha provocato un ritiro delle acque
#calcolo della frequenza dei pixel di una certa classe. Quanti pixel di una classe e dell' altra classe ci sono?
#proporzioni delle 2 classi nell'immagine shasta1c
freq(shasta1c$map)
#     value   count
#[1,]     1  655252 #nell' area di vegetazione
#[2,]     2 2735325 #suolo nudo
#proporzione (percentuale) dei pixel nelle 2 classi
s1<-655252+2735325 
s1   #[1] 3390577. Questo numero si trova anche in shasta1c
prop1<-freq(shasta1c$map)/s1
#> prop1
#            value     count
#[1,] 2.949351e-07 0.1932568 19% di suolo nudo
#[2,] 5.898701e-07 0.8067432 81% della vegetazione

#proporzioni delle 2 classi nell'immagine shasta2c
freq(shasta2c$map)
#     value   count
#[1,]     1  706788
#[2,]     2 2683789
s2<-706788+ 2683789  
s2   #[1] 3390577
prop2<-freq(shasta2c$map)/s2
prop2
#            value     count
#[1,] 2.949351e-07 0.2084566 21% di suolo dettato dalla siccità
#[2,] 5.898701e-07 0.7915434 79% della vegetazione

#la percentuale di suolo nudo è aumentata dal 2019 al 2021 del 2%

#generazione di un dataframe (=dataset)
#1 colonna contenente i fattori: variabili categoriche (suolo nudo e vegetazione). 1 colonna contenente le percentuali nel 2019 e un'altra con le percentualil del 2021 
#costruisco le colonne che mi interessa avere nel dataframe
cover<-c('Suolo Nudo','Vegetazione')  #colonna cover contenente due righe. Sono due vettori quindi utilizzo le virgolette e la c  
percent_2019<-c(19.32,80.67) #colonna contenente i valori percentuali di shasta1 che ricavo da prop1
percent_2021<-c(20.84,79.15)  #colonna contenente i valori percentuali di shasta2 che ricavo da prop2
#creo il dataframe con il comando data.frame
percentages<-data.frame(cover,percent_2019,percent_2021)
#         cover percent_2019 percent_2021
# 1 Suolo Nudo        19.32        80.67
# 2 Vegetazione       20.84        79.15

#ggplot del dataframe (mpg). aes definisce l'estetica: descrive gli assi x e y e color si riferisce in base a quali oggetti vogliamo discriminare 
#al ggplot si aggiunge il comando geom_bar che crea un istogramma. stat='identify' vuol dire che mantiene i dati così come sono, fill è il colore di riempimento degli istogrammi
ggplot(percentages,aes(x=cover,y=percent_2019,color=cover))+geom_bar(stat='identity',fill='white')  #istogramma con le percentuali del 2019
ggplot(percentages,aes(x=cover,y=percent_2021,color=cover))+geom_bar(stat='identity',fill='white')  #istogramma con le percentuali del 2021
#notiamo a colpo d'occhio che quest'analisi mostra che anche se si è registrata una forte siccità dovuta al non scioglimento dei ghiacciai le percentuali di suolo nudo non sono così elevate, come invece dal confronto delle due immagine si nota subito

p1<-ggplot(percentages,aes(x=cover,y=percent_2019,color=cover))+geom_bar(stat='identity',fill='white')
p2<-ggplot(percentages,aes(x=cover,y=percent_2021,color=cover))+geom_bar(stat='identity',fill='white')
grid.arrange(p1, p2, nrow=1) #mettere insieme vari plot del ggplot

######################################################################################################################################à
# Multivariate Analysis
#pairs è una funzione diretta e plotta tutte le combinazione possibili delle variabili
#indice di correlazione(indice di Pearson) varia da -1 a 1 : correlati positivamente valore 1; correlati negativamente -

pairs(shasta1)
#vediamo che la banda del blu e del verde sono correlate in modo molto forte con indice di Person pari a 0.94 per le bande dell'immagine del 2019
#la pc1 spiega tutta la varianza del sistema (il 94% della varianza)
#per arrivare al 100% mi ci vogliono tutte le bande 
#con le prime 3 bande spiego tutta la variabilità possibile
pairs(shasta2)
#vediamo che la banda del blu e del verde sono correlate in modo molto forte con indice di Person pari a 0.94 per le bande dell'immagine del 2021
shasta1_pca<-rasterPCA(shasta1)
summary(shasta1_pca$model)
#Importance of components:
#                          Comp.1      Comp.2      Comp.3
#Standard deviation     72.8708129 15.49184619 6.569193764
#Proportion of Variance  0.9493767  0.04290794 0.007715347
#Cumulative Proportion   0.9493767  0.99228465 1.000000000
plot(shasta1_pca$map)
#94% della variabilità contenuta nella prima componente

shasta2_pca<-rasterPCA(shasta2)
summary(shasta2_pca$model)
#Importance of components:
#                          Comp.1      Comp.2      Comp.3
#Standard deviation     95.682841 20.37762526 7.315502912
#Proportion of Variance  0.951292  0.04314722 0.005560759
#Cumulative Proportion   0.951292  0.99443924 1.000000000 
plot(shasta2_pca$map)
#95% della variabilità contenuta nella prima componente

par(mfrow=c(1,2))
plotRGB(shasta1_pca$map, r=1, g=2, b=3, stretch="lin")
plotRGB(shasta2_pca$map, r=1, g=2, b=3, stretch="lin")


