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
levels(dframe$CURSR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
levels(dframe$NCURNR)<-list("ED" = "ED", "EM" = "EM", "PE" = "PE")
levels(dframe$NCURSR)<-list("PR" = "PR", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
levels(dframe$CURSNR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
levels(dframe$TRAREM)<-lista_si_no
levels(dframe$AYUDFA)<-lista_si_no
levels(dframe$AUSENT)<-lista_si_no
levels(dframe$DUCON1)<-list("Indefinido" = "1", "Temporal" = "6")
levels(dframe$DUCON3)<-list("01" = "01", "02" = "02", "03" = "03", "04" = "04", "05" = "05", "06" = "06", "07" = "07", "08" = "08")
levels(dframe$DUCON2)<-list("Permanente" = "1", "Discontinuo" = "6")
levels(dframe$PROEST)<-lista_provincia
levels(dframe$REGEST)<-lista_region
levels(dframe$PARCO1)<-list("Completa" = "1", "Parcial" = "6")
levels(dframe$EXTRA)<-lista_si_no
levels(dframe$TRAPLU)<-lista_si_no
levels(dframe$MASHOR)<-list("Si" = "1", "Reduccion" = "2", "No" = "3")
levels(dframe$DISMAS)<-lista_si_no
levels(dframe$BUSOTR)<-lista_si_no
levels(dframe$BUSCA)<-lista_si_no
levels(dframe$DESEA)<-lista_si_no
levels(dframe$FOBACT)<-list("Activos" = "1", "No activos" = "6")
levels(dframe$ASALA)<-lista_si_no
levels(dframe$DISP)<-lista_si_no
levels(dframe$EMPANT)<-lista_si_no
levels(dframe$MUN)<-list("Mismo" = "1", "Distinto" = "6")
levels(dframe$PRORE)<-lista_provincia
levels(dframe$REPAIRE)<-lista_region
#levels(dframe$SIDAC1)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
#levels(dframe$SIDAC2)<-list("Trabajando" = "1", "Buscando Empleo" = "2")
#levels(dframe$TRAANT)<-lista_si_no
