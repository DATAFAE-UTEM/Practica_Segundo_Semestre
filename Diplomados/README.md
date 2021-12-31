# Impacto y comparativa de los diplomados UTEM en el mercado.
## Este repositorio se utilizará para subir documentos y códigos relacionados con un proyecto que consiste en generar una guía o indicador que permita discernir cómo se están desarrollando los diplomados UTEM en relación a sus competidores.
En este proyecto el trabajo realizado consistió en generar una base de datos que incluyera variables relacionadas a los diplomados que imparten las distintas universidades, para luego hacer comparaciones gráficas y análisis al respecto en base a los atributos de aquellas instutuciones con las que UTEM compite nacionalmente (el criterio para seleccionar a las universidades se basó en un ranking web
mundial de universidades llevado a cabo por el Consejo Superior de Investigaciones Cientificas (CSIC), el cual es una organizacion española independiente y autónoma financiada por el estado, se consideran criterios de posicion por Impacto, Apertura y Exelencia). Los pasos a seguir fueron los siguientes:

1) Seleccionar aquellas universidades con las que UTEM compite (5 para arriba y 5 para abajo en el ranking) además de las 8 primeras emblemáticas
2) Acceder a los portales de educación continua de cada institución para descargar la información relacionada a los programas de diplomados (En primera instancia esto se pensó en hacerse de forma automática con un scrapping, pero al ser varios portales, con varias facultadas, con varias estructuras de datos distintas, se opta por hacerlo de forma manual por costo de oportunidad. De esta forma, se creó una base de datos de 647 diplomados pertenecientes a 19 instituciones (incluyendo a UTEM)  
3) Con la data reunida se genera una base de datos, que utiliza las siguientes variables:

- Institución: Es la institución educativa a la que corresponde el diplomado.

- Facultad: Es la facultad a la que pertenece el diplomado. En algunos casos, corresponde al área en que se puede clasificar.

- Programa: Se trata del nombre del diplomado.

- Horas: Es la duración en horas cronológicas del programa.

- Arancel: Es el arancel mensual de inscribirse al curso, en algunos pocos casos, los precios estaban en UF, se hizo una conversión al valor actual del peso.

- Dcto: Refleja si es que la universidad aplica u ofrece descuentos de algún tipo para quien quiera optar al diplomado.

- Modalidad: Es la modalidad en la que se desarrollan los cursos de diplomado, esta puede ser presencial, online (e-learning), y semipresencial (b-learning).

- Meses: Es la duración en meses del programa.

- Doctorado: Representa el porcentaje de profesores doctorados dentro del cuerpo docente que imparte el diplomado.

- Cupos: Es la cantidad de cupos disponibles para cada diplomado, se hace el supuesto de que un alto número en cupo de participantes se traduce en una alta demanda por programa.


4) Se analiza la base de datos con el objetivo de identificar para cada diplomado UTEM los programas sustitutos o “equivalentes” en otras universidades, 
comparando los aranceles, las horas cronológicas y el porcentaje de profesores con docorados que los imparten, se realizaron gráficos comparativos para visualizar 
las diferencias entre UTEM y sus competidores, además se detallaron observaciones con recomendaciones de cómo volver más competitivos aquellos diplomados.

5) En caso de no encontrarse ningún sustituto en otra institución, se procede a realizar un análisis de Google Trends, ya que si bien el no encontrar 
equivalentes es la primera señal para determinar que el diplomado no es competitivo, también podría ser un caso de innovación por parte de UTEM 
que merece análisis en base a las tendencias del interés de las personas. En base a los resultados obtenidos en Google Trends, se establecen criterios de interpretación 
para evaluar cada diplomado individualmente y determinar si es un tema que despierta el interés del público, o más bien, es un tema poco interesante.

6) De modo adicional, se realizó un análisis de regresiones en base a la variable ranking, el cual permitió evidenciar algunas relaciones que nos permitieron optar por las variables escogidas para el análisis comparativo, entre otras desiciones. 

7) Finalmente, se realiza una tabla que resuma los resultados obtenidos y que incluya las recomendaciones realizadas para cada programa. 


