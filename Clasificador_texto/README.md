# Clasificador de texto.
## Este proyecto forma parte del trabajo que desempeñaron los practicantes el semestre pasado. Consiste básicamente en un código que extrae links 
desde la CMF, que almacena noticias financieras en formato PDF, para posteriormente, utilizando R, extraer esa información, limpiarla, e interpretarla en 
un análisis automático de texto. Nuestro rol en este proyecto es el de aportar en esta última parte, que consiste en buscar los criterios con los cuales el 
interpretador puede basarse para clasificar la información, estableciendo esquemas similares a mapas mentales que explican qué es lo que dice una noticia 
o un texto basándose en la repetición de palabras clave o la consecutividad de términos específicos.

Los pasos a seguir fueron los siguientes:
1) Probar los códigos de extracción y procesamiento de datos pertenecientes al proyecto.
2) Una vez comprendida la dinámica para interpretar la información, se realiza un mapa mental y una base de datos, donde se consideran las palabras clave de los resúmenes de 200 hechos esenciales (la muestra es de más de 16.000), además de su respectiva cñasificación (Esta puede ser Positiva, Negativa, Doble (Cuando la noticia conlleva consecuencias tanto positivas como negativas dependiendo de la perspectiva), o Neutro (Cuando el hecho esencial no se puede clasificar, o no tiene ninguna connotación).
3) Una vez realizada la base de datos que contenía los resumenes de las noticias y y su respectiva clasificación, se procedió a realizar un modelo de entrenamiento en R con el paquete FastText.
4) El siguiente paso fue identificar a qué noticia real pertenecía cada resumen realizado para realizar una nueva base de entrenamiento, esta vez con las transcripciones completas de los hechos esenciales y no resumenes manueles (Esto ameritó un proceso previo de limpieza de la data y detección de stop-words)
5) Se Prueba el modelo en una base que posee todas las obervaciones.