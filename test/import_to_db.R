install.packages("readr")
library(readr)

setwd("C:/workarea")

time_to_hours <- function(x) {
  x[x==0]<-NA # Valor nulo
  x[x==9999]<-NA # Valor nulo
  x<-((x%/%100)*60+x%%100)/60
  return(x)
}

column_widths<-c(3, 2, 2, 5, 1, 2, 2, 1, 1, 2, 2, 2, 1, 1, 2, 3, 1, 3, 2, 2, 2, 3, 1, 2, 1, 2, 3, 2, 1, 1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 3, 3, 2, 3, 1, 2, 4, 4, 4, 1, 4, 4, 2, 1, 1, 1, 2, 4, 1, 1, 2, 2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 3, 1, 1, 2, 1, 2, 2, 2, 1, 1, 1, 2, 3, 1, 2, 2, 7)
column_names<-c("CICLO", "CCAA", "PROV", "NVIVI", "NIVEL", "NPERS", "EDAD5", "RELPP1", "SEXO1", "NCONY", "NPADRE", "NMADRE", "RELLMILI", "ECIV1", "PRONA1", "REGNA1", "NAC1", "EXREGNA1", "ANORE1", "NFORMA", "RELLB", "EDADEST", "CURSR", "NCURSR", "CURSNR", "NCURNR", "HCURNR", "RELLB1", "TRAREM", "AYUDFA", "AUSENT", "RZNOTB", "VINCUL", "NUEVEM", "OCUP1", "ACT1", "SITU", "SP", "DUCON1", "DUCON2", "DUCON3", "TCONTM", "TCONTD", "DREN", "DCOM", "PROEST", "REGEST", "PARCO1", "PARCO2", "HORASP", "HORASH", "HORASE", "EXTRA", "EXTPAG", "EXTNPG", "RZDIFH", "TRAPLU", "OCUPLU1", "ACTPLU1", "SITPLU", "HORPLU", "MASHOR", "DISMAS", "RZNDISH", "HORDES", "BUSOTR", "BUSCA", "DESEA", "FOBACT", "NBUSCA", "ASALA", "EMBUS", "ITBU", "DISP", "RZNDIS", "EMPANT", "DTANT", "OCUPA", "ACTA", "SITUA", "OFEMP", "SIDI1", "SIDI2", "SIDI3", "SIDAC1", "SIDAC2", "MUN1", "PRORE1", "REPAIRE1", "TRAANT", "AOI", "CSE", "FACTOREL")
col_types<-("nccnc-ncc----cccccnc-nccccn-cccccccccccccnnnnccccnnncnncccccncccncccccccccccncccccccccccccccn")
dframe<-read_fwf("data/datos_new_full", fwf_widths(column_widths, column_names), col_types)

dframe <- as.data.frame(unclass(dframe)) #Todos los char a factor.

#--------- UNA SOLA VEZ

dframe$EDADEST[dframe$EDADEST==0]<-NA # Valor nulo
dframe$HCURNR[dframe$HCURNR==999]<-NA # Valor nulo
dframe$EXTNPG<-time_to_hours(dframe$EXTNPG)
dframe$EXTPAG<-time_to_hours(dframe$EXTPAG)
dframe$HORASE<-time_to_hours(dframe$HORASE)
dframe$HORASH<-time_to_hours(dframe$HORASH)
dframe$HORASP<-time_to_hours(dframe$HORASP)
dframe$HORDES[dframe$HORDES==99]<-NA # Valor nulo
dframe$HORPLU<-time_to_hours(dframe$HORPLU)
dframe$TCONTD[dframe$TCONTD==0]<-NA # Valor nulo
dframe$TCONTD[dframe$TCONTD==99]<-NA # Valor nulo
dframe$TCONTM[dframe$TCONTM==0]<-NA # Valor nulo
dframe$ASALA[dframe$ASALA=="0"]<-NA # Valor nulo
dframe$DUCON3[dframe$DUCON3=="00"]<-NA # Valor nulo
dframe$RZNOTB[dframe$RZNOTB=="00"]<-NA # Valor nulo
dframe$SP[dframe$SP=="0"]<-NA # Valor nulo
dframe$PARCO2[dframe$PARCO2=="00"]<-NA # Valor nulo

