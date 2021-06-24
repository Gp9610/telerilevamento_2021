#R_code_complete. - Telerilevamento geo-ecologico
#11/06/2021
#-------------------------------------------------

#sommario:
# 1. Remote Sensing- first code
# 2. R code time series
# 3. R code copernicus
# 4. R code knitr
# 5. R code analisi multivariata
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation idices
# 9. R code land cover
# 10. R code variability
# 11 R_code_no2.r
# 12 R_code_spectral_signatures.r

#-------------------------------------------------

# 1. Remote Sensing- first code
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

#4447533*7
#4447533 è in numero di righe e colonne; 7 è il numero di bande
#[1] 31132731
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
#in questo modo, ossia digitando il nome dell'immagine posso visualizzare tutte le caratterististiche dell'immagine
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : C:/lab/p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 

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
#funzione che mi chiude tutti le immagini generate

plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#in questo modo non riesco a mettere le 2 bande vicine allora uso la funzione par che mi definisce come visualissare le immagini; la funzione par
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

# assegno a ogni banda una sua palette di colori tramite la funzione colorRampPalette e plotto l'immagine per vedere il risultato
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
#valori dei pixel sono diversi perchè è stata presa nel 1988
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

#----------------------------------------------------------------

# 2. R code time series
#Time series analysis: importare una serie di dati satellitari multitemporali e analizzarli
#Greenland increase of temperature
# Data and code of Emanuela Cosma

# install.packages("raster")
library(raster)
# Per windows setwd("C:/lab/greenland") 
setwd("C:/lab/greenland") setwd("C:/lab/greenland") 
# 07/04/2021 
# Oggi vedremo come importare un blocco di dati multitemporali tutti insieme in modo da creare lo "stack"
# Lo Stack è un insieme di dati multitemporali raster 
# lst (land surface temperature): è una stima della T° che deriva dal programma Copernicus
# lst_2000.tif
# lst_2005.tif
# lst_2010.tif
# lst_2015.tif
# la funzione per caricare i singoli dati si chiama "raster"

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster ("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster ("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster ("lst_2015.tif")
plot(lst_2015)

#par
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#nuova funzione:lapply
#lapply : apllico una certa funzione (raster) a una lista di file
# list.files R packges -> crea quella lista di files che poi R utilizzerà per applicare la funzione lapply
# pattern spiega al software quali file ci interessano

# list f files:
rlist <- list.files(pattern="lst")
rlist
import <- lapply(rlist,raster)
import
#[[1]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
#source     : C:/lab/Greenland/lst_2000.tif 
#names      : lst_2000 
#values     : 0, 65535  (min, max)


#[[2]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
#source     : C:/lab/Greenland/lst_2005.tif 
#names      : lst_2005 
#values     : 0, 65535  (min, max)


#[[3]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
#source     : C:/lab/Greenland/lst_2010.tif 
#names      : lst_2010 
#values     : 0, 65535  (min, max)


#[[4]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
#source     : C:/lab/Greenland/lst_2015.tif 
#names      : lst_2015 
#values     : 0, 65535  (min, max)


#impacchettare dati che sono separati -> funzione stack

TGr <- stack (import)
plot (TGr)
plotRGB(TGr,1,2,3,stretch="Lin")
#è un file con i colori dei vari anni, i colori sono dettati dalla sovrazione delle varie immagini
# se ho colori rossi ho valori alti di lst nel 2000
# se ho colori verdi ho valori alti di lst nel 2005
# se colori blu ho valori alti di lst nel 2010
plotRGB(TGr,2,3,4,stretch="Lin")
plotRGB(TGr,4,3,2,stretch="Lin")

install.packages("rasterVis")

#09/04/2021

library(rasterVis)
setwd("C:/lab//greenland")
# funzione levelplot : come varia la T° nella nostra zona
levelplot(TGr)
levelplot(Tgr$lst_2000)
par(mfrow=c(2,2))
levelplot(TGr$lst_2000)

cl <- colorRampPalette(c("blue","light blue","pink","red")) (100)
levelplot(TGr,col.regions=cl)
#col.regions cambia il colore nel levelplot ed è una gamma di colore molto potente compatto
# T° di luglio
#come cambiare i titoli delle immagini
#attributi 4 (lst_200,lst_2005,lst_2010,lst_2015)
levelplot(TGr,col.regions=cl, names.attr=c("July 2000", "July 2005", "July 2010", "July 2015"))
levelplot(TGr,col.regions=cl,main="LST variation in time",names.attr=c("July 2000", "July 2005", "July 2010", "July 2015"))
# data melt
#scioglimento dei ghiacciai
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist,raster)
melt<-stack(melt_import)
levelplot(melt)
#possiamo andare a vedere il valore dell'immagine del 2007 meno il valore dell'immagine del 1979
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
# il $ lega il nostro file originale al nostro file interno

