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
ColorRampPalette
