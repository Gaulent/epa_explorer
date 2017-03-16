
library(ggplot2)

source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")


map_ccaa <- data.frame(value=c(1:17,51,52), label=c("Andalucía", "Aragón", "Asturias", "Baleares", "Canarias", "Cantabria", "Castilla y León", "Castilla-La Mancha", "Cataluña", "Comunidad Valenciana", "Extremadura", "Galicia", "Comunidad de Madrid", "Región de Murcia", "Navarra", "País Vasco", "La Rioja", "Ceuta", "Melilla"),stringsAsFactors=FALSE)  
dframe<-getData("CCAA")
dframe$CCAA[dframe$CCAA==1]<-NA

dframe <- as.data.frame(unclass(dframe)) #Todos los char a factor.
levels(dframe$CCAA)<-list("Andaluc?a"="1", "Arag?n"="2", "Asturias"="3", "Baleares"="4", "Canarias"="5", "Cantabria"="6", "Castilla-Le?n"="7", "Castilla-La Mancha"="8", "Catalu?a"="9", "Comunidad Valenciana"="10", "Extremadura"="11", "Galicia"="12", "Madrid"="13", "Murcia"="14", "Navarra"="15", "Pa?s Vasco"="16", "Rioja"="17", "Ceuta"="51", "Melilla"="52")
dframe$CCAA<-plyr::mapvalues(dframe$CCAA,from=map_ccaa$value, to=map_ccaa$label)

result <- current_data %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL))
result$hombres <- (filter(current_data, SEXO==1) %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total
result$mujeres <- (filter(current_data, SEXO==6) %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total

ggplot(result, aes(CICLO)) + 
  geom_line(aes(y = total/1000, colour = "var0")) + 
  geom_line(aes(y = hombres/1000, colour = "var1")) +
  geom_line(aes(y = mujeres/1000, colour = "var2")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max(result$total/1000)))




# Obtener parches que faltan

check_for_updates <- function() {
  
  library(RCurl)
  library(dplyr)
  ftp_address <- "ftp://www.ine.es/temas/epa/"
  filenames <- getURL(ftp_address,ftp.use.epsv = FALSE,dirlistonly = TRUE) 
  filenames<-strsplit(filenames, "\r*\n")
  
  df<-data.frame(x=filenames,stringsAsFactors = FALSE)
  names(df)[1]<-"Name"
  df<-filter(df,grepl("datos_.+\\.zip", Name))
  
  db_updates<-getSQL("SELECT * FROM db_updates")
  
  check_for_updates<-setdiff(df,db_updates)
}
#--Actualizar base de datos

update_database <- function(selected_file = "datos_4t16.zip") {
  
  tempReport <- file.path(tempdir(), selected_file)
  #file.copy("reports/report.Rmd", tempReport, overwrite = TRUE)
  
  download.file(file.path(ftp_address, selected_file),destfile=tempReport,method="libcurl",quiet=TRUE)
  df<-unzip(tempReport,list=TRUE)
  df<-arrange(df, desc(Length) )
  unzipped_file<-df$Name[1]
  
  unzip(tempReport,exdir=tempdir())
  
  super_funcion_que_lo_hace_todo_yeah(file.path(ftp_address, unzipped_file))

  getSQL(paste(c("INSERT INTO db_updates VALUES ('",selected_file,"')"),collapse=""))
}
#---------------------------------