clb<- colorRampPalette(c("blue","white","red")) (100)
plot(melt_amount,col=clb)

levelplot(melt_amount,col.regions=clb)

#installare il pacchetto knitr
install.packages("knitr")

#----------------------------------------------------

# 3. R code copernicus

#14/04/2021
#R_code_copernicus.r
#Visualizing Copernicus data

#Prima operazione: vedere se abbiamo le librerie necessarie
# Librerie: 
 library(raster)

# library(ncdf4) -> questa la devo istallare
# install.packages("ncdf4")
library(ncdf4)

setwd("C:/lab/")

albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
#è un raster layer, cioè ha dei pixel con unità minima del file
#la risoluzione è in coordinate geografiche, ossia in gradi
#l'estenzione possibile dei gradi longitudine e latitudine
# sistema di riferimento WGS84

#non usiamo lo schema RGB perchè abbiamo un singolo strato
#useremo una colorRampPalette, e decideremo i colori da utilizzare
cl <- colorRampPalette(c("lightblue","green","red","yellow")) (100)
plot(albedo,col=cl)
#ricampionare il dataset
#per aggregare i nostri pixel-> aggregate: immagine con i pixel
#maggiore è il numero dei pixel maggiore è il peso dell'immagine
#prendo un pixel più grande ed estraggo la media dei valori all' interno-> 
# trasformo la mia immagine di n pixel a un nemro inferiore di pixel
#fattore "fact" diminuiso linermente i pixel (100x100pixel=1pixel)
#è un ricampiomento bi-lineare
albedores <- aggregate(albedo, fact=100)
#il numero di celle rispetto a prima è diminuito e molto più veloce da visualizzare
plot(albedores, col=cl)

#install.packages("knitr")
#install.packages("RStoolbox")
#library(knitr)
#library(RStoolbox)

#------------------------------------------------------------------------------------------------------

# 4. Rcode knitr
#16/04/2021
#R_code_knitr.r
setwd("C:/lab/")
#funzione stitch:report automatico
library(knitr)
#inizialmente faccio copia e incolla del codice precedentemente fatto con i dati della Groellandia su blocco note di windows, e lo salvo come R_code_greenland.r" nella cartella lab
#applico la funzione stitch
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#Error in file(con, "r") : non posso aprire questa connessione
#Inoltre: Warning message:
#In file(con, "r") :
 # cannot open file 'R_code_greenland.r': No such file or directory
#come risolvere il problema: ho salvato il file di testo R_code_greenland.r, e windows non mi mostrava l'estenzione"vera", per cui devo aggiungere io l'estenzione ".txt"
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#si è generato un file nella cartella lab R_code_greenland.r.tex
#come generare un pdf da un file tex
#overleaf si possono usare file latex

#------------------------------------------------------------------------------

# 5. R code analisi multivariata
#23/04/2021
#R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)


setwd("C:/lab/") 
# Windows
# satellite Landsat ha 7 bande e le utilizza tutte e sette
# immagine da caricare su R "p224r63_2011_masked.grd"

p224r63_2011 <- brick("p224r63_2011_masked.grd")

#brick carica un set multiplo di dati
#la funzione raster carica un set per volta

p224r63_2011
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : C:/lab/p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 

