#16/04/2021
#R_code_knitr.r
setwd("C:/lab/")
#funzione stitch:report automatico
library(knitr)
#inizialmente faccio copia e incolla del codice precedentemente fatto con i dati della Groellandia su blocco note di windows, e lo salvo come R_code_greenland.r" nella cartella lab
#applico la funzione stitch
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#Error in file(con, "r") : non posso aprire questa connessione
#Inoltre: Warning message:
#In file(con, "r") :
 # cannot open file 'R_code_greenland.r': No such file or directory
#come risolvere il problema: ho salvato il file di testo R_code_greenland.r, e windows non mi mostrava l'estenzione"vera", per cui devo aggiungere io l'estenzione ".txt"
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#si è generato un file nella cartella lab R_code_greenland.r.tex
#come generare un pdf da un file tex
#overleaf si possono usare file latex
