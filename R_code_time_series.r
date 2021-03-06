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
[[1]]
class      : RasterLayer 
dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
resolution : 1546.869, 1546.898  (x, y)
extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/Greenland/lst_2000.tif 
names      : lst_2000 
values     : 0, 65535  (min, max)


[[2]]
class      : RasterLayer 
dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
resolution : 1546.869, 1546.898  (x, y)
extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/Greenland/lst_2005.tif 
names      : lst_2005 
values     : 0, 65535  (min, max)


[[3]]
class      : RasterLayer 
dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
resolution : 1546.869, 1546.898  (x, y)
extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/Greenland/lst_2010.tif 
names      : lst_2010 
values     : 0, 65535  (min, max)


[[4]]
class      : RasterLayer 
dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
resolution : 1546.869, 1546.898  (x, y)
extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/Greenland/lst_2015.tif 
names      : lst_2015 
values     : 0, 65535  (min, max)


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