# abbiamo 4447533 di pixel e 7 bande e sono molto correlate l'una all'altra
#cioè il valore dei pixel per ogni banda è correlato a quello delle altre bande

plot(p224r63_2011)
 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#plottiamo la banda 1 dei pixel contro la banda 2 dei pixel, ossia i valori
#pch sarebbe il simbolo; cex è la dimensione dein punti
#infomazione di un punto su una banda è simile all'informazione dell'altro punto sull'altra banda
#forma di correlazione causuale

pairs(p224r63_2011)
#pairs è una funzione diretta e plotta tutte le combinazione possibili delle variabili
#indice di correlazione(indice di Pearson) varia da -1 a 1 : correlati positivamente valore 1; correlati negativamente -1
#vediamo che la banda del blu e del verde sono correlate in modo molto forte con indice di Person pari a 0.93



#28/04/2021
#Oggi Prendiamo le tante bande e riduciamo il sistema con la PCA
#PCA analisi piuttosto impattante , quindi un'idea è quello di ricampionare un nostro dato in modo da renderlo più leggero
#funzione aggregate per aggregarei i pixel;fact=fattore lineare  di ricampionamento
#i pixel sono 30x30 metri
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res 
#class      : RasterBrick 
#dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
#resolution : 300, 300  (x, y)
#extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : memory
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values :   0.00670000,   0.01580000,   0.01356544,   0.01648527,   0.01500000, 295.54400513,   0.00270000 
#max values :   0.04936299,   0.08943339,   0.10513023,   0.43805822,   0.31297142, 303.57499786,   0.18649654 
#l'immagine è stata ridimensionata a dei pixel che da 30x30 metri ora è diventato  300x300metri, aumentando la grandezza del pixel diminuisco la risoluzione

#pannello con due immagini dentro funzione "par"
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
 
#PCA pricipal component analisys
#riduce n dimensioni a m dimensioni(numero piùpiccolo ovviamente!)
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
 
#ora leghiamo($) l'immagine pca al modello che si è creato in uscita insieme alla mappa
#summary ci serve per fare un sommario del nostro modello
summary(p224r63_2011res_pca$model)
 #Importance of components:
                         # Comp.1      Comp.2
#Standard deviation     1.2050671 0.046154880
#Proportion of Variance 0.9983595 0.001464535
#Cumulative Proportion  0.9983595 0.999824022
                           #  Comp.3       Comp.4
#Standard deviation     0.0151509526 4.575220e-03
#Proportion of Variance 0.0001578136 1.439092e-05
#Cumulative Proportion  0.9999818357 9.999962e-01
                             #Comp.5       Comp.6
#Standard deviation     1.841357e-03 1.233375e-03
#Proportion of Variance 2.330990e-06 1.045814e-06
#Cumulative Proportion  9.999986e-01 9.999996e-01
                            # Comp.7
#Standard deviation     7.595368e-04
#Proportion of Variance 3.966086e-07
#Cumulative Proportion  1.000000e+00

#la pc1 spiega tutta la varianza del sistema (il 99% della varianza)
#per arrivare al 100% mi ci vogliono tutte le bande 
#con le prime 3 bande spiego tutta la variabilità possibile



plot(p224r63_2011res_pca$map)
#dall'immagine vediamo che la pc1 ha tutte le informazioni la pc7 non ha più niente e non si distingue nulla
p224r63_2011res_pca
#$call
#rasterPCA(img = p224r63_2011res)

#$model
#Call:
#princomp(cor = spca, covmat = covMat[[1]])

#Standard deviations:
    #  Comp.1       Comp.2       Comp.3       Comp.4 
#1.2050671158 0.0461548804 0.0151509526 0.0045752199 
     # Comp.5       Comp.6       Comp.7 
#0.0018413569 0.0012333745 0.0007595368 

# 7  variables and  44550 observations.

#$map
#class      : RasterBrick 
#dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
#resolution : 300, 300  (x, y)
#extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : memory
#names      :         PC1,         PC2,         PC3,         PC4,         PC5,         PC6,         PC7 
#min values : -1.96808589, -0.30213565, -0.07212294, -0.02976086, -0.02695825, -0.01712903, -0.00744772 
#max values : 6.065265723, 0.142898435, 0.114509984, 0.056825372, 0.008628344, 0.010537396, 0.005594299 


