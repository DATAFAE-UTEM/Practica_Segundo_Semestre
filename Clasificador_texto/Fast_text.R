install.packages("fastTextR")
library(fastTextR)
library(tidyverse)
library(readxl)

file.choose()
ruta_excel <- "/Users/franciscoyorio/Documents/Rstudio/Fast text/Modelo_entrenamiento.xlsx"
agent_data <- read_xlsx(ruta_excel)
str(agent_data)
getwd()
#setwd("/Users/franciscoyorio/Documents/Rstudio/Fast text")
agent_data$texto <- tolower(agent_data$Texto)


#Modelo 1
set.seed(1000)
model1_data <- tibble(
  label = paste0('__label__', agent_data$Modelo1),
  text = agent_data$Texto
  )

model1_sample <- sample.int(n = nrow(model1_data), size = floor(.80*nrow(model1_data)), replace = F)
#str(model1_data)

model1_train <- model1_data[model1_sample, ]
model1_test  <- model1_data[-model1_sample, ]

write_delim(model1_data, "model1_data.csv", delim = " ", quote = "none")
write_delim(model1_train, "model1_train.csv", delim = " ", quote = "none")
write_delim(model1_test, "model1_test.csv", delim = " ", quote = "none")

#Modelo 2
set.seed(2000)

model2_data <- tibble(
  label = paste0('__label__', agent_data$Modelo2),
  text = agent_data$texto
)

model2_sample <- sample.int(n = nrow(model2_data), size = floor(.80*nrow(model2_data)), replace = F)
model2_train <- model2_data[model2_sample, ]
model2_test  <- model2_data[-model2_sample, ]

write_delim(model2_data, "model2_data.csv", delim = " ", quote = "none")
write_delim(model2_train, "model2_train.csv", delim = " ", quote = "none")
write_delim(model2_test, "model2_test.csv", delim = " ", quote = "none")

#Modelo 2 V2
model2_V2_data <-model2_data %>% filter(label != "__label__490",
                                        label != "__label__390",
                                        label != "__label__230")

model2_V2_sample <- sample.int(n = nrow(model2_V2_data), size = floor(.80*nrow(model2_V2_data)), replace = F)
model2_V2_train <- model2_V2_data[model2_V2_sample, ]
model2_V2_test  <- model2_V2_data[-model2_V2_sample, ]

write_delim(model2_V2_data, "model2_V2_data.csv", delim = " ", quote = "none")
write_delim(model2_V2_train, "model2_V2_train.csv", delim = " ", quote = "none")
write_delim(model2_V2_test, "model2_V2_test.csv", delim = " ", quote = "none")



#Modelo 3
set.seed(3000)

model3_data <- tibble(
  label = paste0('__label__', agent_data$Modelo3),
  text = agent_data$texto
)

model3_sample <- sample.int(n = nrow(model3_data), size = floor(.80*nrow(model3_data)), replace = F)
model3_train <- model3_data[model1_sample, ]
model3_test  <- model3_data[-model1_sample, ]

write_delim(model3_data, "model3_data.csv", delim = " ", quote = "none")
write_delim(model3_train, "model3_train.csv", delim = " ", quote = "none")
write_delim(model3_test, "model3_test.csv", delim = " ", quote = "none")

#Entrenamiento de modelos
model_control <- ft_control(learning_rate = 0.05,
                            verbose = 1)
#Model1
model1 <- ft_train("model1_train.csv", method="supervised", control = model_control)
ft_save(model1, "model1.bin", what = "model")
ft_test(model1, "model1_test.csv", k = 1L, threshold = 0)


#Model 2
model2 <- ft_train("model2_train.csv", method="supervised", control = model_control)
ft_save(model2, "model2.bin", what = "model")
ft_test(model2, "model2_test.csv", k = 1L, threshold = 0)

#Model 2 V2
model2_V2 <- ft_train("model2_V2_train.csv", method="supervised", control = model_control)
ft_save(model2_V2, "model2_v2.bin", what = "model")
ft_test(model2_V2, "model2_V2_test.csv", k = 1L, threshold = 0)


#Model 3

model3 <- ft_train("model3_train.csv", method="supervised", control = model_control)
ft_save(model3, "model3.bin", what = "model")
ft_test(model3, "model3_test.csv", k = 1L, threshold = 0)


#Predicción 
ft_predict(model1, "Lugar Accidente. VÍA PUBLICA . Num Siniestro.8079397.Que Hacía.TRABAJADOR REPARTIDOR DE PIZZAS SE ENCONTRABA REALIZANDO REPARTO EN MOTOCICLETA..Cómo Ocurrió.TRABAJADOR REFIERE QUE EL DÍA DE HOY AL PASAR POR OYO EN MOTOCICLETA SE GOLPEA TESTICULO IZQUIERDO CON ESTANQUE DE GASOLINA DE MOTOCICLETA. .Trabajo Habitual.REPARTIDOR.Diagnóstico.CONTUSION DE GENITALES MASCULINOS...Caso Anamnesis.REPARTIDOR DE PIZZA. HOY CERCAD E LAS 13:30 IBA CAMINO A REPARTO EN MOTO Y PASA POR UN HOY Y SE GOLPEA CN ESTANQUE DE LMOTO EN  TESTICULO IZQ. SIENTE DOLOR TOLERABLE LA PRIMERA HOEA PERO LUEGO EL DOLRO SE EXTIENDE A REGION LUMBAR IZQ Y M INF IZQ.ALERGIA MED: NEGEFNC RON: NEG.Examen Físico..Nota Clínica.")


