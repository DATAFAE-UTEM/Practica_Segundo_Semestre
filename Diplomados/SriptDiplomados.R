install.packages("rstatix")
library(rstatix)
library(tidyverse)
library(dplyr)
library(lubridate)
library(readxl)
library(lubridate)
library(data.table)
library(ggplot2)
library(hrbrthemes)
library(babynames) # provide the dataset: a dataframe called babynames
library(dplyr)
#Cargando data
# file.choose()
ruta_excel <- "C:\\Users\\felip\\Desktop\\U\\Práctica\\Diplomados\\BaseDiplomadosEx.xlsx.xlsx"
ruta_excel_base_clasificada <- "C:\\Users\\felip\\Desktop\\U\\Práctica\\Diplomados\\Base_diplomados_clasificada.xlsx"
DiplomadosClasificados <- read_excel(ruta_excel_base_clasificada)
Diplomados <- read_excel(ruta_excel)

################ TRABAJANDO BASE DE DATOS CLASIFICADA ##########################

#### Identificando variables dentro de la columna Código ####
data.frame(table(DiplomadosClasificados$Código))

#### Creando bases separadas para cada diplomado UTEM para el cual hayan sustitutos ####

## Ordenando decreciente

DiplomadosClasificados <- DiplomadosClasificados[with(DiplomadosClasificados,order(-DiplomadosClasificados$Arancel)),]
Diplomados <- Diplomados[with(Diplomados,order(-Diplomados$Arancel)),]

DiplomadoSustitutosAlimentos <- filter(DiplomadosClasificados, Código == "Alimentos")
DiplomadoSustitutosBIM <- filter(DiplomadosClasificados, Código == "BIM")
DiplomadoSustitutosCalidad <- filter(DiplomadosClasificados, Código == "Calidad")
DiplomadoSustitutosDelictual <- filter(DiplomadosClasificados, Código == "Delictual")
DiplomadoSustitutosFinanzas <- filter(DiplomadosClasificados, Código == "Finanzas")
DiplomadoSustitutosGeomática <- filter(DiplomadosClasificados, Código == "Geomática")
DiplomadoSustitutosGestión <- filter(DiplomadosClasificados, Código == "Gestión")
DiplomadoSustitutosGestión_municipal <- filter(DiplomadosClasificados, Código == "Gestión_municipal")
DiplomadoSustitutosGestión_personas <- filter(DiplomadosClasificados, Código == "Gestión_personas")
DiplomadoSustitutosGestión_Pública <- filter(DiplomadosClasificados, Código == "Gestión_Pública")
DiplomadoSustitutosInnovación_y_tecnología <- filter(DiplomadosClasificados, Código == "Innovación y tecnología")
DiplomadoSustitutosMarketing <- filter(DiplomadosClasificados, Código == "Marketing")
DiplomadoSustitutosMediación <- filter(DiplomadosClasificados, Código == "Mediación")
DiplomadoSustitutosMigración <- filter(DiplomadosClasificados, Código == "Migración")
DiplomadoSustitutosNIIF <- filter(DiplomadosClasificados, Código == "NIIF")
DiplomadoSustitutosRecursos_Humanos <- filter(DiplomadosClasificados, Código == "Recursos_Humanos")


##################### TRABAJANDO BASE DIPLOMADOS #####################



#A ESTA BASE SE LE HICIERON CAMBIOS CORRESPONDIENTES 
##### AL RELLENO DE DATOS CON PROMEDIOS
#contando NA
sapply(Diplomados, function(Diplomados) sum(is.na(Diplomados)))
#eliminando na
Diplomados <- na.omit(Diplomados)
#comprobando
sapply(Diplomados, function(Diplomados) sum(is.na(Diplomados)))
#Tasando datos
str(Diplomados)

#Filtrando por top
DiplomadosTop <- filter(Diplomados, Top == "Si")
DiplomadosTopnt <- filter(Diplomados, Top == "No")

239/645

# Graficando distribución diplomados entre instituciones con gráfico de barras


