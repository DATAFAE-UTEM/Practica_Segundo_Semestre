#install.packages("SnowballC")
#install.packages("tidytext")
#install.packages("textstem")
#install.packages("syuzhet")

library(stringi)
library(tm)
library(ggplot2)
library(tidyverse)
library(tidytext)
library(readr)
library(SnowballC)
library(textstem)
library(syuzhet)
library(dplyr)

#file.choose()
### creando base csv full cochina
#ruta_datos <- "C:\\Users\\felip\\Desktop\\U\\Tesis\\TEXT\\Modelo.xlsx"
#Base_datos <- read_excel(ruta_datos,
                         sheet = "Base_sucia")

#### Guardando como csv
#write.csv(Base_datos,"Base_full_sucia.csv")

#file.choose()

### Creando bases
df_full <- read.csv("C:\\Users\\felip\\Desktop\\U\\Tesis\\TEXT\\Base_full_sucia.csv",encoding="latin1")%>% tbl_df()

df <- read.csv("C:\\Users\\felip\\Desktop\\U\\Tesis\\TEXT\\modelo_entrenamiento.csv", encoding="latin1")%>% tbl_df()


# Seleccionando sólo el texto
df_full_texto <- df_full
df_texto <- df

df_full_texto[1] <- NULL
df_full_texto[1] <- NULL
df_Texto[1] <- NULL
df_Texto[1] <- NULL

### sacar tildes
df_Texto$Texto <- chartr('áéíóúñ','aeioun',df_Texto$Texto)
df_full_texto$Texto <- chartr('áéíóúñ','aeioun',df_full_texto$Texto)

#### Transformando a Corpus
myCorpus <- VCorpus(VectorSource(df_Texto$Texto))
myCorpus_full <- VCorpus(VectorSource(df_full_texto$Texto))

## A minusculas
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
myCorpus_full <- tm_map(myCorpus_full, content_transformer(tolower))

#### sin numeros
myCorpus <- tm_map(myCorpus, removeNumbers)
myCorpus_full <- tm_map(myCorpus_full, removeNumbers)
### sin puntuacion
myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus_full <- tm_map(myCorpus_full, removePunctuation)
#### Tokenizado
myCorpusTokenized <- lapply(myCorpus, scan_tokenizer)
myCorpusTokenized_full <- lapply(myCorpus_full, scan_tokenizer)

### Lematizando
myCorpusLemmatized <- tm_map(myCorpus, lemmatize_strings)
myCorpusLemmatized <- tm_map(myCorpusLemmatized, removeWords, c(stopwords('spanish'),"ma","u"))
myCorpusLemmatized <- tm_map(myCorpusLemmatized, PlainTextDocument)

myCorpusLemmatized_full <- tm_map(myCorpus_full, lemmatize_strings)
myCorpusLemmatized_full <- tm_map(myCorpusLemmatized_full, removeWords, c(stopwords('spanish'),"ma","u"))
myCorpusLemmatized_full <- tm_map(myCorpusLemmatized_full, PlainTextDocument)

# Concatenar los corpus
myDf <- data.frame(text = sapply(myCorpusTokenized, paste, collapse = " "), stringsAsFactors = FALSE)
myDf2 <-data.frame(text = sapply(myCorpusLemmatized, paste, collapse = " "), stringsAsFactors = FALSE)

myDf_full <- data.frame(text = sapply(myCorpusTokenized_full, paste, collapse = " "), stringsAsFactors = FALSE)
myDf2_full <-data.frame(text = sapply(myCorpusLemmatized_full, paste, collapse = " "), stringsAsFactors = FALSE)

# limpieza stopwords
myDf <- VCorpus(VectorSource(myDf$text))
myDf2 <- VCorpus(VectorSource(myDf2$text))

myDf_full <- VCorpus(VectorSource(myDf_full$text))
myDf2_full <- VCorpus(VectorSource(myDf2_full$text))

myDf <- tm_map(myDf, removeWords, c(stopwords('spanish'),"ma","u"))
myDf2 <- tm_map(myDf2, removeWords, c(stopwords('spanish'),"ma","u"))

myDf_full <- tm_map(myDf, removeWords, c(stopwords('spanish'),"ma","u"))
myDf2_full <- tm_map(myDf2, removeWords, c(stopwords('spanish'),"ma","u"))
#### Transformando Corpus a df

myDf <- data.frame(text = sapply(myDf, paste, collapse = " "), stringsAsFactors = FALSE)
myDf2 <- data.frame(text = sapply(myDf2, paste, collapse = " "), stringsAsFactors = FALSE)

myDf_full <- data.frame(text = sapply(myDf_full, paste, collapse = " "), stringsAsFactors = FALSE)
myDf2_full <- data.frame(text = sapply(myDf2_full, paste, collapse = " "), stringsAsFactors = FALSE)
# Documento .csv con texto final
write.csv(myDf,"Base_entrenamiento_limpia")
write.csv(myDf2,"Base_entrenamiento_limpia_v2")

write.csv(myDf_full,"Base_full_limpia")
write.csv(myDf2_full,"Base_full_limpia_v2")

