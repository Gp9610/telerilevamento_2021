#R_code_vegetation_indices.r

#INDICI DI VEGETAZIONE


#INDICI DI VEGETAZIONE
#IL CASO DELLA FORESTA AMAZZONICA
#DATI PREPROCESSATI LANSAT 30M    

library(raster)


setwd("C:/lab/") 
# Windows


defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#b1=NIR, b2=red, b3= green
    
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#tutta la parte rossa è la vegetazione che negli anni si perde e diventa suolo agricolo