#attr(,"class")
#[1] "rasterPCA" "RStoolbox"


plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
#immagine con 3 componenti utilizzando tutte e tre le componenti

#--------------------------------------------------------------------

# 6. R code classification
#21/04/2021
#R_code_classification.r
#il processo di classificazione è un processo che accorpa i pixel con valori simili e una volta accoprti questi rappresentano una "classe"


setwd("C:/lab/") 
# Windows

#salviamo l'immagine "Solar_Orbiter_s_first_views_of_the_Sun_pillars" nella cartella lab
#l'immagine rappresenta attraverso gli ultravioletti dei livelli energetici all'interno del sole
#nella nostra immagine vediamo esplosioni di gas piuttosto potenti sulla destra
#nella parte centrale possiamo notare situazioni a più bassa energia
#situazioni intermedie nella parte grigia tra la parte centrale e le esplosioni
#ora carichiamo l'immagine usando la funzione brick che pesca l'immagine che si trova fuori R

library(raster)
library(RStoolbox)
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

so
#class      : RasterBrick 
#dimensions : 1157, 1920, 2221440, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1920, 0, 1157  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg 
#names      : Solar_Orbiter_s_first_views_of_the_Sun_pillars.1, Solar_Orbiter_s_first_views_of_the_Sun_pillars.2, Solar_Orbiter_s_first_views_of_the_Sun_pillars.3 
#min values :                                                0,                                                0,                                                0 
#max values :                                              255,                                              255,                                              255 



#visualize RGB levels
plotRGB(so, 1,2,3,stretch="lin")

# come fa il software a classificare l'immagine?
# all'interno della nostra immagine una volta montata in RGB noi abbiamo ad esempio un pixel di boisco e i pixel li vediamo nella banda del blu, del verde e del rosso
# il valore di un pixel di vegetazione sarà: nel blu e nel rosso la pianta assorbe per fare fotosintesi e quindi avrà un valore molto basso
# nella banda del verde a causa del mesofillo fogliare rifletterà la luve quindi avrà un valore alto
# incrociando i valori delle 3 bande avremo un certo pixel e così via...
# creazioni di classi da pixel campione nello spazio multi-spettrale dove gli assi sono le bande
# il software andrà a classificare tutti gli altri pixel dell'immagine come funzione del training-set che si è creato
# processo chiamato di somiglianza massima
# in questo caso ilsoftware tira fuori direttamente il training set
# classificazione non supervisionata: non c'è un impatto dell'utente nel definire a monte le classi
# unsupervised classification
# funzione UnsuperClass opera la classificazione non supervisionata

soc <- unsuperClass(so,nClasses=3)

# unsuperClass ha creato in uscito un modello e la mappa 
#nel plottaggio dobbiamo plottare solo la mappa
#plot(soc$map) per legare la mappa

plot(soc$map)
#set.seed per avere tutti la stessa immagine


so1 <- unsuperClass(so,nClasses=20)
plot(so1$map)

sun <- brick("Solar_Orbiter_s_first_view_of_the_Sun.png")
plotRGB(sun, 1,2,3,stretch="lin")
sun1 <- unsuperClass(sun,nClasses=3)
plot(sun1$map)
sun2 <- unsuperClass(sun,nClasses=20)
plot(sun2$map)

#sensori passivi sono quelli che stiamo utilizzando
#fonte interna/diretta es. il laser/radar


#23/04/2021

#Grand Canyon
# https://landsat.visibleearth.nasa.gov/view.php?id=80948
# When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape. At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States. In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the time Earth has existed.


setwd("C:/lab/")
library(raster)
library(RStoolbox)

gc <-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#una volta che sono state definite le classi in uscita avremo un modello e una mappa

gcc2 <- unsuperClass(gc, nClasses=2)
plot(gcc2$map)

ggc2

