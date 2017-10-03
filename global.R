#
# En este fichero global.R se instalan y se cargan todos los paquetes y librerias
# necesarias para el correcto funcionamiento de la aplicacion.
#

list.of.packages <- c("Hmisc","cluster","shiny", "rmarkdown", "RSQLite", "dplyr", "readr", "RCurl", "ggplot2", "GGally", "plotly", "crosstalk", "arules", "arulesViz", "klaR")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

lapply(list.of.packages, require, character.only = TRUE)

source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")
