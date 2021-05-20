#23/04/2021
R_code_multivariate_analysis.r

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

plot(p224r63_2011)
 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#plottiamo la banda 1 dei pixel contro la banda 2 dei pixel, ossia i valori
#pch sarebbe il simbolo; cex è la dimensione dein punti
#infomazione di un punto su una banda è simile all'informazione dell'altro punto sull'altra banda
#forma di correlazione causuale

pairs(p224r63_2011)
#paris è una funzione diretta e plotta tutte le combinazione possibili delle variabili
#indice di correlazione(indice di Pearson) varia da -1 a 1 : correlati positivamente valore 1; correlati negativamente -1


p224r63_2011res

p224r63_2011res <- aggregate(p224r63_2011, fact=10)
 

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
 

    p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
 

    summary(p224r63_2011res_pca$model)
 

    p224r63_2011res_pca
