# Il mio primo codice in R per il telerilevamento

# install.packages("raster")
library(raster) 
# library serve per richiamare i dati istallati precedentemente con install.packages("raster"). 
# Essendo in questo caso library interno a R non bisogno delle virgolette "".

setwd("C:/lab/") 
#Windows

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
# la funzione brick importa le immagini satellitari
# p224r63_2011 è l'oggetto

4447533*7
#4447533 è in numero di righe e colonne; 7 è il numero di bande
[1] 31132731
# numero totali di pixel

plot(p224r63_2011)
# la funzione plot mi fa visualizzare i dati in R

#color change
cl <-colorRampPalette(c("black","grey","light grey")) (100)
# inserisco una nuova gamma di colori -> nero, grigio, grigio chiaro; li chiudo in un "vettore" che è c
# quanti livelli di colori intermedi voglio avere (100)

plot(p224r63_2011, col=cl)
#ho cambiato la legenda dei colori per ogni banda
# col= colore che lo associo a cl con la mia nuova scala di colori; è un argomento della funzione plot; mi definisce i colori

cl <-colorRampPalette(c("blue","green","orange","red")) (100)
plot(p224r63_2011, col=cl)
# cambio i colori e vedo il risultato su R

cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)

p224r63_2011
class      : RasterBrick 
dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
resolution : 30, 30  (x, y)
extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/p224r63_2011_masked.grd 
names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 

#Bande Landsat
#B1= Blu
#B2= Verde
#B3= Rosso
#B4= Vicino infrarosso
#B5= Infrarosso medio
#B6= Infrarosso Termico
#B7= Infrarosso medio

dev.off()
# dev.off() serve per ripulire la finestra grafica

plot(p224r63_2011$B1_sre)
# $ viene utilizzato per legare due blocchi ( in questo caso l'immagine p224r63_2011 alla sua banda del blu B1_sre)

clg <-colorRampPalette(c(" dark blue"," light green","orange","red", "purple")) (200)
plot(p224r63_2011$B1_sre, col=clg)

dev.off()

plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#in questo modo non riesco a mettere le 2 bande vicine allora uso la funzione par che mi definisce come visualissare le immagini
par(mfrow=c(1,2))
#1 riga e 2 colonne
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
par(mfrow=c(2,1))
#2 righe e 1 colonna
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#par(mfcol=c=1,2)) qui utilizzo le colonne

par(mfrow=c(4,1))
#par(mfrow=c(2,2)) in questo modo cambio disposizione della visualizzazione  delle immagini
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
# 4 bande insieme

# assegno a ogni banda una sua palette di colori
par(mfrow=c(2,2))
clb <-colorRampPalette(c(" dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <-colorRampPalette(c(" dark green"," green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <-colorRampPalette(c(" dark red"," red","purple")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnear <-colorRampPalette(c(" dark red"," orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnear)
