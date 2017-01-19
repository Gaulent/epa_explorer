
setwd("D:/workarea/data")
dframe<-readRDS(file="dframe_new.Rda")

dframe$CICLO<-as.numeric(levels(dframe$CICLO))[dframe$CICLO]

levels(dframe$CCAA)<-    list("Andalucía"="01", "Aragón"="02", "Asturias"="03", "Baleares"="04", "Canarias"="05", "Cantabria"="06", "Castilla-León"="07", "Castilla-La Mancha"="08", "Cataluña"="09", "Comunidad Valenciana"="10", "Extremadura"="11", "Galicia"="12", "Madrid"="13", "Murcia"="14", "Navarra"="15", "País Vasco"="16", "Rioja"="17", "Ceuta"="51", "Melilla"="52")
levels(dframe$PROV)<-    list("Alava"="01",  "Albacete"="02",  "Alicante"="03",  "Almería"="04",  "Ávila"="05",  "Badajoz"="06",  "Baleares"="07",  "Barcelona"="08",  "Burgos"="09",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52")
levels(dframe$PRORE1)<-  list("Álava"="01",  "Albacete"="02",  "Alicante"="03",  "Almería"="04",  "Ávila"="05",  "Badajoz"="06",  "Baleares"="07",  "Barcelona"="08",  "Burgos"="09",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52")
levels(dframe$PRONA1)<-  list("Álava"="01",  "Albacete"="02",  "Alicante"="03",  "Almería"="04",  "Ávila"="05",  "Badajoz"="06",  "Baleares"="07",  "Barcelona"="08",  "Burgos"="09",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52")
levels(dframe$PROEST)<-  list("Álava"="01",  "Albacete"="02",  "Alicante"="03",  "Almería"="04",  "Ávila"="05",  "Badajoz"="06",  "Baleares"="07",  "Barcelona"="08",  "Burgos"="09",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52")
levels(dframe$REGNA1)<-  list("Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "Africa" = "200", "Norteamerica" = "300", "Centroamerica" = "310", "Sudamerica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceania" = "500")
levels(dframe$EXREGNA1)<-list("Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "Africa" = "200", "Norteamerica" = "300", "Centroamerica" = "310", "Sudamerica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceania" = "500", "Apatridas" = "999")
levels(dframe$REPAIRE1)<-list("Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "Africa" = "200", "Norteamerica" = "300", "Centroamerica" = "310", "Sudamerica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceania" = "500")
levels(dframe$REGEST)<-  list("Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "Africa" = "200", "Norteamerica" = "300", "Centroamerica" = "310", "Sudamerica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceania" = "500", "Portugal" = "600", "Francia" = "610", "Andorra" = "620", "Marruecos" = "630")

dframe$NVIVI<-as.numeric(levels(dframe$NVIVI))[dframe$NVIVI]
dframe$NPERS<-as.numeric(levels(dframe$NPERS))[dframe$NPERS]
dframe$EDAD5<-as.numeric(levels(dframe$EDAD5))[dframe$EDAD5]
levels(dframe$SEXO1)<-list("V"="1",  "M"="6")
levels(dframe$ECIV1)<-list("Soltero"="1", "Casado"="2", "Viudo"="3", "Separado"="4")
levels(dframe$NAC1)<-list("Española"="1",  "Doble"="2", "Extrangera"="3")
dframe$ANORE1<-as.numeric(levels(dframe$ANORE1))[dframe$ANORE1]
levels(dframe$NFORMA)<-list("AN" = "AN", "P1" = "P1", "P2" = "P2", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
dframe$EDADEST[dframe$EDADEST=="00"]<-NA # Valor nulo
dframe$EDADEST<-as.numeric(levels(dframe$EDADEST))[dframe$EDADEST]
levels(dframe$NCURSR)<-list("PR" = "PR", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
levels(dframe$CURSR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
levels(dframe$NCURNR)<-list("ED" = "ED", "EM" = "EM", "PE" = "PE")
dframe$HCURNR[dframe$HCURNR=="999"]<-NA # Valor nulo
dframe$HCURNR<-as.numeric(levels(dframe$HCURNR))[dframe$HCURNR]
levels(dframe$TRAREM)<-list("Si" = "1", "No" = "6")
levels(dframe$AYUDFA)<-list("Si" = "1", "No" = "6")
levels(dframe$AUSENT)<-list("Si" = "1", "No" = "6")

dframe$RZNOTB[dframe$RZNOTB=="00"]<-NA # Valor nulo
# RZNOTB Motivos para no trabajar
# VINCUL Vinculacion con el empleo
# NUEVEM Nuevo Empleo
# OCUP1 Ocupacion Principal
# ACT Actividad en que trabaja
# SITU Situacion en que trabaja

dframe$SP[dframe$SP=="0"]<-NA # Valor nulo
# SP tipo de administracion
levels(dframe$DUCON1)<-list("Indefinido" = "1", "Temporal" = "6")
levels(dframe$DUCON2)<-list("Permanente" = "1", "Discontinuo" = "6")
dframe$DUCON3[dframe$DUCON3=="00"]<-NA # Valor nulo
#DUCON3 Tipo de contrato temporal

dframe$TCONTM[dframe$TCONTM=="00"]<-NA # Valor nulo
dframe$TCONTM<-as.numeric(levels(dframe$TCONTM))[dframe$TCONTM]

dframe$TCONTD[dframe$TCONTD=="99"]<-NA # Valor nulo
dframe$TCONTD[dframe$TCONTD=="00"]<-NA # Valor nulo
dframe$TCONTD<-as.numeric(levels(dframe$TCONTD))[dframe$TCONTD]


dframe$DREN<-as.numeric(levels(dframe$DREN))[dframe$DREN]
dframe$DCOM<-as.numeric(levels(dframe$DCOM))[dframe$DCOM]


levels(dframe$PARCO1)<-list("Completa" = "1", "Parcial" = "6")

dframe$PARCO2[dframe$PARCO2=="00"]<-NA # Valor nulo
#PARCO2 Motivos de tener jornada parcial


dframe$PARCO2[dframe$PARCO2=="00"]<-NA # Valor nulo

dframe$HORASP[dframe$HORASP=="0000"]<-NA # Valor nulo
dframe$HORASP[dframe$HORASP=="9999"]<-NA # Valor nulo
dframe$HORASP<-as.numeric(levels(dframe$HORASP))[dframe$HORASP]
dframe$HORASP<-((dframe$HORASP%/%100)*60+dframe$HORASP%%100)/60
#HORASP ¿¿¿???? COMO ALMACENAR HORAS? Pactadas MINUTOS MEJOR

dframe$HORASP[dframe$HORASP=="0000"]<-NA # Valor nulo
dframe$HORASP[dframe$HORASP=="9999"]<-NA # Valor nulo
dframe$HORASH<-as.numeric(levels(dframe$HORASH))[dframe$HORASH]
dframe$HORASH<-((dframe$HORASH%/%100)*60+dframe$HORASH%%100)/60
#HORASH ¿¿¿???? COMO ALMACENAR HORAS? Habituales MINUTOS MEJOR

dframe$HORASE[dframe$HORASE=="0000"]<-NA # Valor nulo
dframe$HORASE[dframe$HORASE=="9999"]<-NA # Valor nulo
dframe$HORASE<-as.numeric(levels(dframe$HORASE))[dframe$HORASE]
dframe$HORASE<-((dframe$HORASE%/%100)*60+dframe$HORASE%%100)/60
#HORASE ¿¿¿???? COMO ALMACENAR HORAS? Efectivas MINUTOS MEJOR

levels(dframe$EXTRA)<-list("Si" = "1", "No" = "6")

dframe$EXTPAG[dframe$EXTPAG=="0000"]<-NA # Valor nulo
dframe$EXTPAG[dframe$EXTPAG=="9999"]<-NA # Valor nulo
dframe$EXTPAG<-as.numeric(levels(dframe$EXTPAG))[dframe$EXTPAG]
dframe$EXTPAG<-((dframe$EXTPAG%/%100)*60+dframe$EXTPAG%%100)/60
#EXTPAG ¿¿¿???? COMO ALMACENAR HORAS? Efectivas MINUTOS MEJOR

dframe$EXTNPG[dframe$EXTNPG=="0000"]<-NA # Valor nulo
dframe$EXTNPG[dframe$EXTNPG=="9999"]<-NA # Valor nulo
dframe$EXTNPG<-as.numeric(levels(dframe$EXTNPG))[dframe$EXTNPG]
dframe$EXTNPG<-((dframe$EXTNPG%/%100)*60+dframe$EXTNPG%%100)/60
#EXTNPG ¿¿¿???? COMO ALMACENAR HORAS? Efectivas MINUTOS MEJOR

#RZDIFH Motivo por el que trabajo distinto a lo habitual

levels(dframe$TRAPLU)<-list("Si" = "1", "No" = "6")
#OCUPLU1 Ocupacion segundo empleo
#ACTPLU1 Actividad segundo empleo
#SITPLU Situacion segundo empleo

dframe$HORPLU[dframe$HORPLU=="0000"]<-NA # Valor nulo
dframe$HORPLU[dframe$HORPLU=="9999"]<-NA # Valor nulo
dframe$HORPLU<-as.numeric(levels(dframe$HORPLU))[dframe$HORPLU]
dframe$HORPLU<-((dframe$HORPLU%/%100)*60+dframe$HORPLU%%100)/60
#HORPLU ¿¿¿???? COMO ALMACENAR HORAS? Efectivas MINUTOS MEJOR


levels(dframe$MASHOR)<-list("Si" = "1", "Reduccion" = "2", "No" = "3")
levels(dframe$DISMAS)<-list("Si" = "1", "No" = "6")
#RZNDISH Motivo por el que no trabajar mas horas

dframe$HORDES[dframe$HORDES=="99"]<-NA # Valor nulo
dframe$HORDES<-as.numeric(levels(dframe$HORDES))[dframe$HORDES]

levels(dframe$BUSOTR)<-list("Si" = "1", "No" = "6")
levels(dframe$BUSCA)<-list("Si" = "1", "No" = "6")
levels(dframe$DESEA)<-list("Si" = "1", "No" = "6")
levels(dframe$FOBACT)<-list("Activos" = "1", "No activos" = "6")

#NBUSCA Razones por las que no busca

dframe$ASALA[dframe$ASALA=="0"]<-NA # Valor nulo
levels(dframe$ASALA)<-list("Si" = "1", "No" = "6")
#EMBUS Tipo de empleo que busca
#ITBU Tiempo buscando empleo
levels(dframe$DISP)<-list("Si" = "1", "No" = "6")
#RZNDIS Razon para no estar disponisble
levels(dframe$EMPANT)<-list("Si" = "1", "No" = "6")

dframe$DTANT<-as.numeric(levels(dframe$DTANT))[dframe$DTANT]
#OCUPA Ocupacion en el ultimo empleo
#ACTA Actividad
# SITUA Situacion profesional ultimo empleo
# OFEMP Inscripcion al paro



# SIDI X Situaciones diversas 
levels(dframe$SIDAC1)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
levels(dframe$SIDAC2)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
levels(dframe$MUN1)<-list("Mismo" = "1", "Distinto" = "6")
levels(dframe$TRAANT)<-list("Si" = "1", "No" = "6")
#$ AOI Relación con la actividad de los entrevistados
#$ CSE Condicion socioeconomica

dframe$FACTOREL<-(as.numeric(levels(dframe$FACTOREL))[dframe$FACTOREL])/100

dframe$NPERS <- NULL
dframe$NCONY <- NULL
dframe$NPADRE <- NULL
dframe$NMADRE <- NULL
dframe$RELLMILI <- NULL
dframe$RELLB <- NULL
dframe$RELLB.1 <- NULL
