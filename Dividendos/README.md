# Índice de Reparto de Dividendos
## Este repositorio se utilizará para subir documentos y códigos relacionados con un proyecto que consiste en realizar un indice que refleje el reparto de dividendos de las empresas que participan en la bolsa de santiago
En este proyecto el trabajo realizado consistió en extraer, limpiar, y clasificar una base de datos de la página web de la bolsa de santiago, con la finalidad de identificar outliers y realizar
análisis que permita comprender el comportamiento de las industrias por sector, los pasos a seguir fueron los siguientes:

1) Extraer la base de datos directamente desde www.bolsadesantiago.com
2) Utilizar R studio para analizar el comportamiento de algunas variables y generar una nueva base que integra el valor total del reparto (P*Q)
3) Clasificar las empresas por sector, para esto se trabajó sobre la base generada, y se identificaron individualmente según su nemotécnico, de forma manual.
4) Se carga la base Clasificada en R studio para realizar bloxplots de los distintos sectores y la conversión en pesos.
  
Se adjuntan las bases y los scripts utilizados. 

### Definición de variables: 

*Se debe tener en cuenta, que estas definiciones son en base a una mera interpretación que se puede realizar sobre los datos, pueden estar sujetas a cambios.

- descrip_vc: Es una descripción breve del tipo de emisión que se realizó, se incluye la moneda y el valor exacto.
- fec_lim: Se trata de la fecha límite para realizar el pago de dividendos, aunque en la práctica la función de webscrap considera fec_lim como la fecha final para realizar la extracción de datos.
- fec_pago: Se trata de la fecha en que se realizará la emision efectiva, aunque en la práctica la función de webscrapping considera fec_pago como la fecha inicial para realizar la extracción de datos.
- moneda: Se trata de la moneda en que se realiza la emision de dividendos, se consideran CLP$, USD$ y EURO.
- nemo: Es la empresa que emite el dividendo.
- num_acc_ant : Se trata de el numero de acciones antiguas o anteriores (quizas son las repartidas en el ejercicio aterior)
- num_acc_der : Son las acciones que se emiten (Q)(Se asume porque es la variable de cantidad para la que se poseen más datos)
- num_acc_nue : Se trata de las acciones nuevas tras la emision 
- pre_ant_vc : 
- pre_ex_vc : 
- val_acc : Es el valor de las acciones (P)
- val_acc_F : Es una variable donde se categoriza la variable val_acc en base a parametros establecidos, donde los valores pueden ser, bajos, medios, altos o muy altos.
- tot_acc : Es una variable creada que señala P*Q osea, el monto total correspondiente al pago de dividendos
- tot_acc_F: Es una variable donde se categoriza la variable tot_acc en base a parametros establecidos, donde los valores pueden ser, bajos, medios, altos o muy altos.
- Nombre empresa: Es el nombre de la organización, identificado a través del nemotécnico.
- Clasificación: Corresponde al rubro de la empresa (servicios financieros, educacional, consumo, etc..)