#unsuperClass results
#*************** Map ******************
#$map
#class #     : RasterLayer 
#dimensions : 6222, 9334, 58076148  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/Users/prima/AppData/Local/Temp/RtmpUP3KbM/raster/r_tmp_2021-05-20_124649_5544_89050.grd 
#names      : layer 
#values     : 1, 2  (min, max)


gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)


#-----------------------------------------------------
# 7.R code ggplot 2
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#--------------------------------------------------------------

# 8. R code vegetation indices
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


#--------------------------------------------------------

# 9. R code land cover

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


#-------------------------------------------------------------------------------------------

# 10. R code variability

#19/05/2021
#R_code_variability.r
library(raster)
library(RStoolbox)

setwd("C:/lab/") 

sent <- brick("sentinel.png") #importiamo l'immagine sentinel.png conposta da 1 nir 2 red e 3 green
plotRGB(sent) #NIR 1, RED 2, GREEN 3; r=1, g=2,b=3
plotRGB(sent, stretch="lin") #plottare a 3 livelli
plotRGB(sent, r=1, g=2, b=3, stretch="lin")
plotRGB(sent, r=2, g=1, b=3, stretch="lin") #parte vegetale verde fluorescente

#calcolo della deviazione standard che include il 68% di tutte le osservazione 
#come si chiamano le bande dell'immagine
sent
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/sentinel.png 
#names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
#min values :          0,          0,          0,          0 
#max values :        255,        255,        255,        255 


nir <- sent$sentinel.1
red <- sent$sentinel.2

#singolo strato
ndvi <- (nir-red) / (nir+red)
plot(ndvi)

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) 
plot(ndvi,col=cl) #vari livelli di NDVI
#calcolo la variabilità di questa immagine a singolo strato
#funzione focal calcola la statistica che ci piace del movie window
#focal del dato appena creato ;w(window) matrice di 3x3 pixel =9,sd=deviazione standard
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd) #verde zone da roccia nuda a roccia vegetata, dev.standard molto omogenea 

# calcolo la media nell'indice di vegetazione NDVI
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd) #valori moolto alti nelle prateria di alta quota, boschi di alta quota; valori bassi per la roccia nuda e neve


# cambiare la grandezza di movie window
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd) #cambia la frequanza di calcolo che ho utilizzato

#altra tecnica per compattare i dati: PCA
#rastePCA si trova nel pacchetto RStoolbox

sentpca <- rasterPCA(sent)

plot(sentpca$map)
#PC1 è simile all'informazione iniziale, man mano che si passa da una pCA all' altra si perde d'informazione
sentpca
#$call
#rasterPCA(img = sent)

#$model
#Call:
#princomp(cor = spca, covmat = covMat[[1]])

#Standard deviations:
 # Comp.1   Comp.2   Comp.3   Comp.4 
#77.33628 53.51455  5.76560  0.00000 

 #4  variables and  633612 observations.

#$map
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      :       PC1,       PC2,       PC3,       PC4 
#min values : -227.1124, -106.4863,  -74.6048,    0.0000 
#max values : 133.48720, 155.87991,  51.56744,   0.00000 


#attr(,"class")
#[1] "rasterPCA" "RStoolbox"


summary(sentpca$model)
#Importance of components:
                      #     Comp.1     Comp.2      Comp.3 Comp.4
#Standard deviation     77.3362848 53.5145531 5.765599616      0
#Proportion of Variance  0.6736804  0.3225753 0.003744348      0
#Cumulative Proportion   0.6736804  0.9962557 1.000000000      1
#Dunque la prima PCA spiega il 67.36804% dell'informazione originale

#21/05/2021
#continuazione codice iniziato il 19/05/2021
#la prima componente si chiama PC1
pc1 <- sentpca$map$PC1

#funzione focal-> movie window

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)
#dall'immagine originale si notano differenze geomorfologiche, la parte blu legata a quelle di prateria di alta quota è più omogenea (blu)
#aumento di variabilità nei colori rosa e verde-> zone di roccia 

