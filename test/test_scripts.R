library(ggplot2)
library(RSQLite)
library(plyr)

source("../global.R", encoding = "UTF-8")




library(RCurl)
filenames <- getURL("ftp://www.ine.es/temas/epa/",ftp.use.epsv = FALSE,dirlistonly = TRUE) 
filenames<-strsplit(filenames, "\r*\n")

df<-data.frame(x=filenames,stringsAsFactors = FALSE)
names(df)[1]<-"x"
df[grep('datos_.+\\.zip', df$x),]

download.file("ftp://www.ine.es/temas/epa/datos_4t13.zip",destfile="datos_4t13.zip",method="libcurl")
unzip("datos_4t13.zip")


