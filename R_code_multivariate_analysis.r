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