#funzione source-> richiamare un pezzo di codice già realizzato
#salvare il pezzetto di codice e farlo partire dentro R
source("source_test_lezione.r")

library(raster)
library(RStoolbox)
# install.packages("RStoolbox")
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplots together
# install.packages("viridis")
library(viridis) # for ggplot colouring e serve per mettere direttamente una palette di colori senza citarla direttamente nel codice
source("source_ggplot.r")
#cosa c'è dentro source_ggplot.r?:
#creazione della finestra tramite la funzione ggplot
#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#per creare quindi una finestra vuota fare ggplot()
ggplot() +
#aggiungiamo il tipo di geometria usando la funzione geom_raster(usando i pixel)
geom_raster(pc1sd5,mapping=aes(x=x, y=y, fill=layer)) +
#estetiche: mapping(cosa vogliamo mappare:x,y,valore)
#alto a sinistra con la dev. standard la vediamo benissimo nell'immagine originata rispetto a quella originale
#vediamo benissimo dunque le variabilità ecologica, le componenti geomorfologiche 
scale_fill_viridis()+
#viridis è la scala di defoult del pacchetto 
ggtitle("Standard deviation of PC1 by viridis colour scale")
# metto untitolo al grafico

#metto la leggenda inferno
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")


# associo un oggetto alle varie leggende di colore quali viridis, magma e turbo
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale")

 
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")

 
p3 <- ggplot() + 
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + 
scale_fill_viridis(option = "turbo") + 
ggtitle("Standard deviation of PC1 by turbo colour scale")

grid.arrange(p1, p2, p3, nrow = 1)
#più grafici in una pagina e deriva dal pacchetto gridExtra

#viridis e magma portano colori contrastati nei valori alti, turbo invece mostra il giallo come valori medi e non è molto indicato per far risaltare qualcosa 

#--------------------------------------------------------------------------------------

# 11 R_code_no2.r
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


#-------------------------------------------------------------------------------------
# 12 R_code_spectral_signatures.r
#16/07/2021
#R_code_spectral_signatures.r
#Oggi lavoriamo con le firme spettrali *_*

# carichiamo il pacchetto raster
library(raster)
#install.packages("rgdal")
library(rgdal)
library(ggplot2)

#facciamo il nostro setwork directory
setwd("C:/lab/")

#e carichiamo tramite la funzione brick(che carica tutte le bande)

defor2 <- brick("defor2.jpg")

#defor2.1, defor2.2, defor 2.3
#NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist") #curva logistica aumentata artificialmente in cui aumenta la gamma di colori

#la funzione per creare le firme spettrali è la funzione click
#serve il pacchetto rgdal che è la libreria che serve a leggere qualsiasi tipo di dato
#viene usata in R per la parte vettoriale (punti, linee, ecc..)
#click fa parte del pacchetto raster serva a cliccare su una mappa e richiedere qualiasi tipo di informazioni
#l'informazione che nel nostro caso verrà fuori è relativa alla RIFLETTANZA
#id valore numerico=T(si), xy (informazione spaziale)=T (si), cell (andiamo a cliccare su un pixel)=T(si), type(point), pch=16(il tipo di point), cex=4

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#results:
#click sulla parte vegetale
#      x     y  cell  defor2.1 defor2.2 defor2.3
# 1 178.5 435.5 30293      206        6       19
#                       NIR       RED       GREEN
#click sul fiume riflettanze molto alte nelle rispettive bande, se avessimo avuto la banda del blu il valore sarebbe ancora più alto
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 571.5 245.5 166916       40       99      139

#creazione data.frame tabella con 3 colonne ; 3 bande ; foresta o acqua con i relativi valori
#dataframe per creare il grafico
# definiamo la prima colonna
band<- c(1,2,3)
#2 colonna
forest<-c(206,6,19)
#3 colonna
water<-c(40,99,139)
#data.frame crea la tabella 
spectrals<-data.frame(band, forest, water)

# band forest water
#1    1    206    40
#2    2      6    99
#3    3     19   139

