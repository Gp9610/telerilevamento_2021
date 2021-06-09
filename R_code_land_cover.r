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

freq(d1c$map)
   # value  count
#[1,]     1  35751
#[2,]     2 305541

s2 <- 342726
prop2 <- freq(d2c$map) / s

# build a dataframe
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")


grid.arrange(p1, p2, nrow=1)

