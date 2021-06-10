#05/05/2021
#R_code_land_cover.r
setwd("C:/lab/") 

library(raster)
library(RStoolbox) # classification
library(ggplot2)

#NIR1, RED 2;green 3
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #ggRGB funzione molto potente->plottare ratser con una grafica migliore
#coordinate spaziali del nostro oggetto

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")


par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# multiframe with ggplot2 and gridExtra:che permette di usare ggplot per dati raster
install.packages("gridExtra")
library(gridExtra)


p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)
#grid.arrange(che si trova nel pacchetto gridExtra) compone a nostro piacere il nostro multiframe

#07/05/2021

library(raster)
library(RStoolbox) 
library(ggplot2)
library(gridExtra)

setwd("C:/lab/") 

defor1 <- brick("defor1.jpg") #1992
#con brick carico l'intero dataset
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
defor2 <- brick("defor2.jpg") #2006
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#classificazione non supervisionata
#nSamples è a 10000
d1c <- unsuperClass(defor1, nClasses=2) #unsuperClass C maiuscola!!!!!!
plot(d1c$map)
dc1
#unsuperClass results

#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 478, 714, 341292  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA source     : memornames      : layevalues     : 1, 2  (min, max)
#valore 1 classe agricola e valore 2 foresta amazzonica

d2c <- unsuperClass(defor2, nClasses=2) 
plot(d2c$map)
#classe 1 classe agricola e classe 2 foresta amazzonica
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)
d2c3
#unsuperClass results

#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 478, 717, 342726  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 3  (min, max)
#distinzione all'interno della parte agricola in 2 parti(due tipi di agricoltura); il giallo è la parte resisdua di foresta amazzonica 

#quanto abbiamo perso di foresta?->calcolo la freq dei pixel di una certa classe(es. classe foresta e agricolo)
#va a calcolare la frequenza
freq(d1c$map)
   # value  count
#[1,]     1  35751 -> 
#[2,]     2 305541 ->
#35751+305541
#calcoliamo la proporzione
s1 <- 35751+305541
#[1] 341292
prop1<-freq(d1c$map)/s1
    #      value     count
#[1,] 2.930042e-06 0.1047519 proporzione agricolo
#[2,] 5.860085e-06 0.8952481 proporzione foresta


s2 <- 342726 #usiamo il valore dei pixel data dall'immagine defor2
prop2 <- freq(d2c$map) / s2
prop2
#            value     count
#[1,] 2.917783e-06 0.5223765 proporzione foresta
#[2,] 5.835565e-06 0.4776235 proporzione agricolo

#si possono usare, al posto delle proporzioni le percentuali, dove basta moltiplicare per 100 la proporzione

# build a dataframe(dataset) 
#prima colonna (cover) dove mattiamo i fattori che sono delle variabili categoriche (foresta, agricoltura)
#seconda colonna mettiamo le percentuali (persent_1992)
#terza colonna: percent_2006
cover <- c("Forest","Agriculture") #le virgolette le metto perchà non sono numeri ma è un testo
percent_1992 <- c(89.52, 10.47) #la c perchè sono due blocchi nella stessa colonna
percent_2006 <- c(52.23, 47.76)

#funzione per creare un dataframe-> data.frame
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#        cover percent_1992 percent_2006
#1      Forest        89.52        52.23
#2 Agriculture        10.47        47.76


#ggplot è una funzione che permette di plottare un dataset e poi abbiamo la parte estetica(aes):colonna(x) e la perc. del 1992(y) quale color(quali oggetti vogliiamo discriminare nel grafico la percentuale + geometria->geom_bar:identity sono i dati che abbiamo generato e il colore delle barre
#ggplot è una sorta di par
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="pink") #la barra dell'agricolo è molto più basso alla barra della foresta
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="green") #ora le due barre sono molto simili in altezza

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="pink")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="green")


grid.arrange(p1, p2, nrow=1) #mettere insieme vari plot del ggplot
#library gridExtra
#1992 la foresta è molto elevata come valore, al contrario  i valori dell'agricoltura
