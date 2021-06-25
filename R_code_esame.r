#R_code_esame.r




library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)
setwd("C:/esame/S2B_MSIL2A_20210529T094029_N0300_R036_T34TBL_20210529T125848.SAFE/GRANULE/L2A_T34TBL_A022084_20210529T094711/IMG_DATA/R10m/")
library(raster)

a<-raster ("T34TBL_20210529T094029_B02_10m.jp2")
plot(a)
b <- raster ("T34TBL_20210529T094029_B03_10m.jp2")
plot(b)
c <- raster ("T34TBL_20210529T094029_B04_10m.jp2")
plot(c)
d <- raster ("T34TBL_20210529T094029_B08_10m.jp2")
plot(d)
e <- raster ("T34TBL_20210529T094029_TCI_10m.jp2")
plot(e)
f<- raster ("T34TBL_20210529T094029_WVP_10m.jp2")
plot(f)

par(mfrow=c(2,2))
plot(a)
plot(b)
plot(c)
plot(d)
plot(e)
plot(f)


rlist <- list.files(pattern="T34TBL")
rlist
import <- lapply(rlist,raster)
import

Puglia <- stack (import)
plot (Puglia)
plotRGB(Puglia,1,2,3,stretch="Lin")

Puglia_pca <- rasterPCA(Pugliares)
summary(Puglia_pca$model)
#Importance of components:
                            Comp.1       Comp.2       Comp.3       Comp.4
#Standard deviation     757.5992757 186.20573363 30.837234237 2.208408e+01
#Proportion of Variance   0.9406042   0.05682166  0.001558399 7.992567e-04
#Cumulative Proportion    0.9406042   0.99742587  0.998984271 9.997835e-01
#                             Comp.5       Comp.6       Comp.7
#Standard deviation     1.138535e+01 1.430770e+00 6.466814e-01
#Proportion of Variance 2.124325e-04 3.354808e-06 6.853439e-07
#Cumulative Proportion  9.999960e-01 9.999993e-01 1.000000e+00
plot(Puglia_pca$map)

dvi1 <-e-f
dvi2<- a-b
difdvi <- dvi1 - dvi2

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

vi <- spectralIndices(Puglia, green = 3, red = 2, nir = 1)
plot(vi, col=cl)