ggplot(spectrals, aes(x=band)) + 
geom_line(aes(y=forest), color="green") +
geom_line(aes(y=water), color="blue") 

 
# plot the sepctral signatures
#chiamare la funzione "ggplot" 
#spectrals è il dataframe su cui va a lavorare
#aes-> estetica X= band, y=riflettanza (una linea per la foresta e una per l'acqua)
#geometrie del plot geom_line e definiamo l'estetica delle y e il colore
ggplot(spectrals, aes(x=band)) +
geom_line(aes(y=forest), color="green") + #alti valori di riflettanza nella banda del NIR, bassi nel rosso e un pochino più alti nella banda del verde
geom_line(aes(y=water), color="blue") + # valore basso nell NIR, nel rosso è un po più alta e nel verde altrettanto
labs(x="band",y="reflectance") #diamo il nome agli assi
# abbiamo un singolo pixel nelle 3 bande e vediamo la sia riflettanza

#analisi multitemporale

defor1<- brick("defor1.jpg")
plotRGB( defor1, r=1, g=2, b=3, stretch="lin")

#spectral signatures defor 1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#results:
#1 click su una variazione forte dove c'è stata forte deforestazione
#      x     y  cell  defor2.1 defor2.2 defor2.3
# 1 89.5 339.5 98662      233        11       33
#                       NIR       RED       GREEN
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 42.5 336.5 100717       218      16        38
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 64.5 341.5 97169        213       36       46
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 80.5 326.5 107895       208        2       22
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 76.5 374.5  73619       224       21       41

# faccio la stessa cosa con defor 2
plotRGB( defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")


#results:
#      x     y  cell  defor2.1 defor2.2 defor2.3
# 1 86.5 339.5 99033       197      163      151
#                       NIR       RED       GREEN
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 104.5 338.5 99768       149      157      133
#      x     y  cell  defor2.1 defor2.2 defor2.3
#1 110.5 354.5 88302       197      132      128
#      x     y   cell  defor2.1 defor2.2 defor2.3
#1 90.5 320.5  112660       169       166     149
#      x     y   cell  defor2.1 defor2.2 defor2.3
#1 97.5 309.5  120554       150      137      129

#creo il dataframe
band<-c(1,2,3)
time1<-c(223,11,83) #pixel 1 forest
time1p2<-c(218,16,38)
time2<-c(197,163,151) #pixel 2 water
time2p2<-c(149,157,133)
spectralst2<-data.frame(band, time1,time2,time1p2,time2p2)
#  band time1 time2
#1    1   223   197
#2    2    11   163
#3    3    83   151

#aggiungendo due pixel 
#  band time1 time2 time1p2 time2p2
#1    1   223   197     218     149
#2    2    11   163      16     157
#3    3    83   151      38     133


# plot the sepctral signatures di 2 pixel
ggplot(spectralst2, aes(x=band)) +
 geom_line(aes(y=time1), color="green") +
 geom_line(aes(y=time1p2), color="green") +
 geom_line(aes(y=time2), color="blue") +
 geom_line(aes(y=time2p2), color="blue") +
 labs(x="band",y="reflectance")
 
 
#funzione generating ramdom points -> genera i punti random all'interno dell'immagine
#funzione extract fa estrarre i valori delle bande dei pixel generati in modo randomizzato
#cambiare lo spessore della linea con linetype="dotted"

june_puzzler <- brick("june_puzzler.jpg")
plotRGB(june_puzzler, r=1, g=2, b=3, stretch="hist")

click(june_puzzler, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#     x     y  cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 153.5 422.5 41194            206            204              8
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 138.5 145.5 240619             69            149              2
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 507.5 128.5 253228             37             27             15

# define the columns of the dataset:
band <- c(1,2,3)
stratum1 <- c(206,204,8)
stratum2 <- c(69,149,2)
stratum3 <- c(37,27,15)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

ggplot(spectralsg, aes(x=band)) +
 geom_line(aes(y=stratum1), color="green") +
 geom_line(aes(y=stratum2), color="magenta") +
 geom_line(aes(y=stratum3), color="blue") +
 labs(x="band",y="reflectance")
 #---------------------------------------------------------------------------------------------