############################ GRAFICO A ORDENAR, LE FALLÉ PROFE :C
ggplot(data = DiplomadosTop, aes(x = Institución)) +
  geom_bar(width = 0.9, fill = "Purple" ) +   
  ggtitle("Grafico de barra")+               
  xlab("Institución") +                    
  ylab("Diplomados en mercado")+                         
  coord_flip()+                              
  labs(fill = "Tipo" )  +
  theme_dark()









# Cantidad de diplomados PUC en el mercado
length(DiplomadosTop$Institución[DiplomadosTop$Institución == "pUC"])

# Cantidad de diplomados UdeC en el mercado
length(DiplomadosTop$Institución[DiplomadosTop$Institución == "UdeC"])

# % diplomados topnt
406/645

# Grafico barras
############## DISCULPE LAS MOLESTIAS PROFE 
ggplot(data = DiplomadosTopnt, aes(x = Institución)) +
  geom_bar(width = 0.9, fill = "magenta" ) +   
  ggtitle("Grafico de barra")+               
  xlab("Institución") +                    
  ylab("Diplomados en mercado")+                         
  coord_flip()+                              
  labs(fill = "Tipo" )  +
  theme_classic()

# Cantidad de diplomados UTC en el mercado
length(DiplomadosTopnt$Institución[DiplomadosTopnt$Institución == "UTC"])

# Cantidad de diplomados UdeC en el mercado
length(DiplomadosTopnt$Institución[DiplomadosTopnt$Institución == "UCeN"])

# Cantidad de diplomados utem en el mercado

length(DiplomadosTopnt$Institución[DiplomadosTopnt$Institución == "UTeM"])



#Buscando outliers en cupos x facultad

ggplot(data = DiplomadosTop, aes(x = Facultad, y = Cupos)) + 
  geom_jitter(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Facultad), alpha = 0.7) + 
  xlab('Facultad') + 
  ylab('Cupos') +
  ggtitle("Outliers en cupos por facultad en universidades en top") + 
  theme_gray()

# Filtrando por menores a 40

DiplomadosTop <- filter(DiplomadosTop, Cupos < 40)
DiplomadosTop <- filter(DiplomadosTop, Cupos > 15)

#comprobando

ggplot(data = DiplomadosTop, aes(x = Facultad, y = Cupos)) + 
  geom_jitter(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Facultad), alpha = 0.7) + 
  xlab('Facultad') + 
  ylab('Cupos') +
  ggtitle("Outliers en cupos por facultad en universidades en top") + 
  theme_gray()

# Buscando outliers en base fuera del top


ggplot(data = DiplomadosTopnt, aes(x = Facultad, y = Cupos)) + 
  geom_jitter(aes(color = Facultad), size = 2, alpha = 0.4) +
  geom_boxplot(aes(color = Facultad), alpha = 0.5) + 
  xlab('Facultad') + 
  ylab('Cupos') +
  ggtitle("Outliers en cupos por facultad en universidades fuera del top") + 
  theme_light()

# Eliminando outliers
DiplomadosTopnt <- filter(DiplomadosTopnt, Cupos < 40)
DiplomadosTopnt <- filter(DiplomadosTopnt, Cupos > 15)


#comprobando
ggplot(data = DiplomadosTopnt, aes(x = Facultad, y = Cupos)) + 
  geom_jitter(aes(color = Facultad), size = 2, alpha = 0.4) +
  geom_boxplot(aes(color = Facultad), alpha = 0.5) + 
  xlab('Facultad') + 
  ylab('Cupos') +
  ggtitle("Outliers en cupos por facultad en universidades fuera del top") + 
  theme_light()



