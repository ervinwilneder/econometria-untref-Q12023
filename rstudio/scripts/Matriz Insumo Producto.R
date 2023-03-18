##################################
####  Matriz Insumo Producto  ####
##################################

###############
#### Seteo ####
###############

oldpar <- par(no.readonly = TRUE)
setwd("C:/Users/carlo/Dropbox/Bases y Sintaxis Clases/Cuentas Nacionales")

####################################
#### Ejercicio de la carpeta de ####
####  Indicadores Económicos    ####
####################################

#Sean tres sectores (Agro, Industria, Servicio) con la siguiente matriz de demandas intermedias (DI)
(di<-matrix(c(43.48,34.78,30.43,4.35,33.48,41.61,62.17,6.74,57.95),nrow=3,byrow = TRUE))

#Sean los valores de VBP (valor Bruto de la Producción)
(vbp<-matrix(c(200,170,285),nrow=1))

#Hallamos la matriz de coeficientes técnicos como cociente entre cada valor de la matriz DI sobre el VBP
(mct<-cbind(di[,1]/vbp[,1],di[,2]/vbp[,2],di[,3]/vbp[,3]))

#Supongamos que China nos pide productos del agro por 100
(china<-matrix(c(100,0,0),nrow=3))

#Calculamos la producción necesaria nueva de cada sector para cubrir los 100 de China
(di1<-mct%*%china)

#Para producir eso nuevo, necesita mas nueva
(di2<-mct%*%di1)

#Para producir eso nuevo, necesita mas nueva y sigue y sigue . . . . . . . .donde los valores convergen a cero
(di3<-mct%*%di2)
(di4<-mct%*%di3)
(di5<-mct%*%di4)
(di6<-mct%*%di5)

#Vamos viendo como aumenta
china+di1+di2+di3+di4+di5+di6

#Para hallar el valor final
#Creamos una matriz identidad
i<-diag(3)

#Calculamos la matriz de requerimientos directos e indirectos
(mrdi<-solve(i-mct))

#¿Cuanto es necesario incrementar la produccion de cada sector para la demanda final de China?
(dfchina<-mrdi%*%china)

#Cada valor indica cuanto aumenta el VBP cuando agro demanda una unidad mas
apply(mrdi,2,sum)

#Segundo ejemplo
(china<-matrix(c(0,100,0),nrow=3))
(dfchina<-mrdi%*%china)

##############################
####  Matriz de Leontief  ####
####    con practica      ####
##############################

#Sean tres sectores (Agro, Industria, Servicio) con la siguiente matriz de demandas intermedias (DI)
(di<-matrix(c(600,400,1400,1500,800,700,900,2800,700),nrow=3,byrow = TRUE))

#La demanda esta dada por
(df<-matrix(c(600,1000,2600),nrow=3))

#Sean los valores de VBP (valor Bruto de la Producción) que es la suma total de cada fila
(vbp<-matrix(c(3000,4000,7000),nrow=1))

#Hallamos la matriz de coeficientes técnicos como cociente entre cada valor de la matriz DI sobre el VBP
(mct<-cbind(di[,1]/vbp[,1],di[,2]/vbp[,2],di[,3]/vbp[,3]))

#Creamos una matriz identidad
i<-diag(3)

#Calculamos la matriz de requerimientos directos e indirectos
(mrdi<-solve(i-mct))

#Supongamos que China nos pide productos del agro por 100
(china<-matrix(c(400,200,200),nrow=3))

#¿Cuanto es necesario incrementar la producción de cada sector para la demanda final de China?
(dfchina<-mrdi%*%china)

mrdi%*%(df+china)

##################################
####  Matriz Insumo-producto  ####
####   Ejemplo Practico.pdf   ####
##################################

#Sean tres sectores (Agro, Industria, Servicio) con la siguiente matriz de demandas intermedias (DI)
(di<-matrix(c(50,200,15,70,350,230,100,300,110),nrow=3,byrow = TRUE))

#La demanda final esta dada por
(df<-matrix(c(235,350,445),nrow=3))

#Sean los valores de VBP (valor Bruto de la Producción) que es la suma total de cada fila
(vbp<-matrix(c(500,1000,955),nrow=1))

#Hallamos la matriz de coeficientes técnicos como cociente entre cada valor de la matriz DI sobre el VBP
(mct<-cbind(di[,1]/vbp[,1],di[,2]/vbp[,2],di[,3]/vbp[,3]))

#Creamos una matriz identidad
i<-diag(3)

#Calculamos la matriz de requerimientos directos e indirectos
(mrdi<-solve(i-mct))

#Supongamos que China nos pide productos del agro por 100
(china<-matrix(c(100,0,0),nrow=3))

#¿Cuanto es necesario incrementar la producción de cada sector para la demanda final de China?
(dfchina<-mrdi%*%china)

mrdi%*%(df+china)


####TP de Microeconomia Maestria - Resolucion del Excel "Matriz Insumo-Producto####

#Levantamos las bases
sectores<-read.table("MIP - Sectores.txt")
VBP<-read.table("MIP - VBP.txt")

#Otra forma es leer directamente el Excel
library(readxl)

#Ojo que el rango esta corrido un fila para abajo
library(readxl)
sectores <- read_excel("Matriz Insumo Producto.xlsx", 
                       sheet = "Abierto-1", range = "c2:o15", 
                       col_types = c("numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                     "numeric"))

VBP <- read_excel("Z:/Archivos de la Facultad/UNTREF - Maestria/Microeconomia/Matriz Insumo Producto.xlsx", 
                  sheet = "Abierto-1", range = "c18:o18", 
                  col_names = FALSE, col_types = c("numeric", 
                                                   "numeric", "numeric", "numeric", 
                                                   "numeric", "numeric", "numeric", 
                                                   "numeric", "numeric", "numeric", 
                                                   "numeric", "numeric", "numeric"))

colnames(VBP)<-colnames(sectores)

#Hallamos la matriz de coeficientes tecnicos como cociente entre cada valor de la matriz DI sobre el VBP
#Creamos primero una matriz vacia
MCT<- c()
for(i in 1:nrow(sectores)){MCT <- cbind(MCT, sectores[[i]]/VBP[[i]])}
round(MCT,6)

#Para hallar el valor final
#Creamos una matriz identidad
i<-diag(nrow(sectores))

#Calculamos la matriz de requerimientos directos e indirectos (Matriz de Leontief)
(mrdi<-round(solve(i-MCT),6))


####Ejercicio del Apunte de Miller - Blair Pag 22####???

a<-matrix(c(150,500,200,100),nrow=2,byrow = T)
x<-matrix(c(1000,2000),nrow=1)
f<-matrix(c(600,1500))
ident<-diag(nrow(a))
ct<- c()
for(i in 1:ncol(a)){ct <- cbind(ct,a[,i]/x[,i])}
round(ct,6)
inv<-solve(ident-ct)
ff<-inv%*%f

ct2<- c()
for(i in 1:ncol(a)){ct2 <- cbind(ct2,ct[,i]*t(ff[i]))}
round(ct2,2)
