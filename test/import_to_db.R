#install.packages("readr")
library(readr)

#copy /b * newfile #append de ficheros en windows

#setwd("C:/totalcmd")

time_to_hours <- function(x) {
  x[x==0]<-NA # Valor nulo
  x[x==9999]<-NA # Valor nulo
  x<-((x%/%100)*60+x%%100)/60
  return(x)
}

column_widths<-c(3, 2, 2, 5, 1, 2, 2, 1, 1, 2, 2, 2, 1, 1, 2, 3, 1, 3, 2, 2, 2, 3, 1, 2, 1, 2, 3, 2, 1, 1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 3, 3, 2, 3, 1, 2, 4, 4, 4, 1, 4, 4, 2, 1, 1, 1, 2, 4, 1, 1, 2, 2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 3, 1, 1, 2, 1, 2, 2, 2, 1, 1, 1, 2, 3, 1, 2, 2, 7)
column_names<-c("CICLO", "CCAA", "PROV", "NVIVI", "NIVEL", "NPERS", "EDAD5", "RELPP", "SEXO", "NCONY", "NPADRE", "NMADRE", "RELLMILI", "ECIV", "PRONA", "REGNA", "NAC", "EXREGNA", "ANORE", "NFORMA", "RELLB", "EDADEST", "CURSR", "NCURSR", "CURSNR", "NCURNR", "HCURNR", "RELLB1", "TRAREM", "AYUDFA", "AUSENT", "RZNOTB", "VINCUL", "NUEVEM", "OCUP", "ACT", "SITU", "SP", "DUCON1", "DUCON2", "DUCON3", "TCONTM", "TCONTD", "DREN", "DCOM", "PROEST", "REGEST", "PARCO1", "PARCO2", "HORASP", "HORASH", "HORASE", "EXTRA", "EXTPAG", "EXTNPG", "RZDIFH", "TRAPLU", "OCUPLU", "ACTPLU", "SITPLU", "HORPLU", "MASHOR", "DISMAS", "RZNDISH", "HORDES", "BUSOTR", "BUSCA", "DESEA", "FOBACT", "NBUSCA", "ASALA", "EMBUS", "ITBU", "DISP", "RZNDIS", "EMPANT", "DTANT", "OCUPA", "ACTA", "SITUA", "OFEMP", "SIDI1", "SIDI2", "SIDI3", "SIDAC1", "SIDAC2", "MUN", "PRORE", "REPAIRE", "TRAANT", "AOI", "CSE", "FACTOREL")
col_types<-("iii-i-i-i----iiiiiic-iicici-iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii-iii")
dframe<-read_fwf("data/datos_new_full", fwf_widths(column_widths, column_names), col_types)
#dframe<-read_fwf("data/raw_new/datos_2016t3", fwf_widths(column_widths, column_names), col_types)



# Nulos para numericos

dframe$EDADEST[dframe$EDADEST==0]<-NA
dframe$HCURNR[dframe$HCURNR==999]<-NA
dframe$HORDES[dframe$HORDES==99]<-NA

# Atributos horarios

dframe$HORASP<-time_to_hours(dframe$HORASP)
dframe$HORASH<-time_to_hours(dframe$HORASH)
dframe$HORASE<-time_to_hours(dframe$HORASE)
dframe$EXTPAG<-time_to_hours(dframe$EXTPAG)
dframe$EXTNPG<-time_to_hours(dframe$EXTNPG)
dframe$HORPLU<-time_to_hours(dframe$HORPLU)

# Arreglillos varios

dframe$SP[dframe$SP==6]<-0
dframe$FACTOREL<-dframe$FACTOREL/100

# Fusionar campos de region y provincia

dframe$REGNA = ifelse(is.na(dframe$REGNA),dframe$PRONA, dframe$REGNA)
dframe$REGEST = ifelse(is.na(dframe$REGEST),dframe$PROEST, dframe$REGEST)
dframe$REPAIRE = ifelse(is.na(dframe$REPAIRE),dframe$PRORE, dframe$REPAIRE)

# Fusion de dias y meses contratados

dframe$TCONTM[dframe$TCONTM==0]<-NA # Valor nulo
dframe$TCONTD[dframe$TCONTD==0|dframe$TCONTD==99]<-NA # Valor nulo
dframe$TCONT <- ifelse(is.na(dframe$TCONTD), dframe$TCONTM, dframe$TCONTD/31)

# Atributo SIDAC

SIDAC_aux <- dframe$SIDAC1==2 | dframe$SIDAC2==2
dframe$SIDAC1 <- dframe$SIDAC1==1 | dframe$SIDAC2==1
dframe$SIDAC2 <- SIDAC_aux

# Atributo SIDI

SIDI<-gsub(" NA","", paste(dframe$SIDI1,dframe$SIDI2,dframe$SIDI3))
SIDI<-gsub("NA ","", SIDI)
SIDI<-ifelse(SIDI=="NA",NA, SIDI)

dframe$SIDI1 <- SIDI==1
dframe$SIDI2 <- SIDI==2
dframe$SIDI3 <- SIDI==3
dframe$SIDI4 <- SIDI==4
dframe$SIDI5 <- SIDI==5
dframe$SIDI6 <- SIDI==6
dframe$SIDI7 <- SIDI==7

# Eliminar atributos sobrantes

dframe$PRONA <- NULL
dframe$PROEST <- NULL
dframe$PRORE <- NULL
dframe$TCONTM <- NULL
dframe$TCONTD <- NULL

#--- REORDENAR LAS COLUMNAS

dframe<-dframe[,c(1:31,79,32:71,80:83,72:78)]


#install.packages("RSQLite")
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
dbWriteTable(con,"epa_table",dframe, append=TRUE, overwrite=FALSE)
dbDisconnect(con)









con <- dbConnect(RSQLite::SQLite(), "epa_db.db")

# Fetch all results
rs <- dbSendQuery(con, "SELECT * FROM epa_table")
result<-dbFetch(rs,n=-1)
dbClearResult(rs)

dbDisconnect(con)