# Graficando por facultad
######## ESTE GRAFICO TAMBIÉN DEBE SER ORDENADO
ggplot(data=DiplomadosTop, aes(x= Facultad, y=Arancel, fill= Institución)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue"))


# Cantidad de diplomados en top
length(DiplomadosTop$Facultad[DiplomadosTop$Facultad == "Administración y economía"])

length(DiplomadosTop$Facultad[DiplomadosTop$Facultad])

length(DiplomadosTop$Facultad[DiplomadosTop$Facultad == "Salud"])

103/220


# Lo mismo pero con las universidades fuera del top

# Al parecer hay presencia de outliers en arancel en la base de datos Topnt

ggplot(data = DiplomadosTopnt, aes(x = Facultad, y = Arancel)) + 
  geom_jitter(aes(color = Facultad), size = 2, alpha = 1) +
  geom_boxplot(aes(color = Facultad), alpha = 1) + 
  xlab('Facultad') + 
  ylab('Arancel EN MILLONES') +
  ggtitle("Outliers en Arancel por Facultad en Universidades fuera del top") + 
  theme_minimal()

#eliminando
DiplomadosTopnt <- filter(DiplomadosTopnt, Arancel < 5000000)
#comprobando
ggplot(data = DiplomadosTopnt, aes(x = Facultad, y = Arancel)) + 
  geom_jitter(aes(color = Facultad), size = 2, alpha = 1) +
  geom_boxplot(aes(color = Facultad), alpha = 1) + 
  xlab('Facultad') + 
  ylab('Arancel en millones') +
  ggtitle("Outliers en Arancel por Facultad en Universidades fuera del top") + 
  theme_minimal()

#Se considera aceptable

# Graficando por facultad ahora las fuera del top
########### último gráfico a ordenar
ggplot(data=DiplomadosTopnt, aes(x= Facultad, y=Meses, fill= Institución)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("blueviolet","darkmagenta","deeppink","indianred1",
                             "lightseagreen","magenta4","violet","blue","green",
                             "purple","mediumseagreen","red","mediumturquoise",
                             "darkmagenta","deeppink3","deeppink"))

# Administración y economía
# Cantidad de diplomados en topnt
length(DiplomadosTopnt$Facultad[DiplomadosTopnt$Facultad == "Administración y economía"])
length(DiplomadosTopnt$Facultad[DiplomadosTopnt$Facultad])
+88/376



##### Graficando en base a arancel, Horas e institución #####

# Graficando Alimentos

##### 08/11/21 PROBANDO COSAS NUEAS

### Ordenando de mayor a menor la base de datos 


ggplot(data=DiplomadoSustitutosAlimentos, aes(x=Horas, y=Arancel, fill=Institución, label=sprintf("%0.2f", round(Arancel, digits = 2)))) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_brewer(palette="Pastel2")+
  theme_dark()

### Graficando más bonito

ggplot(data = DiplomadoSustitutosAlimentos, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()

####### GRAFICO PERFECTO #######
ggplot(data = DiplomadoSustitutosAlimentos, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()





# Graficando BIM

#ordenando


DiplomadoSustitutosBIM <- DiplomadoSustitutosBIM[with(DiplomadoSustitutosBIM,order(-DiplomadoSustitutosBIM$Arancel)),]
DiplomadoSustitutosBIM <- filter(DiplomadoSustitutosBIM, Institución != "UFT")
ggplot(data=DiplomadoSustitutosBIM, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_brewer(palette="Pastel2")+
  theme_dark()

ggplot(data = DiplomadoSustitutosBIM, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Institución~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


## #GRAF DEF
ggplot(data = DiplomadoSustitutosBIM, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# Graficando Calidad
DiplomadoSustitutosCalidad <- DiplomadoSustitutosCalidad[with(DiplomadoSustitutosCalidad,order(-DiplomadoSustitutosCalidad$Arancel)),]
ggplot(data=DiplomadoSustitutosCalidad, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()

## Grafico bonito
ggplot(data = DiplomadoSustitutosCalidad, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel en millones') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


## #GRAF DEF
ggplot(data = DiplomadoSustitutosCalidad, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()



### Sacando unab por mentirosa
DiplomadoSustitutosCalidad <- filter(DiplomadoSustitutosCalidad, Institución != "UNAB")
ggplot(data = DiplomadoSustitutosCalidad, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()



## Grafico bonito denueo
ggplot(data = DiplomadoSustitutosCalidad, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel en millones') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()





# Graficando Delictual

ggplot(data=DiplomadoSustitutosDelictual, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_brewer(palette="Pastel2")+
  theme_dark()

#### GAFF BONITO

ggplot(data = DiplomadoSustitutosDelictual, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()



# Graficando Finanzas

ggplot(data=DiplomadoSustitutosFinanzas, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosFinanzas, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel en millones') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()



# Graficando Geomática

ggplot(data=DiplomadoSustitutosGeomática, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()

### PER GRAF
ggplot(data = DiplomadoSustitutosGeomática, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()





# Graficando Gestión

ggplot(data=DiplomadoSustitutosGestión, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosGestión, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()

ggplot(data = DiplomadosClasificados, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 2, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid() +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# Graficando Gestión municipal

ggplot(data=DiplomadoSustitutosGestión_municipal, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosGestión_municipal, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel en millones') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# Graficando Gestión Personas

ggplot(data=DiplomadoSustitutosGestión_personas, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()

### PER GRAF
ggplot(data = DiplomadoSustitutosGestión_personas, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# Graficando Gestión Puplica
ggplot(data=DiplomadoSustitutosGestión_Pública, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosGestión_Pública, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()




# Graficando Innovación y tecnología
ggplot(data=DiplomadoSustitutosInnovación_y_tecnología, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosGestión_Pública, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()

# Graficando Innovación y tecnología
ggplot(data=DiplomadoSustitutosMarketing, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosInnovación_y_tecnología, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# MARKETING

ggplot(data=DiplomadoSustitutosMarketing, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()

## PER GRAF
ggplot(data = DiplomadoSustitutosMarketing, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# Graficando Mediación
ggplot(data=DiplomadoSustitutosMediación, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosMediación, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()
# Graficando Migración
ggplot(data=DiplomadoSustitutosMigración, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosMigración, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()


# Graficando NIIF
ggplot(data=DiplomadoSustitutosNIIF, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()
### PER GRAF
ggplot(data = DiplomadoSustitutosNIIF, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()



# Graficando Recursos humanos 
ggplot(data=DiplomadoSustitutosRecursos_Humanos, aes(x=Horas, y=Arancel, fill=Institución)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_text(aes(label=Arancel), vjust=1.6, color="white",
            position = position_dodge(0.9), size=4.5)+
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue")) +
  theme_dark()

### PER GRAF
ggplot(data = DiplomadoSustitutosRecursos_Humanos, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 9, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()



#### Gráfico arancel por facultad y universidad
ggplot(data=DiplomadosTop, aes(x= Facultad, y=Arancel, fill= Institución)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue"))
## Sacando el más grande
DiplomadosTopSinAd <- filter(DiplomadosTop, Facultad != "Administración y economía")
### Graficando
ggplot(data=DiplomadosTopSinAd, aes(x= Facultad, y=Arancel, fill= Institución)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue"))


########## Gráficos y cambios ###########

DiplomadosSustitusJuntos <- na.omit(DiplomadosClasificados)
DiplomadosSustitusJuntos <- filter(DiplomadosSustitusJuntos, Facultad != "Salud", Facultad !="Veterinara")


str(DiplomadosSustitusJuntos)
## Dispersión de todas las universidades

ggplot(data = DiplomadosSustitusJuntos, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_smooth(aes(color = Facultad)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel en millones') + 
  ylab('Horas Diplomados') +
  ggtitle('Relación entre horas y arancel, por facultad') + 
  theme_minimal()

#### Con todas las Us
# Filtrando
data.frame(table(DiplomadosClasificados$Facultad))
GrafDiplFac <- filter(DiplomadosClasificados, Facultad != "Agronomía", Facultad != "Artes", Facultad != "Educación",
                      Facultad != "Industria", Facultad != "Innovación y Tecnología", Facultad != "Odontología",
                      Facultad != "Psicología", Facultad != "Salud", Facultad != "Veterinara")

### Graficadno todos los diplomados de las facultades dentro de las cuales hay oferta de diplomados
### por parte de la utem
ggplot(data = GrafDiplFac, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_smooth(aes(color = Facultad)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Arancel en millones') + 
  ylab('Horas Diplomados') +
  ggtitle('Relación entre horas y arancel, por facultad') + 
  theme_minimal()

#### Mejorando gráficos

ggplot(data = DiplomadosSustitusJuntos, aes(x = Arancel, y = Cupos)) + 
  geom_point(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_smooth(aes(color = Facultad)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Cupos') + 
  ylab('Arancel') +
  ggtitle('Distribución de cupos y arancel por facultad') + 
  theme_light()


# LIGADO A LO ANTERIOR

### Gráfico de dispersión para evaluar relación arancel horas
### Grafico todas Us
ggplot(data = Diplomados, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 2, alpha = 0.7) +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Dispersión entre Arancel y horas para todas las Us') + 
  theme_minimal()
cor.test(Diplomados$Arancel, Diplomados$Horas)



### Gráfico dispersión Top
ggplot(data = DiplomadosTop, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 4, alpha = 0.7) +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Dispersión entre Arancel y horas para Us fuera del top') + 
  theme_minimal()
cor.test(DiplomadosTop$Arancel, DiplomadosTop$Horas)

### Grafico dispersión topnt
ggplot(data = DiplomadosTopnt, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 4, alpha = 0.7) +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Dispersión entre Arancel y horas para Us fuera del top') + 
  theme_minimal()

cor.test(DiplomadosTopnt$Arancel, DiplomadosTopnt$Horas)

















# A continuación se realizan regresiones para cada facultad en las univerisdades top

Regresion <- lm(Cupos~Facultad + Horas + Arancel + Dcto + Modalidad + Meses + Doctorado + Ranking, DiplomadosTop)
summary(Regresion)
Regresion$coefficients



# Disperción para ver correlación

ggplot(data = DiplomadosTop, aes(x = Horas, y = Meses)) + 
  geom_point(aes(color = Horas), size = 2, alpha = 0.7) +
  xlab('Horas') + 
  ylab('Meses') +
  ggtitle('Relación Horas y meses') + 
  theme_minimal()

cor.test(DiplomadosTop$Horas,DiplomadosTop$Meses)

# creando nuevas regresiones

Regresion2 <- lm(Cupos~Facultad + Arancel + Dcto + Modalidad + Meses + Doctorado + Ranking, DiplomadosTop)
summary(Regresion2)

# Coeficientes
Regresion2$coefficients

Regresion3 <- lm(Cupos~Arancel + Dcto + Modalidad + Meses + Doctorado + Ranking, DiplomadosTop)
summary(Regresion3)
Regresion3$coefficients

Regresion4 <- lm(Cupos~Facultad + Arancel + Dcto + Modalidad + Meses + Ranking, DiplomadosTop)
summary(Regresion4)
Regresion4$coefficients



######## Regresiones Topnt Explicando Cupos ############## 


RegresionTopnt <- lm(Cupos~Facultad + Horas + Arancel + Dcto + Modalidad + Meses + Doctorado + Ranking, DiplomadosTopnt)
summary(RegresionTopnt)
Regresion$coefficients


# Se elimina horas y se crea una nueva regresión

RegresionTopnt2 <- lm(Cupos~Facultad + Arancel + Dcto + Modalidad + Meses + Doctorado + Ranking, DiplomadosTopnt)
summary(RegresionTopnt2)
RegresionTopnt2$coefficients







# se elimina modalidad y descuento

RegresionTopnt3 <- lm(Cupos~Facultad + Arancel + Meses + Doctorado + Ranking, DiplomadosTopnt)
summary(RegresionTopnt3)
RegresionTopnt3$coefficients

#probando
RegresionTopnt4 <- lm(Cupos~Facultad + Arancel + Meses + Modalidad + Doctorado + Ranking, DiplomadosTopnt)
summary(RegresionTopnt4)




##### Regresión con variable explicada Ranking con todas las Us


data.frame(table(DiplomadosRegresion$Facultad))


RegresiónRankingTotalPrototipo <- lm(Ranking~Facultad + Horas + Arancel + Dcto + Modalidad + Meses + Doctorado + Cupos, Diplomados)
summary(RegresiónRankingTotalPrototipo)
RegresiónRankingTotalPrototipo$coefficients

# se elimina meses y doctorados y dcto

RegresionTotal <- lm(Ranking~Facultad + Horas + Arancel + Modalidad + Cupos, Diplomados)
summary(RegresionTotal)
RegresionTotal$coefficients

#### Creando base de datos sin facultades con p > 0.05
DiplomadosRegresion <- filter(Diplomados, Facultad != "Agronomía", Facultad != "Odontología", Facultad != "psicología", Facultad != "Salud", Facultad != "Artes", Facultad != "Veterinaria", Facultad != "Seguridad y prevención")

## comprobando 

RegresionTotal <- lm(Ranking~Facultad + Horas + Arancel + Dcto + Modalidad + Cupos, DiplomadosRegresion)
summary(RegresionTotal)
RegresionTotal$coefficients



###### Explicando el ranking Us fuera del rankin
# Primero, crear base de datos diplomados Us a partir del df DiplomadosRegresion

DiplomadosRegresionTopnt <- filter(DiplomadosRegresion, Top == "No")


### Regresión

RegresionTpntPrototipo <- lm(Ranking~Facultad + Horas + Arancel + Dcto + Modalidad + Meses + Doctorado + Cupos, DiplomadosRegresionTopnt)
summary(RegresionTpntPrototipo)

data.frame(table(Diplomados$Facultad))


# p-value: < 2.2e-16 se rechaza la hipotesis nula, el modelo es válido en su conjunto
# En cuanto al r^2 ajustado es igual a 0.4387, no es tan preciso, sólo predice el 43,87%
# quizás sea bueno buscar otros modelos
# prefiero la segunda por el R


#significancia de variables:
#Agronomia: P < 0


####### DISPERSION ########### 
DiplomadosClasificados <- filter(DiplomadosClasificados, Arancel < 5000000 & Horas < 500)

ggplot(data = DiplomadosClasificados, aes(x = Arancel, y = Horas)) + 
  geom_point(aes(color = Institución), size = 2, alpha = 0.7) +
  geom_smooth(aes(color = Institución)) +
  facet_grid() +
  xlab('Arancel') + 
  ylab('Horas') +
  ggtitle('Relación entre horas y arancel similares a utem, por similitud e Institución') + 
  theme_minimal()











#Mayores a 15

DiplomadosTop <- filter(DiplomadosTop, Cupos > 15)

#comprobando
ggplot(data = DiplomadosTop, aes(x = Facultad, y = Cupos)) + 
  geom_jitter(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Facultad), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_gray()


# Buscando outliers en aranceles e instituciones
ggplot(data = DiplomadosTop, aes(x = Institución, y = Arancel)) + 
  geom_jitter(aes(color = Institución), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Institución), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_gray()



# 3 observaciones > a 3 5 millones, filtrando

DiplomadosTop <- filter(DiplomadosTop, Arancel < 5000000)

ggplot(data = DiplomadosTop, aes(x = Institución, y = Arancel)) + 
  geom_jitter(aes(color = Institución), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Institución), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_gray()

# Outliers por abajo
DiplomadosTop <- filter(DiplomadosTop, Arancel > 500000)

# Comprobando
ggplot(data = DiplomadosTop, aes(x = Institución, y = Arancel)) + 
  geom_jitter(aes(color = Institución), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Institución), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_gray()

# buscando el rango


DiplomadosTop <- filter(DiplomadosTop, Arancel < 5000000)
ggplot(data = DiplomadosTop, aes(x = Institución, y = Arancel)) + 
  geom_jitter(aes(color = Institución), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Institución), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_gray()


DiplomadosTop <- filter(DiplomadosTop, Arancel < 4000000)
DiplomadosTop <- filter(DiplomadosTop, Arancel < 3500000)
# comprobando

ggplot(data = DiplomadosTop, aes(x = Facultad, y = Arancel)) + 
  geom_jitter(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Facultad), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_minimal()


ggplot(data = DiplomadosTop, aes(x = Institución, y = Arancel)) + 
  geom_jitter(aes(color = Institución), size = 1, alpha = 0.7) +
  geom_boxplot(aes(color = Institución), alpha = 0.7) + 
  xlab('Tipo') + 
  ylab('Precio promedio') +
  ggtitle("Precio promedio segun tipo de palta") + 
  theme_gray()




#### DE aquí en adelante son cosas que se usaron en algún momento pero se decidió otro camino #### 

ggplot(data=Diplomados, aes(x= Cupos, y=Facultad, fill= Facultad)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("pink", "blue","purple","green","lightblue","red", "magenta", "darkblue",
                             "orange", "lightgreen", "aquamarine", "cadetblue4", "azure", "chocolate1","lightblue"))


ggplot(data = Diplomados_clean, aes(x = Modalidad)) +
  geom_bar(width = 0.6, fill = "blue" ) +   #width: ancho de la barra y fill: color de la barra
  ggtitle("Lugar de mordida")+               #ggtitle: titulo del grafico
  xlab("Lugar") +                    #xlab: nombre eje X
  ylab("Frecuencia")+                          #ylab: nombre eje Y 
  coord_flip()+                              #coord_flip: cambiar orientacion del grafico (de vertical a horizontal)
  labs(fill = "Tipo" ) +
  theme_minimal()




ggplot(data = Diplomados_clean, aes(x = Modalidad)) + geom_bar() 

ggplot(data = Diplomados_clean, aes(x = Cupos)) + geom_histogram()


ggplot(data = Diplomados_clean, aes(x = Dcto, y = Facultad)) + geom_point()


ggplot(data = Diplomados_clean, aes(x = Institución, y = Arancel)) + geom_boxplot()

##### más bonito #####

ggplot(data = DiplomadosTopnt, aes(x = Institución)) +
  geom_bar(width = 0.9, fill = "green" ) +   #width: ancho de la barra y fill: color de la barra
  ggtitle("Grafico de barra")+               #ggtitle: titulo del grafico
  xlab("Acrónimo institución") +                    #xlab: nombre eje X
  ylab("cantidad")+                          #ylab: nombre eje Y 
  coord_flip()+                              #coord_flip: cambiar orientacion del grafico (de vertical a horizontal)
  labs(fill = "Tipo" )  

###   HISTOGRAMA
ggplot(data = Diplomados_clean, aes(x = Cupos )) +
  geom_histogram(fill = "purple" ) + 
  ggtitle("Histograma")+ 
  xlab("Modalidad") +   
  ylab("cantidad")+ 
  coord_flip()+    
  labs(fill = "modalidad" )  

ggplot(data = Diplomados_clean, aes(x = Modalidad, fill = as.factor(Facultad))) + 
  geom_bar() + 
  xlab("modalidad") + 
  ylab("Cantidades") + 
  ggtitle("Gráfico de barras") +
  labs(fill = "Facultad") + 
  theme_dark()


ggplot(Diplomados_clean) + 
  geom_histogram(aes(x = Cupos, fill = Facultad)) + 
  xlab("Facultad") + 
  ylab("Frecuencia") + 
  ggtitle("Facultad") +
  theme_void()



ggplot(DiplomadosTopnt) + 
  geom_histogram(bins = 50, aes(x = Arancel, fill = Institución ), color = 'black') + 
  facet_grid(Facultad~., scales = 'free') +
  xlab("Cupos") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Cupos para las diferentes universidades y con sus respectivos descuentos") +
  theme_dark()



ggplot(data = Diplomados_clean, aes(x = Cupos, y = Arancel)) + 
  geom_point(aes(color = Facultad), size = 1, alpha = 0.7) +
  geom_smooth(aes(color = Facultad)) +
  facet_grid(Facultad~., scales = 'free') +
  xlab('Cupos') + 
  ylab('Arancel') +
  ggtitle('Distribución de cupos y arancel por facultad') + 
  theme_minimal()

