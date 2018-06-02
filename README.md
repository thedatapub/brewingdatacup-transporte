# Brewing Data Cup
El BDC es el Hackathon de Ciencia de Datos más importante de la CDMX. Es organizado por [Grupo Modelo](https://en.wikipedia.org/wiki/Grupo_Modelo), [Microsoft](https://www.microsoft.com) y [The Data Pub](https://facebook.com/thedatapub), la comunidad de Ciencia de Datos más grande de México. El objetivo es seleccionar a los mejores Científicos de Datos para ingresar a las filas del grupo de Innovación & Analytics en la cervecera.

## ¿De qué trata este reto?
### Contexto
Grupo Modelo cuenta con 7 plantas de cerveza desde donde distribuye cerveza a 182 agencias a lo largo de todo el país. 

Para realizar dicha labor, trabajamos con 87 compañías transportistas diferentes. Dichas compañías cobran diferentes tarifas dependiendo la distancia del viaje, el tipo de transporte y mucha otras variables, como que tan peligrosa es una zona o qué tan cerca está su base.

### Reto

Si te damos las coordenadas geográficas de los orígenes y destinos, ¿puedes calcular la distancia recorrida de cada ruta?. Te daremos información de más de 131,000 viajes reales.

¿Podrías pronosticar la distancia recorrida y los costos de transporte de mayo? ¿Introducirías variables externas como el costo de gasolina?

Más allá de eso, ¿Serías capaz de crear una estrategia en la que utilicemos a las transportistas únicamente en las rutas en las que más nos convenga?

### Información disponible 
Tienes los datos de enero 2017 a abril 2018. Variables a pronosticar para mayo 2018:

- Distancia total en kilómetros recorrida por transportista
- Costo total a pagar en pesos por transportista 
- Costo por kilómetro recorrido por transportista 
- Distancia total en kilómetros recorrida por ruta 
- Costo total a pagar en pesos por ruta 
- Costo por kilómetro recorrido por ruta 

### Insights

¿A cuánto asciende el sobrecosto por km que pagará la compañía en mayo? i.e. la suma de tarifas efectivamente pagadas en viajes “caros” considerando los diferentes tipo de transporte. 
¿Qué estrategia puedes desarrollar para disminuir el sobrecosto? Tomando en cuenta que la flota disponible de cada transportista es limitada.

## Diccionario de datos
| Variable                                                                   |
|----------------------------------------------------------------------------|
| Tipo de Dato                                                               |
| Tipo de Modelaje                                                           |
| Definición                                                                 |
| Número de Categorías Diferentes                                            |
| Folio                                                                      |
| Numérico                                                                   |
| Nominal                                                                    |
| Clave numérica de Folio único asignado a cada viaje                        |
| 131,189                                                                    |
| Ruta                                                                       |
| Numérico                                                                   |
| Nominal                                                                    |
| Clave numérica de Ruta único asignado a cada ruta Origen "A" a Destino "B" |
| 591                                                                        |
| Fecha                                                                      |
| Numérico                                                                   |
| Fecha (DD/MM/YYYY)                                                         |
| Fecha en el que comenzó el viaje                                           |
| 455                                                                        |
| Tipo de Flota                                                              |
| Texto                                                                      |
| Nominal                                                                    |
| Tipo de camión que transporta                                              |
| 12                                                                         |
| Origen                                                                     |
| Numérico                                                                   |
| Nominal                                                                    |
| Clave numérica única asignada al lugar de origen del viaje                 |
| 7                                                                          |
| Destino                                                                    |
| Numérico                                                                   |
| Nominal                                                                    |
| Clave numérica única asignada al lugar de destino del viaje                |
| 182                                                                        |
| Transportista                                                              |
| Texto                                                                      |
| Nominal                                                                    |
| Nombre de la compañía transportista                                        |
| 87                                                                         |
| Número Clave Transportista                                                 |
| Numérico                                                                   |
| Nominal                                                                    |
| Clave numérica única asignada a cada compañía transportista                |
| 87                                                                         |
| Tarifa pagada                                                              |
| Numérico                                                                   |
| Continuo                                                                   |
| Monto en pesos efectivamente pagado a la compañía transportista por viaje  |
| 6,451                                                                      |
| Latitud Origen                                                             |
| Numérico                                                                   |
| Continuo                                                                   |
| Información geográfica del lugar de origen                                 |
| 7                                                                          |
| Longitud Origen                                                            |
| Numérico                                                                   |
| Continuo                                                                   |
| Información geográfica del lugar de origen                                 |
| 7                                                                          |
| Latitud Destino                                                            |
| Numérico                                                                   |
| Continuo                                                                   |
| Información geográfica del lugar de destino                                |
| 182                                                                        |
| Longitud Destino                                                           |
| Numérico                                                                   |
| Continuo                                                                   |
| Información geográfica del lugar de destino                                |
| 182                                                                        |
| Distancia Viajada en kms                                                   |
| Numérico                                                                   |
| Continuo                                                                   |
| A calcular por los participantes.                                          |
| Únicamente considerar carreteras dentro de México                          |
## ¿En qué consisten los datasets?

## ¿Cómo se estructura mi solución?
