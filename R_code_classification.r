21/04/2021
R_code_classification.r
#il processo di classificazione è un processo che accorpa i pixel con valori simili e una volta accoprti questi rappresentano una "classe"


setwd("C:/lab/") 
# Windows

#salviamo l'immagine "Solar_Orbiter_s_first_views_of_the_Sun_pillars" nella cartella lab
#l'immagine rappresenta attraverso gli ultravioletti dei livelli energetici all'interno del sole
#nella nostra immagine vediamo esplosioni di gas piuttosto potenti sulla destra
#nella parte centrale possiamo notare situazioni a più bassa energia
#situazioni intermedie nella parte grigia tra la parte centrale e le esplosioni
#ora carichiamo l'immagine usando la funzione brick che pesca l'immagine che si trova fuori R

library(raster)
library(RStoolbox)
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

so
#class      : RasterBrick 
#dimensions : 1157, 1920, 2221440, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1920, 0, 1157  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg 
#names      : Solar_Orbiter_s_first_views_of_the_Sun_pillars.1, Solar_Orbiter_s_first_views_of_the_Sun_pillars.2, Solar_Orbiter_s_first_views_of_the_Sun_pillars.3 
#min values :                                                0,                                                0,                                                0 
#max values :                                              255,                                              255,                                              255 



#visualize RGB levels
plotRGB(so, 1,2,3,stretch="lin")

# come fa il software a classificare l'immagine?
# all'interno della nostra immagine una volta montata in RGB noi abbiamo ad esempio un pixel di boisco e i pixel li vediamo nella banda del blu, del verde e del rosso
# il valore di un pixel di vegetazione sarà: nel blu e nel rosso la pianta assorbe per fare fotosintesi e quindi avrà un valore molto basso
# nella banda del verde a causa del mesofillo fogliare rifletterà la luve quindi avrà un valore alto
# incrociando i valori delle 3 bande avremo un certo pixel e così via...
# creazioni di classi da pixel campione nello spazio multi-spettrale dove gli assi sono le bande
# il software andrà a classificare tutti gli altri pixel dell'immagine come funzione del training-set che si è creato
# processo chiamato di somiglianza massima
# in questo caso ilsoftware tira fuori direttamente il training set
# classificazione non supervisionata: non c'è un impatto dell'utente nel definire a monte le classi
# unsupervised classification
# funzione UnsuperClass opera la classificazione non supervisionata

soc <- unsuperClass(so,nClasses=3)

# unsuperClass ha creato in uscito un modello e la mappa 
#nel plottaggio dobbiamo plottare solo la mappa
#plot(soc$map) per legare la mappa

plot(soc$map)
#set.seed per avere tutti la stessa immagine


so1 <- unsuperClass(so,nClasses=20)
plot(so1$map)

sun <- brick("Solar_Orbiter_s_first_view_of_the_Sun.png")
plotRGB(sun, 1,2,3,stretch="lin")
sun1 <- unsuperClass(sun,nClasses=3)
plot(sun1$map)
sun2 <- unsuperClass(sun,nClasses=20)
plot(sun2$map)

#sensori passivi sono quelli che stiamo utilizzando
#fonte interna/diretta es. il laser/radar

