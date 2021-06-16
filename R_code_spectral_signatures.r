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
 
