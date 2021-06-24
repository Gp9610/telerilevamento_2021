#R_code_esame.r
#Lo scopo del progetto è quello di vedere la condizione vegetale dell'area naturale protetta "Bosco di Cerano" in prossimità della centrale termoelettrica Federico II situata a Cerano (Brindisi,Puglia)


setwd("C:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)
brindisi<- brick ("Brindisi_Italy_pillars.jpg")
plot(brindisi)

brindisi
#class      : RasterBrick 
#dimensions : 1223, 1920, 2348160, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1920, 0, 1223  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/Brindisi_Italy_pillars.jpg 
#names      : Brindisi_Italy_pillars.1, Brindisi_Italy_pillars.2, Brindisi_Italy_pillars.3 
#min values :                        0,                        0,                        0 
#max values :                      255,                      255,                      255



plotRGB(brindisi, r=1, g=2, b=3, stretch="lin")
ggRGB(brindisi, r=1, g=2, b=3, stretch="lin")
#il valore di un pixel di vegetazione sarà: nel blu e nel rosso la pianta assorbe per fare fotosintesi e quindi avrà un valore molto basso
# nella banda del verde a causa del mesofillo fogliare rifletterà la luce quindi avrà un valore alto
brindisiusc <- unsuperClass(brindisi,nClasses=20)
plot(brindisiusc$map)




#different vegetation index
dvi1 <- brindisi$Brindisi_Italy_pillars.1 - brindisi$Brindisi_Italy_pillars.2
plot(dvi1)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)
# specifying a color scheme
plot(dvi1, col=cl, main="DVI ") 
#così abbiamo il modo di visualizzare il DVI appena calcolato

#spectralIndices dove calcoliamo in modo efficiente indici multispettrali come NDVI
vi <- spectralIndices(brindisi, green = 3, red = 2, nir = 1)
plot(vi, col=cl)

# calcolo la media nell'indice di vegetazione NDVI


brindisi_pca <- rasterPCA(brindisi)
summary(brindisi_pca$model)
#Importance of components:
#                           Comp.1      Comp.2      Comp.3
#Standard deviation     80.3435354 20.28246952 12.50466476
#Proportion of Variance  0.9191572  0.05857733  0.02226548
#Cumulative Proportion   0.9191572  0.97773452  1.00000000
plot(brindisi_pca$map)
plotRGB(brindisi_pca$map, r=1, g=2, b=3, stretch="lin")

brindisipc1 <- brindisi_pca$map$PC1
brindisipc1sd <- focal(brindisipc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(brindisipc1sd, col=clsd)


