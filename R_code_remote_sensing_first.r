# Il mio primo codice in R per il telerilevamento

# install.packages("raster")
library(raster) 
# library serve per richiamare i dati istallati precedentemente con install.packages("raster"). 
# Essendo in questo caso library interno a R non bisogno delle virgolette "".

setwd("C:/lab/") 
#Windows

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
# la funzione brick importa le immagini satellitari
# p224r63_2011 è l'oggetto

4447533*7
#4447533 è in numero di righe e colonne; 7 è il numero di bande
[1] 31132731
# numero totali di pixel

plot(p224r63_2011)
# la funzione plot mi fa visualizzare i dati in R

#color change
cl <-colorRampPalette(c("black","grey","light grey")) (100)
# inserisco una nuova gamma di colori -> nero, grigio, grigio chiaro; li chiudo in un "vettore" che è c
# quanti livelli di colori intermedi voglio avere (100)

plot(p224r63_2011, col=cl)
#ho cambiato la legenda dei colori per ogni banda
# col= colore che lo associo a cl con la mia nuova scala di colori; è un argomento della funzione plot; mi definisce i colori

cl <-colorRampPalette(c("blue","green","orange","red")) (100)
plot(p224r63_2011, col=cl)
# cambio i colori e vedo il risultato su R
