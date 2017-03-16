if(!exists('access_database_R')){
  access_database_R<-T
  
  database_path <- "D:/workarea/epa_explorer/epa_db.db"
  
  getSQL <- function(sql_query, updateProgress = NULL) {
    
    library(RSQLite)
    library(dplyr)
    
    con <- dbConnect(RSQLite::SQLite(), database_path)
    rs <- dbSendQuery(con, sql_query)
    
    i <- 0
    datalist = list()
    while (!dbHasCompleted(rs)) {
      datalist[[i<-i+1]]<-dbFetch(rs, 100000)
      if (is.function(updateProgress)) updateProgress(detail=dbGetRowCount(rs))
    }

    dbClearResult(rs)
    dbDisconnect(con)
    return(bind_rows(datalist))
  }
  
  getData <- function(select, where = NULL, updateProgress = NULL, toFactor = TRUE) {
    
    select <- paste(select,collapse=",")
    
    if (is.null(where))
      sql_query<-paste(c("SELECT", select, "FROM epa_table"),collapse=" ")
    else
      sql_query<-paste(c("SELECT", select, "FROM epa_table WHERE", where),collapse=" ")
    
    if (toFactor)
      return(mapToFactor(getSQL(sql_query,updateProgress)))
    else
      return(getSQL(sql_query,updateProgress))
  }
  
  mapToFactor <- function(dframe) {
    
    dframe <- as.data.frame(unclass(dframe)) #Todos los char a factor.
    
    lista_si_no<-list("Si" = "1", "No" = "6")
    lista_region<-list("Álava"="1",  "Albacete"="2",  "Alicante"="3",  "Almería"="4",  "Ávila"="5",  "Badajoz"="6",  "Baleares"="7",  "Barcelona"="8",  "Burgos"="9",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52", "Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "África" = "200", "Norteamérica" = "300", "Centroamérica" = "310", "Sudamérica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceanía" = "500", "Portugal" = "600", "Francia" = "610", "Andorra" = "620", "Marruecos" = "630", "Apátridas" = "999")
    
    if("CCAA" %in% colnames(dframe))    levels(dframe$CCAA)<-list("Andalucía"="1", "Aragón"="2", "Asturias"="3", "Baleares"="4", "Canarias"="5", "Cantabria"="6", "Castilla y León"="7", "Castilla-La Mancha"="8", "Cataluña"="9", "Comunidad Valenciana"="10", "Extremadura"="11", "Galicia"="12", "Comunidad de Madrid"="13", "Región de Murcia"="14", "Navarra"="15", "País Vasco"="16", "La Rioja"="17", "Ceuta"="51", "Melilla"="52")
    if("PROV" %in% colnames(dframe))    levels(dframe$PROV)<-lista_region
    if("SEXO" %in% colnames(dframe))    levels(dframe$SEXO)<-list("V"="1",  "M"="6")
    if("ECIV" %in% colnames(dframe))    levels(dframe$ECIV)<-list("Soltero"="1", "Casado"="2", "Viudo"="3", "Separado"="4")
    if("REGNA" %in% colnames(dframe))   levels(dframe$REGNA)<-lista_region
    if("NAC" %in% colnames(dframe))     levels(dframe$NAC)<-list("Española"="1",  "Doble"="2", "Extrangera"="3")
    if("EXREGNA" %in% colnames(dframe)) levels(dframe$EXREGNA)<-lista_region
    if("NFORMA" %in% colnames(dframe))  levels(dframe$NFORMA)<-list("AN" = "AN", "P1" = "P1", "P2" = "P2", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
    if("CURSR" %in% colnames(dframe))   levels(dframe$CURSR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
    if("NCURNR" %in% colnames(dframe))  levels(dframe$NCURNR)<-list("ED" = "ED", "EM" = "EM", "PE" = "PE")
    if("NCURSR" %in% colnames(dframe))  levels(dframe$NCURSR)<-list("PR" = "PR", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU")
    if("CURSNR" %in% colnames(dframe))  levels(dframe$CURSNR)<-list("Si" = "1", "En vacaciones" = "2", "No" = "3")
    if("TRAREM" %in% colnames(dframe))  levels(dframe$TRAREM)<-lista_si_no
    if("AYUDFA" %in% colnames(dframe))  levels(dframe$AYUDFA)<-lista_si_no
    if("AUSENT" %in% colnames(dframe))  levels(dframe$AUSENT)<-lista_si_no
    if("DUCON1" %in% colnames(dframe))  levels(dframe$DUCON1)<-list("Indefinido" = "1", "Temporal" = "6")
    if("DUCON3" %in% colnames(dframe))  levels(dframe$DUCON3)<-list("1" = "1", "2" = "2", "3" = "3", "4" = "4", "5" = "5", "6" = "6", "7" = "7", "8" = "8")
    if("DUCON2" %in% colnames(dframe))  levels(dframe$DUCON2)<-list("Permanente" = "1", "Discontinuo" = "6")
    if("REGEST" %in% colnames(dframe))  levels(dframe$REGEST)<-lista_region
    if("PARCO1" %in% colnames(dframe))  levels(dframe$PARCO1)<-list("Completa" = "1", "Parcial" = "6")
    if("EXTRA" %in% colnames(dframe))   levels(dframe$EXTRA)<-lista_si_no
    if("TRAPLU" %in% colnames(dframe))  levels(dframe$TRAPLU)<-lista_si_no
    if("MASHOR" %in% colnames(dframe))  levels(dframe$MASHOR)<-list("Si" = "1", "Reduccion" = "2", "No" = "3")
    if("DISMAS" %in% colnames(dframe))  levels(dframe$DISMAS)<-lista_si_no
    if("BUSOTR" %in% colnames(dframe))  levels(dframe$BUSOTR)<-lista_si_no
    if("BUSCA" %in% colnames(dframe))   levels(dframe$BUSCA)<-lista_si_no
    if("DESEA" %in% colnames(dframe))   levels(dframe$DESEA)<-lista_si_no
    if("FOBACT" %in% colnames(dframe))  levels(dframe$FOBACT)<-list("Activos" = "1", "No activos" = "6")
    if("ASALA" %in% colnames(dframe))   levels(dframe$ASALA)<-lista_si_no
    if("DISP" %in% colnames(dframe))    levels(dframe$DISP)<-lista_si_no
    if("EMPANT" %in% colnames(dframe))  levels(dframe$EMPANT)<-lista_si_no
    if("MUN" %in% colnames(dframe))     levels(dframe$MUN)<-list("Mismo" = "1", "Distinto" = "6")
    if("REPAIRE" %in% colnames(dframe)) levels(dframe$REPAIRE)<-lista_region
    
    return(dframe)
  }
}