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
