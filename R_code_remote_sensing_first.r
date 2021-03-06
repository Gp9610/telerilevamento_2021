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

#Visualizing data by RGB (26/03/2021)
library(raster) 
setwd("C:/lab/") 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
#Bande Landsat
#B1= Blu
#B2= Verde
#B3= Rosso
#B4= Vicino infrarosso
#B5= Infrarosso medio
#B6= Infrarosso Termico
#B7= Infrarosso medio
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
#plotRGB serve quando abbiamo un oggetto raster con più bande che attraverso il sistema RGB va ad utilizzarle
#l' argomento stretc prende i valori delle singole bande e le "tira" per non far risultare uno schiacciamento di un singolo colore
# Lin vuol dire lineare
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
#monto l'infrarosso vicino nella componente red del sistema RGB la vegetazione nell'infrarosso ha un'altissima riflettanza quindi assume una colorazione rossa
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
#esercizio
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")

#salvare l'immagine che ho creato come pdf
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
dev.off()

#funzione histgram stretch -> "tira" molto di più verso il centro
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="hist")

#par natural color,false color and false coloor with histgram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="hist")
#installare i seguenti 2 pacchetti:
install.packages("RStoolbox")
library(RStoolbox)
install.packages("ggplot2")
library(ggplot2)

#31/03/2021
#p224r63_1988_masked faccio un confronto temporaneo; multitemporal set
library(raster)
setwd("C:/lab/") 
#ricarico sempre il pacchetto raster e faccio il setwd, se non lo faccio mi da errore 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
p224r63_1988 <-brick("p224r63_1988_masked.grd")
p224r63_1988
#valori dei pixel diversi perchè è stata presa nel 1988
#gli altri valori sono uguali
plot(p224r63_1988)
#plotRGB
plotRGB(p224r63_1988, r=3 ,g=2 ,b=1 , stretch="Lin")
plotRGB(p224r63_1988, r=4 ,g=3 ,b=2 , stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988, r=4 ,g=3 ,b=2 , stretch="Lin")
#confronto tra l'immagine 1988 e 2011 con l'infrarosso vicino nella banda del rosso

par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988, r=4 ,g=3 ,b=2 , stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_1988, r=4 ,g=3 ,b=2 , stretch="hist")
#confronto 2011 e 1988 con lo stretch lin e hist 

pdf("confronto_1988_2011.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988, r=4 ,g=3 ,b=2 , stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_1988, r=4 ,g=3 ,b=2 , stretch="hist")
dev.off()
#creo il mio pdf con il confronto delle immagini 1988 e 2011


