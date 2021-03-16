# Il mio primo codice in R per il telerilevamento

# install.packages("raster")
library(raster)

setwd ("C:/lab/") #Windows

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

4447533*7
[1] 31132731
#numero di pixel

plot(p224r63_2011)
