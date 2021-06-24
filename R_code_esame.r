#R_code_esame.r
#Lo scopo del progetto è quello di vedere la condizione vegetale dell'area naturale protetta "Bosco di Cerano" in prossimità della centrale termoelettrica Federico II situata a Cerano (Brindisi,Puglia)


setwd("C:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)
centrale<- brick ("boscocerano.png")
plot(centrale)

centrale
#class      : RasterBrick 
#dimensions : 892, 1369, 1221148, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1369, 0, 892  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/boscocerano.png 
#names      : boscocerano.1, boscocerano.2, boscocerano.3 
#min values :             0,             0,             0 
#max values :           255,           255,           255 



plotRGB(centrale, r=1, g=2, b=3, stretch="lin")
ggRGB(centrale, r=1, g=2, b=3, stretch="lin")
#il valore di un pixel di vegetazione sarà: nel blu e nel rosso la pianta assorbe per fare fotosintesi e quindi avrà un valore molto basso
# nella banda del verde a causa del mesofillo fogliare rifletterà la luce quindi avrà un valore alto
centralec <- unsuperClass(centrale,nClasses=20)
plot(centralec$map)




#different vegetation index
dvi1 <- centrale$boscocerano.1 - centrale$boscocerano.2
plot(dvi1)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)
# specifying a color scheme
plot(dvi1, col=cl, main="DVI ") 
#così abbiamo il modo di visualizzare il DVI appena calcolato

#spectralIndices dove calcoliamo in modo efficiente indici multispettrali come NDVI
vi <- spectralIndices(centrale, green = 3, red = 2, nir = 1)
plot(vi, col=cl)

# calcolo la media nell'indice di vegetazione NDVI


centrale_pca <- rasterPCA(centrale)
summary(centrale_pca$model)
Importance of components:
                           Comp.1     Comp.2      Comp.3
#Standard deviation     67.9068335 13.9495883 5.936837677
#Proportion of Variance  0.9525245  0.0401950 0.007280472
#Cumulative Proportion   0.9525245  0.9927195 1.000000000
plot(centrale_pca$map)
plotRGB(centrale_pca$map, r=1, g=2, b=3, stretch="lin")

centralepc1 <- centrale_pca$map$PC1
centralepc1sd5 <- focal(centralepc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(centralepc1sd5, col=clsd)


