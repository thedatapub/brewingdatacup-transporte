# Reto Logístico
# Boozers SOS - Eduardo Ibarra y José Angel Ramírez
# Se debe pronosticar la distancia recorrida y los costos para mayo de 2018.
# Se deberán agregar otro tipo de variables para hacer el análisis, a fin de enriquecerlo (gasolina, criminalidad).

rm(list=ls())

#Abrir las librerías necesarias para limpiar y armar la base de datos.
library(tidyverse)
library(foreign)
library(utils)
library(reshape2)
library(stats)
library(ggplot2)
library(ggmap)

# Especificar las URL de entrada, salida
URLdata <- "../data"
URLout <- "../out"

# cargar los archivos
lugares <- read.csv(paste(URLdata,"lugares.csv", sep = "/"), header = T)
data <- read.csv(paste(URLdata,"data.csv", sep = "/"), header = T)
robo <- read.csv(paste(URLdata, "robocarretera.csv", sep = "/"), header = T)

# Cambiar nombres
names(lugares) <- c("lugar", "latitud", "longitud")
names(data) <- c("folio", "ruta", "fecha", "dia", "mes", "ano", "flota", "origen", "destino", "tarifa", "id", "transportista")
names(robo) <- c("ano", "mes", "entidad", "edo", "delito", "modalidad", "transporte", "cantidad", "poblacion")

# Procedimiento para cambiar tarifa a númerico
data$tarifa <- as.numeric(gsub('[$,]', '', data$tarifa))

#Cambiar fechas
data <- mutate(data, fecha = as.character(fecha))

# Transformar en tibble para facilitar su uso
tlugares <- as_tibble(lugares)
tdata <- as_tibble(data)
trobo <- as_tibble(robo)

# Unir datasets para calcular distancias
viajes_coordenadasData <- inner_join(tdata, tlugares, by = c("origen" = "lugar"))
viajes_coordenadasData <- inner_join(viajes_coordenadasData, tlugares, by = c("destino" = "lugar"), suffix = c(".orig",".dest"))

# Distinguir entre rutas (588 diferentes)
rutasSinDistData <- distinct(viajes_coordenadasData, longitud.orig, latitud.orig,longitud.dest,latitud.dest)

# Calcular la distancia entre puntos de origen y destino en las rutas
repeat{ 
  for(row in 1:nrow(rutasSinDistData)) {
    
    x1 <- rutasSinDistData[row,"longitud.orig"]
    y1 <- rutasSinDistData[row,"latitud.orig"]
    x2 <- rutasSinDistData[row,"longitud.dest"]
    y2 <- rutasSinDistData[row,"latitud.dest"]
    orig <- as.numeric(c(x1,y1))
    dest <- as.numeric(c(x2,y2))
    try(
      rutasSinDistData[row,"distancia"] <- mapdist(from = orig, to = dest, mode = "driving")$km
    )
    
  }
  rutasData <- c(rutasData,subset(rutasSinDistData,!is.na(distancia)))
  rutasSinDistData <- subset(rutasSinDistData,is.na(distancia))
  print(nrow(rutasSinDistData))
  if(nrow(rutasSinDistData)==0){ break }
}
rutasData
rutasSinDistData
nrow(subset(rutasSinDistData,is.na(distancia)))

#Iterar para obtener las rutas
for(row in 1:nrow(rutasPlot)) {
  
  x1 <- rutasPlot[row,"longitud.orig"]
  y1 <- rutasPlot[row,"latitud.orig"]
  x2 <- rutasPlot[row,"longitud.dest"]
  y2 <- rutasPlot[row,"latitud.dest"]
  orig <- as.numeric(c(x1,y1))
  dest <- as.numeric(c(x2,y2))
  try( rutasPlot[row,"rutaGM"] <- route(orig, dest, structure = "route"))
}

#Muestra en mapa el trazo de las rutas
qmap("Mexico", zoom = 5) + geom_path(aes(x = lon, y = lat),  colour = "red", size = 1,data = rutasPlot$rutaGM, lineend = "round")
# [LA LIMITANTE POR DEFECTO DE LA API ES DE 2,500 LLAMADOS]


# Pregunta 1: ¿Cuál es la distancia total en kilómetros recorrida por transportista?
# SE DEBE INTEGRAR EL CÁLCULO DE DISTANCIA POR RUTA Y LUEGO DE TRANSPORTISTA POR RUTA [NO TERMINAMOS POR FALTA DE LLAMADOS]


# Pregunta 2: ¿Cuál es el costo total a pagar en pesos por transportista?
resultado2 <- select(tdata, transportista, tarifa)
resultado2 <- summarise(group_by(tdata, transportista), total = sum(tarifa))
arrange(resultado2,desc(total))

write.csv(resultado2, paste(URLout, "resultado2.csv", sep="/"), row.names = F)

# Pronóstico 2: ¿Cuáles serán los resultados para ?
pronostico2a <- select(tdata, mes, ano, transportista, tarifa)
pronostico2a <- summarise(group_by(tdata, ano, mes), total = sum(tarifa))
arrange(pronostico2a, ano, mes)
# [INCOMPLETO]

# Pregunta 3: ¿Cuál es el costo por kilómetro recorrido por transportista?
# SE DEBE INTEGRAR EL CÁLCULO DE LA DISTANCIA TOTAL POR TRANSPORTISTA


# Pregunta 4: ¿Cuál es la distancia total en kilómetros recorrida por ruta?
# SE DEBE INTEGRAR EL CÁLCULO DE LA DISTANCIA TOTAL POR RUTA


# Pregunta 5: ¿Cuál es el costo total a pagar en pesos por ruta?
pregunta5 <- select(tdata, ruta, tarifa)
pregunta5 <- summarise(group_by(tdata, ruta), total = sum(tarifa))
arrange(pregunta5,desc(total))

write.csv(resultado5, paste(URLout, "resultado5.csv", sep="/"), row.names = F)

# Pregunta 6: ¿Cuál es el costo por kilómetro recorrido por ruta?
#SE DEBE INTEGRAR EL CÁLCULO DE LA DISTANCIA TOTAL POR RUTA


# ANÁLISIS EXPLORATORIO DE INFORMACIÓN EXTERNA
# Descripción de robo en carretera
redo <- trobo %>%
          select(entidad, ano, cantidad) %>%
          group_by(entidad, ano)
roboedo <- summarise(redo, total = sum(cantidad))
arrange(roboedo, desc(total))
rm(redo)

# Tasa de robos
tdrobo17 <- roboedo %>%
              select(ano = 2017)
              group_by(entidad) %>%
              summarise(tasarobo = weighted.mean(tasarobo,pob)) %>%
              mutate(tasarobo = round(tasarobo, 2))

summarise(tdes = weighted.mean(tdes, pob)) %>%
  mutate(tdes = round(tdes, 2))


# ANÁLISIS EXPLORATORIO DE INFORMACIÓN INTERNA
# COSTO/RUTA
costoruta <- select(tdata, ruta, tarifa)
costoruta <- summarise(group_by(tdata, ruta), total = sum(tarifa))
arrange(costoruta,desc(total))

costorutatrans <- select(tdata, ruta, tarifa, transportista)
costorutatrans <- summarise(group_by(tdata, ruta, transportista), total = sum(tarifa))
arrange(costorutatrans,desc(total))
arrange(costorutatrans,desc(ruta))
# [INCOMPLETO]
