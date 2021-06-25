#R_code_esame.r



setwd("C:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)
 setwd("C:/esame/S2B_MSIL2A_20210529T094029_N0300_R036_T34TBL_20210529T125848.SAFE/GRANULE/L2A_T34TBL_A022084_20210529T094711/IMG_DATA/R10m/")
> library(raster)
Carico il pacchetto richiesto: sp
> a<- brick ("T34TBL_20210529T094029_B02_10m.jp2")
> plot(a)
> cl <-colorRampPalette(c("red","green","blue")) (100)
> plot(a,col=cl)

