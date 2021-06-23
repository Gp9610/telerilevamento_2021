esame_5_luglio_telerilevamento.r
setwd("C:/lab/")
library(raster)

brindisi<-brick("Brindisi_Italy_pillars.jpg")
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

plot(brindisi)
cl<-colorRampPalette(c("red","blue","green"))(100)
plot(brindisi,col=cl)

plot(brindisi$Brindisi_Italy_pillars.1)
cl1<-colorRampPalette(c("red","blue","green"))(100)
plot(brindisi$Brindisi_Italy_pillars.1,col=cl1)

plot(brindisi$Brindisi_Italy_pillars.2)


plot(brindisi$Brindisi_Italy_pillars.3)


par(mfrow=c(1,1))
#1 riga e 1 colonna
plot(brindisi$Brindisi_Italy_pillars.1)
plot(brindisi$Brindisi_Italy_pillars.2)
plot(brindisi$Brindisi_Italy_pillars.3)

par(mfrow=c(2,2)) 
cl1 <-colorRampPalette(c(" dark blue","blue","light blue")) (100)
plot(brindisi$Brindisi_Italy_pillars.1, col=cl1)

cl2 <-colorRampPalette(c(" dark green"," green","light green")) (100)
plot(brindisi$Brindisi_Italy_pillars.2, col=cl2)

cl3 <-colorRampPalette(c(" dark red"," red","purple")) (100)
plot(brindisi$Brindisi_Italy_pillars.3, col=cl3)