dframe$FACTOREL<-dframe$FACTOREL/100

#------ FIN: UNA SOLA VEZ

#------------- CADA VEZ

lista_si_no<-list("Si" = "1", "No" = "6")

levels(dframe$ASALA)<-lista_si_no
levels(dframe$AUSENT)<-lista_si_no
levels(dframe$AYUDFA)<-lista_si_no
levels(dframe$BUSCA)<-lista_si_no
levels(dframe$BUSOTR)<-lista_si_no
levels(dframe$DESEA)<-lista_si_no
levels(dframe$DISMAS)<-lista_si_no
levels(dframe$DISP)<-lista_si_no
levels(dframe$TRAANT)<-lista_si_no
levels(dframe$TRAPLU)<-lista_si_no
levels(dframe$TRAREM)<-lista_si_no
levels(dframe$EMPANT)<-lista_si_no
levels(dframe$EXTRA)<-lista_si_no

levels(dframe$CURSR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
levels(dframe$MASHOR)<-list("Si" = "1", "Reduccion" = "2", "No" = "3")
levels(dframe$DUCON1)<-list("Indefinido" = "1", "Temporal" = "6")
levels(dframe$DUCON2)<-list("Permanente" = "1", "Discontinuo" = "6")
levels(dframe$ECIV1)<-list("Soltero"="1", "Casado"="2", "Viudo"="3", "Separado"="4")
levels(dframe$FOBACT)<-list("Activos" = "1", "No activos" = "6")
levels(dframe$MUN1)<-list("Mismo" = "1", "Distinto" = "6")
levels(dframe$NAC1)<-list("Española"="1",  "Doble"="2", "Extrangera"="3")
levels(dframe$NCURNR)<-list("ED" = "ED", "EM" = "EM", "PE" = "PE")
levels(dframe$NCURSR)<-list("PR" = "PR", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
levels(dframe$NFORMA)<-list("AN" = "AN", "P1" = "P1", "P2" = "P2", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
levels(dframe$PARCO1)<-list("Completa" = "1", "Parcial" = "6")

lista_provincia<-list("Álava"="01",  "Albacete"="02",  "Alicante"="03",  "Almería"="04",  "Ávila"="05",  "Badajoz"="06",  "Baleares"="07",  "Barcelona"="08",  "Burgos"="09",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52")

levels(dframe$PROEST)<-lista_provincia
levels(dframe$PRONA1)<-lista_provincia
levels(dframe$PRORE1)<-lista_provincia
levels(dframe$PROV)<-lista_provincia

lista_region<-list("Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "África" = "200", "Norteamérica" = "300", "Centroamérica" = "310", "Sudamérica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceanía" = "500", "Portugal" = "600", "Francia" = "610", "Andorra" = "620", "Marruecos" = "630", "Apátridas" = "999")

levels(dframe$REGEST)<-lista_region
levels(dframe$REGNA1)<-lista_region
levels(dframe$REPAIRE1)<-lista_region
levels(dframe$EXREGNA1)<-lista_region

levels(dframe$SEXO1)<-list("V"="1",  "M"="6")

levels(dframe$SIDAC1)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
levels(dframe$SIDAC2)<-list("Trabajando" = "1", "Buscando Empleo" = "2")


levels(dframe$CCAA)<-list("Andalucía"="01", "Aragón"="02", "Asturias"="03", "Baleares"="04", "Canarias"="05", "Cantabria"="06", "Castilla-León"="07", "Castilla-La Mancha"="08", "Cataluña"="09", "Comunidad Valenciana"="10", "Extremadura"="11", "Galicia"="12", "Madrid"="13", "Murcia"="14", "Navarra"="15", "País Vasco"="16", "Rioja"="17", "Ceuta"="51", "Melilla"="52")

#------------- FIN: CADA VEZ

install.packages("RSQLite")
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
dbWriteTable(con,"epa_table",dframe)
dbDisconnect(con)









con <- dbConnect(RSQLite::SQLite(), "epa_db.db")

# Fetch all results
rs <- dbSendQuery(con, "SELECT CCAA FROM epa_table WHERE CICLO=130")
result<-dbFetch(rs,n=-1)
dbClearResult(rs)

dbDisconnect(con)