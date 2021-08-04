#R_code_esame.r
#Appena quattro anni dopo essere emersa da una grave siccità pluriennale, la California è tornata in
#condizioni di siccità che non si vedevano dal 1976-77. La prova della nuova siccità risalta nelle
#immagini satellitari di uno dei due più grandi serbatoi dello stato: Shasta Lake.
#Le immagini sono state acquisite dall'Operational Land Imager (OLI) su Landsat 8, mostrano il
#lago Shasta quest'anno e nel giugno 2019 (condizioni più tipiche).



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




    
par(mfrow=c(2,1))
plotRGB(shasta1, r=1, g=2, b=3, stretch="lin", main= 2019)
plotRGB(shasta2, r=1, g=2, b=3, stretch="lin",main=2021)
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
#plot(shasta2c$map) #classe 1=suolo nudo (bianco), classe 2=vegetazione(verde)

#quanto la siccità ha provocato un ritiro delle acque
#calcolo della frequenza dei pixel di una certa classe. Quanti pixel di una classe e dell' altra classe ci sono?
#proporzioni delle 2 classi nell'immagine defor1
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
# Per fare l'analisi multivariata faccio una list.file con le mie due immagini 
rlist <- list.files(pattern="shasta_oli")
rlist
#[1] "shasta_oli_2019194_lrg.jpg" "shasta_oli_2021167_lrg.jpg"

#lapply : applica una funzione su un elenco o un vettore
import <- lapply(rlist,raster)
# import
#[[1]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 1681, 2017, 3390577  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/esame/shasta_oli_2019194_lrg.jpg 
#names      : shasta_oli_2019194_lrg 
#values     : 0, 255  (min, max)


#[[2]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 1681, 2017, 3390577  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/esame/shasta_oli_2021167_lrg.jpg 
#names      : shasta_oli_2021167_lrg 
#values     : 0, 255  (min, max)
#stack : impila i vettori da un riquadro dati o da un elenco
shasta <- stack (import)
plot (shasta)
plotRGB(shasta,1,2,3,stretch="Lin")
#level plot ->Disegna grafici di livello e grafici di contorno.
levelplot(shasta)

shasta_diff <- shasta$shasta_oli_2021167_lrg   - shasta$ shasta_oli_2019194_lrg
clb<- colorRampPalette(c("blue","white","red")) (100)
plot(shasta_diff,col=clb)


#procedo con l'analisi multivariata
pairs(shasta)
#pairs plotta tutte le bande una contro l'altra per vedere la loro correlazione. Mette in correlazione, a 2 a 2, ciascuna banda
#sulla diagonale ci sono le bande, mentre sulla parte bassa della matrice ci sono i grafici di correlazione.
#i numeri sulla parte alta della matrice rappresentano l'indice della correlazione (-1<R<+1)
#vediamo una correlazione di 0.65, quindi sono correlate positivamente

#rasterPCA: Principal Component Analysis for Raster
shasta_pca<-rasterPCA(shasta) #si crea una mappa in uscita e un modello
summary(shasta_pca$model) #mi visualizza le informazioni relative al modello. Permette di vedere quanta varianza spiegano le componenti.
#Importance of components:
                           Comp.1     Comp.2
#Standard deviation     82.5248997 36.7753106
#Proportion of Variance  0.8343183  0.1656817
#Cumulative Proportion   0.8343183  1.0000000

plot(shasta_pca$map) #la prima componente PC1 ha molta variabilità e contiene tutta l'informazione (83%)
shasta_pca
#$call
#rasterPCA(img = shasta)

#$model
#Call:
#princomp(cor = spca, covmat = covMat[[1]])

#Standard deviations:
#  Comp.1   Comp.2 
#82.52490 36.77531 

# 2  variables and  3390577 observations.

#$map
#class      : RasterBrick 
#dimensions : 1681, 2017, 3390577, 2  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 2017, 0, 1681  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      :        PC1,        PC2 
#min values :  -93.83337, -149.78608 
#max values :   262.0481,   198.5099 

#plotRGB delle 3 componenti principali della mappa risultante dalla PCA. E' l'analisi risultante dalle componenti principali
plotRGB(shasta_pca$map,r=1,g=2,b=3,stretch='lin')  #colori legati alle 3 componenti, è evidente come il colore rosso evidenzia il suolo nudo dovuto alla siccità.

str(shasta_pca) #da informazioni complete sul file
