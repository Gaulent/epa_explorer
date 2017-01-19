#install.packages("readr")
library(readr)

#install.packages("plyr")
library(plyr)

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
col_types<-("nccnc-n-c----cccccnc-nccccn-cccccccccccccnnnnccccnnncnncccccncccncccccccccccncccccccc-ccc-ccn")
dframe<-read_fwf("data/raw_new/datos_2016t3", fwf_widths(column_widths, column_names), col_types)

# ------- RETROCOMPATIBILIDAD
# REVISAR EL NFORMA
# REVISAR EL NCURSR

dframe$CCAA[dframe$CCAA==18] <- dframe$PROV[dframe$CCAA==18] # Compatibilidad hacia atras
dframe$NUEVEM[dframe$NUEVEM=="6" & !is.na(dframe$NUEVEM)]<-"3" # Retrocompatibilidad


dframe$NFORMA[dframe$CICLO<130]<-mapvalues(dframe$NFORMA[dframe$CICLO<130],from=c("01","02","03","04","05","06","07","08","09","10","11","12","13","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"), to=c("AN","AN","P2","S1","S1","S1","S1","SG","SP","SP","SP","SP","SP","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU")) #Retrocompatibilidad

dframe$NCURSR[dframe$CICLO<130]<-mapvalues(dframe$NCURSR[dframe$CICLO<130],from=c("03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"), to=c("PR","S1","S1","S1","S1","SG","SP","SP","SP","SP","SP","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","SU","ED","ED","ED","ED","EM","PE","PE","PE","PE")) #Retrocompatibilidad


