library(ggplot2)
library(RSQLite)
library(plyr)

source("global.R", encoding = "UTF-8")



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





