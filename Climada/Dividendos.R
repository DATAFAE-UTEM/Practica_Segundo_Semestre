#### Trabajando base de datos dividendo ####

install.packages("lubridate")
install.packages("tidyverse")
install.packages("tidybayes")
install.packages("assertive")
library(assertive)
library(tidyverse)
library(tidybayes)
library(dplyr)
library(ggplot2)
library(lubridate)
library(readxl)
library(lubridate)
#### Importando base de datos .xls

file.choose()
ruta_excel <- "C:\\Users\\felip\\Desktop\\U\\Práctica\\Dividendos\\Dividendos_2015_2021.xlsx"
Dividendos <- read_excel(ruta_excel)

#### contando los NA de la base por atributo
sapply(Dividendos, function(Dividendos) sum(is.na(Dividendos)))


### Eliminando NA de la base de datos
Dividendos <- Dividendos[Dividendos$moneda!="NaN",]

### Sale mal, probando na.omit

Dividendos2 <- na.omit(Dividendos)
Dividendos2
#### Comprobando si aún hay NA
sapply(Dividendos2, function(Dividendos2) sum(is.na(Dividendos2)))



boxplot(Dividendos2$val_acc)
boxplot(Dividendos2$num_acc_der)