dframe$SITU[dframe$CICLO<130]<-mapvalues(dframe$SITU[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9"), to=c("01","01","03","03","05","06","07","08","09")) #Retrocompatibilidad
dframe$SITPLU[dframe$CICLO<130]<-mapvalues(dframe$SITPLU[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9"), to=c("01","01","03","03","05","06","07","08","09")) #Retrocompatibilidad
dframe$CURSNR[dframe$CICLO<130]<-mapvalues(dframe$NCURSR[dframe$CICLO<130],from=c("PR","S1","SG","SP","SU","ED","EM","PE"), to=c("3","3","3","3","3","1","1","1"))
dframe$NCURNR[(dframe$NCURSR=="ED"|dframe$NCURSR=="EM"|dframe$NCURSR=="PE") & !is.na(dframe$NCURSR)]<-dframe$NCURSR[(dframe$NCURSR=="ED"|dframe$NCURSR=="EM"|dframe$NCURSR=="PE") & !is.na(dframe$NCURSR)] # Retro compatibilidad
dframe$DUCON1[dframe$CICLO<130]<-mapvalues(dframe$DUCON2[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9","0"), to=c("1","1","6","6","6","6","6","6","6","6")) #Retrocompatibilidad
dframe$DUCON3[dframe$CICLO<130]<-mapvalues(dframe$DUCON2[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9","0"), to=c(NA,NA,"02","03","04","05","06","07","08","00")) #Retrocompatibilidad
dframe$DUCON2[dframe$CICLO<130]<-mapvalues(dframe$DUCON2[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9","0"), to=c("1","6",NA,NA,NA,NA,NA,NA,NA,NA)) #Retrocompatibilidad
dframe$PARCO2[dframe$CICLO<130]<-mapvalues(dframe$PARCO1[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9"), to=c(NA,"01","02","03","04","05","06","07","00")) #Retrocompatibilidad
dframe$PARCO1[dframe$CICLO<130]<-mapvalues(dframe$PARCO1[dframe$CICLO<130],from=c("1","2","3","4","5","6","7","8","9"), to=c("1","6","6","6","6","6","6","6","6")) #Retrocompatibilidad
dframe$HORASH[dframe$CICLO<130]<-dframe$HORASH[dframe$CICLO<130]*100 # Retrocompatiblidad
dframe$HORASE[dframe$CICLO<130]<-dframe$HORASE[dframe$CICLO<130]*100 # Retrocompatiblidad
dframe$HORPLU[dframe$CICLO<130]<-dframe$HORPLU[dframe$CICLO<130]*100 # Retrocompatiblidad
dframe$MASHOR[dframe$CICLO<130]<-mapvalues(dframe$MASHOR[dframe$CICLO<130],from=c("1","2","3","4","5","6"), to=c("1","1","1","1","2","3")) #Retrocompatibilidad
dframe$RZNDISH[dframe$CICLO<130]<-mapvalues(dframe$DISMAS[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c(NA,"01","05","02","03","04","04")) #Retrocompatibilidad
dframe$DISMAS[dframe$CICLO<130]<-mapvalues(dframe$DISMAS[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c("1","6","6","6","6","6","6")) #Retrocompatibilidad
dframe$DESEA[dframe$CICLO<130]<-mapvalues(dframe$BUSCA[dframe$CICLO<130],from=c("1","2","3"), to=c(NA,"1","6")) #Retrocompatibilidad
dframe$BUSCA[dframe$CICLO<130]<-mapvalues(dframe$BUSCA[dframe$CICLO<130],from=c("1","2","3"), to=c("1","6","6")) #Retrocompatibilidad
dframe$NBUSCA[dframe$CICLO<130]<-mapvalues(dframe$NBUSCA[dframe$CICLO<130],from=c("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15"), to=c("01","08","08","08","02","08","08","08","08","03","05","06","07","08","08")) #Retrocompatibilidad
dframe$RZNDIS[dframe$CICLO<130]<-mapvalues(dframe$DISP[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c(NA,"1","5","2","3","4","4")) #Retrocompatibilidad
dframe$DISP[dframe$CICLO<130]<-mapvalues(dframe$DISP[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c("1","6","6","6","6","6","6")) #Retrocompatibilidad
dframe$SITUA[dframe$CICLO<130]<-mapvalues(dframe$SITUA[dframe$CICLO<130],from=c("01","02","03","04","05","06","07","08","09"), to=c("01","01","03","03","05","06","07","08","09")) #Retrocompatibilidad
dframe$SIDI1[dframe$CICLO<130]<-mapvalues(dframe$SIDI1[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c("01","02","03","04","05","06","07")) #Retrocompatibilidad
dframe$SIDI2[dframe$CICLO<130]<-mapvalues(dframe$SIDI2[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c("01","02","03","04","05","06","07")) #Retrocompatibilidad
dframe$SIDI3[dframe$CICLO<130]<-mapvalues(dframe$SIDI3[dframe$CICLO<130],from=c("1","2","3","4","5","6","7"), to=c("01","02","03","04","05","06","07")) #Retrocompatibilidad
dframe$AOI[dframe$CICLO<130]<-mapvalues(dframe$AOI[dframe$CICLO<130],from=c("01","02","03","04","05","06","07","08","09"), to=c(NA,NA,"03","04","05","06","07","08","09")) #Retrocompatibilidad




# --------- FIN DE RETROCOMPATIBILIDAD

# ------ INICIO LIMPIEZA


dframe <- as.data.frame(unclass(dframe)) #Todos los char a factor.

lista_si_no<-list("Si" = "1", "No" = "6")
lista_provincia<-list("Álava"="01",  "Albacete"="02",  "Alicante"="03",  "Almería"="04",  "Ávila"="05",  "Badajoz"="06",  "Baleares"="07",  "Barcelona"="08",  "Burgos"="09",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52")
lista_region<-list("Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "África" = "200", "Norteamérica" = "300", "Centroamérica" = "310", "Sudamérica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceanía" = "500", "Portugal" = "600", "Francia" = "610", "Andorra" = "620", "Marruecos" = "630", "Apátridas" = "999")

levels(dframe$CCAA)<-list("Andalucía"="01", "Aragón"="02", "Asturias"="03", "Baleares"="04", "Canarias"="05", "Cantabria"="06", "Castilla-León"="07", "Castilla-La Mancha"="08", "Cataluña"="09", "Comunidad Valenciana"="10", "Extremadura"="11", "Galicia"="12", "Madrid"="13", "Murcia"="14", "Navarra"="15", "País Vasco"="16", "Rioja"="17", "Ceuta"="51", "Melilla"="52")
levels(dframe$PROV)<-lista_provincia
levels(dframe$SEXO)<-list("V"="1",  "M"="6")
levels(dframe$ECIV)<-list("Soltero"="1", "Casado"="2", "Viudo"="3", "Separado"="4")
levels(dframe$PRONA)<-lista_provincia
levels(dframe$REGNA)<-lista_region
levels(dframe$NAC)<-list("Española"="1",  "Doble"="2", "Extrangera"="3")
levels(dframe$EXREGNA)<-lista_region
levels(dframe$NFORMA)<-list("AN" = "AN", "P1" = "P1", "P2" = "P2", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
dframe$EDADEST[dframe$EDADEST==0]<-NA # Valor nulo
levels(dframe$CURSR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
levels(dframe$NCURNR)<-list("ED" = "ED", "EM" = "EM", "PE" = "PE")
levels(dframe$NCURSR)<-list("PR" = "PR", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
levels(dframe$CURSNR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
dframe$HCURNR[dframe$HCURNR==999]<-NA # Valor nulo
levels(dframe$TRAREM)<-lista_si_no
levels(dframe$AYUDFA)<-lista_si_no
levels(dframe$AUSENT)<-lista_si_no
dframe$RZNOTB[dframe$RZNOTB=="00"]<-NA # Valor nulo
dframe$SP[dframe$SP=="0"|dframe$SP=="6"]<-NA # Valor nulo
levels(dframe$DUCON1)<-list("Indefinido" = "1", "Temporal" = "6")
dframe$DUCON3[dframe$DUCON3=="00"]<-NA # Valor nulo
levels(dframe$DUCON3)<-list("01" = "01", "02" = "02", "03" = "03", "04" = "04", "05" = "05", "06" = "06", "07" = "07", "08" = "08")
levels(dframe$DUCON2)<-list("Permanente" = "1", "Discontinuo" = "6")
dframe$TCONTM[dframe$TCONTM==0]<-NA # Valor nulo
dframe$TCONTM[dframe$TCONTM>96]<-96
dframe$TCONTD[dframe$TCONTD==0]<-NA # Valor nulo
dframe$TCONTD[dframe$TCONTD==99]<-NA # Valor nulo
levels(dframe$PROEST)<-lista_provincia
levels(dframe$REGEST)<-lista_region
dframe$PARCO2[dframe$PARCO2=="00"]<-NA # Valor nulo
levels(dframe$PARCO1)<-list("Completa" = "1", "Parcial" = "6")
dframe$HORASP<-time_to_hours(dframe$HORASP)
dframe$HORASH<-time_to_hours(dframe$HORASH)
dframe$HORASE<-time_to_hours(dframe$HORASE)
levels(dframe$EXTRA)<-lista_si_no
dframe$EXTPAG<-time_to_hours(dframe$EXTPAG)
dframe$EXTNPG<-time_to_hours(dframe$EXTNPG)
dframe$RZDIFH[dframe$RZDIFH=="00"]<-NA # Valor nulo
dframe$RZDIFH[dframe$RZDIFH=="19"]<-NA # Valor nulo
levels(dframe$TRAPLU)<-lista_si_no
dframe$HORPLU<-time_to_hours(dframe$HORPLU)
levels(dframe$MASHOR)<-list("Si" = "1", "Reduccion" = "2", "No" = "3")
levels(dframe$DISMAS)<-lista_si_no
dframe$HORDES[dframe$HORDES==99]<-NA # Valor nulo
levels(dframe$BUSOTR)<-lista_si_no
levels(dframe$BUSCA)<-lista_si_no
levels(dframe$DESEA)<-lista_si_no
levels(dframe$FOBACT)<-list("Activos" = "1", "No activos" = "6")
dframe$ASALA[dframe$ASALA=="0"]<-NA # Valor nulo
levels(dframe$ASALA)<-lista_si_no
dframe$NBUSCA[dframe$NBUSCA=="00"]<-NA # Valor nulo
dframe$EMBUS[dframe$EMBUS=="0"]<-NA # Valor nulo
levels(dframe$DISP)<-lista_si_no
dframe$SIDI1[dframe$SIDI1=="00"]<-NA # Valor nulo
dframe$SIDI2[dframe$SIDI2=="00"]<-NA # Valor nulo
dframe$SIDI3[dframe$SIDI3=="00"]<-NA # Valor nulo
levels(dframe$EMPANT)<-lista_si_no
levels(dframe$SIDAC1)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
#levels(dframe$SIDAC2)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
levels(dframe$MUN)<-list("Mismo" = "1", "Distinto" = "6")
levels(dframe$PRORE)<-lista_provincia
levels(dframe$REPAIRE)<-lista_region
#levels(dframe$TRAANT)<-lista_si_no
dframe$FACTOREL<-dframe$FACTOREL/100

#------------- FIN: CADA VEZ

#------------- ARREGLILLOS

dframe$REGNA = ifelse(is.na(dframe$REGNA),dframe$PRONA, dframe$REGNA)
dframe$PRONA <- NULL

dframe$REGEST = ifelse(is.na(dframe$REGEST),dframe$PROEST, dframe$REGEST)
dframe$PROEST <- NULL

dframe$REPAIRE = ifelse(is.na(dframe$REPAIRE),dframe$PRORE, dframe$REPAIRE)
dframe$PRORE <- NULL

dframe$TCONT = ifelse(is.na(dframe$TCONTM),dframe$TCONTD/31, dframe$TCONTM)
dframe$TCONTM <- NULL
dframe$TCONTD <- NULL

dframe$SIDAC <- dframe$SIDAC1
dframe$SIDAC1 <- NULL


#----->>>ARREGLAR ESTO
#dframe$SIDI = paste(ifelse(is.na(dframe$SIDI1),"",dframe$SIDI1),ifelse(is.na(dframe$SIDI2),"",dframe$SIDI2),ifelse(is.na(dframe$SIDI3),"",dframe$SIDI3), sep="")
#dframe$SIDI = ifelse(dframe$SIDI=="",NA, dframe$SIDI)


#------------- FIN: ARREGLILLOS


#install.packages("RSQLite")
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
dbWriteTable(con,"epa_table",dframe, append=TRUE, overwrite=FALSE)
dbDisconnect(con)









con <- dbConnect(RSQLite::SQLite(), "epa_db.db")

# Fetch all results
rs <- dbSendQuery(con, "SELECT CICLO FROM epa_table")
result<-dbFetch(rs,n=-1)
dbClearResult(rs)

dbDisconnect(con)
