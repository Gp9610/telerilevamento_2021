#14/04/2021
#R_code_copernicus.r
#Visualizing Copernicus data

#Prima operazione: vedere se abbiamo le librerie necessarie
# Librerie: 
 library(raster)

# library(ncdf4) -> questa la devo istallare
# install.packages("ncdf4")
library(ncdf4)

setwd("C:/lab/")

albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
#è un raster layer, cioè ha dei pixel con unità minima del file
#la risoluzione è in coordinate geografiche, ossia in gradi
#l'estenzione possibile dei gradi longitudine e latitudine
# sistema di riferimento WGS84

#non usiamo lo schema RGB perchè abbiamo un singolo strato
#useremo una colorRampPalette, e decideremo i colori da utilizzare
cl <- colorRampPalette(c("lightblue","green","red","yellow")) (100)
plot(albedo,col=cl)
#ricampionare il dataset
#per aggregare i nostri pixel-> aggregate: immagine con i pixel
#maggiore è il numero dei pixel maggiore è il peso dell'immagine
#prendo un pixel più grande ed estraggo la media dei valori all' interno-> 
# trasformo la mia immagine di n pixel a un nemro inferiore di pixel
#fattore "fact" diminuiso linermente i pixel (100x100pixel=1pixel)
#è un ricampiomento bi-lineare
albedores <- aggregate(albedo, fact=100)
#il numero di celle rispetto a prima è diminuito e molto più veloce da visualizzare
plot(albedores, col=cl)

#install.packages("knitr")
#install.packages("RStoolbox")
#library(knitr)
#library(RStoolbox)



