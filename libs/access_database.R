if(!exists('access_database_R')){
  access_database_R<-T
  
  database_path <- paste(c(getwd(),"/epa_db.db"), collapse="")
  
  cache_ciclo <- NULL
  
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
  
  getAttrDef <- function(filter_by = NULL, withDesc = TRUE, withNone = FALSE) {
    
    library(dplyr)
    
    list_attrdef<-getSQL("SELECT * FROM list_attrdef")
    if (!is.null(filter_by)) list_attrdef<-filter(list_attrdef, type==filter_by)
    else list_attrdef<-filter(list_attrdef, type!="<NA>")
    list_select_attr<-as.list(list_attrdef$name)
    if(withDesc) names(list_select_attr)<-paste(list_attrdef$name,list_attrdef$description,sep = " - ")
    if(withNone) list_select_attr<-append(list_select_attr, list("Vacío"="none"), 0)
    
    return(list_select_attr)
  }
  
  getData <- function(select, where = NULL, updateProgress = NULL, toString = TRUE) {
    
    select <- paste(select,collapse=",")
    
    if (is.null(where))
      sql_query<-paste(c("SELECT", select, "FROM epa_table"),collapse=" ")
    else
      sql_query<-paste(c("SELECT", select, "FROM epa_table WHERE", where),collapse=" ")
    
    if (toString)
      return(mapToString(getSQL(sql_query,updateProgress)))
    else
      return(getSQL(sql_query,updateProgress))
  }
  
  mapToString <- function(dframe) {
    
    for(col in colnames(dframe)) {
      if(!is.null(getMapValues(col))) {
        dframe[,col]<-plyr::mapvalues(dframe[,col],
                                      from=unlist(getMapValues(col),use.names=FALSE),
                                      to=names(getMapValues(col)),warn_missing=FALSE) #Retrocompatibilidad
      }
    }
    
    return(dframe)
  }
  
  getMapValues <- function(attr_name, forceCheck = FALSE) {
    lista_si_no<-list("Si" = "1", "No" = "6")
    lista_region<-list("Álava"="1",  "Albacete"="2",  "Alicante"="3",  "Almería"="4",  "Ávila"="5",  "Badajoz"="6",  "Baleares"="7",  "Barcelona"="8",  "Burgos"="9",  "Cáceres"="10",  "Cádiz"="11",  "Castellón"="12",  "Ciudad Real"="13",  "Córdoba"="14",  "Coruña"="15",  "Cuenca"="16",  "Girona"="17",  "Granada"="18",  "Guadalajara"="19",  "Guipúzcoa"="20",  "Huelva"="21",  "Huesca"="22",  "Jaén"="23",  "León"="24",  "Lleida"="25",  "Rioja"="26",  "Lugo"="27",  "Madrid"="28",  "Málaga"="29",  "Murcia"="30",  "Navarra"="31",  "Orense"="32",  "Asturias"="33",  "Palencia"="34",  "Palmas"="35",  "Pontevedra"="36",  "Salamanca"="37",  "Santa Cruz de Tenerife"="38",  "Cantabria"="39",  "Segovia"="40",  "Sevilla"="41",  "Soria"="42",  "Tarragona"="43",  "Teruel"="44",  "Toledo"="45",  "Valencia"="46",  "Valladolid"="47",  "Vizcaya"="48",  "Zamora"="49",  "Zaragoza"="50",  "Ceuta"="51",  "Melilla"="52", "Resto de Europa" = "100", "UE-15" = "115", "UE-25" = "125", "UE-27" = "127", "UE-28" = "128", "África" = "200", "Norteamérica" = "300", "Centroamérica" = "310", "Sudamérica" = "350", "Asia Oriental" = "400", "Asia Occidental" = "410", "Asia del Sur" = "420", "Oceanía" = "500", "Portugal" = "600", "Francia" = "610", "Andorra" = "620", "Marruecos" = "630", "Apátridas" = "999")
    lista_boolean<-list("Si" = "1", "No" = "0")
    
    return(switch(attr_name,
                  CICLO={
                    if(is.null(cache_ciclo) | forceCheck) {
                      tmp_ciclo<-getSQL("SELECT DISTINCT CICLO FROM epa_table")
                      cache_ciclo<<-as.list(tmp_ciclo$CICLO)
                      names(cache_ciclo)<<-paste((tmp_ciclo$CICLO+2)%/%4+1972,(tmp_ciclo$CICLO+2)%%4+1,sep = "T")
                    }
                    cache_ciclo
                  },
                  CCAA=list("Andalucía"="1", "Aragón"="2", "Asturias"="3", "Baleares"="4", "Canarias"="5", "Cantabria"="6", "Castilla y León"="7", "Castilla-La Mancha"="8", "Cataluña"="9", "Comunidad Valenciana"="10", "Extremadura"="11", "Galicia"="12", "Comunidad de Madrid"="13", "Región de Murcia"="14", "Navarra"="15", "País Vasco"="16", "La Rioja"="17", "Ceuta"="51", "Melilla"="52"),
                  PROV=lista_region,
                  SEXO=list("V"="1",  "M"="6"),
                  ECIV=list("Soltero"="1", "Casado"="2", "Viudo"="3", "Separado"="4"),
                  REGNA=lista_region,
                  NAC=list("Española"="1",  "Doble"="2", "Extrangera"="3"),
                  EXREGNA=lista_region,
                  NFORMA=list("AN" = "AN", "P1" = "P1", "P2" = "P2", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU"),
                  CURSR=list("Si" = "1", "En vacaciones" = "2", "No" = "3"),
                  NCURSR=list("PR" = "PR", "S1" = "S1", "SG" = "SG", "SP" = "SP", "SU" = "SU"),
                  CURSNR=list("Si" = "1", "En vacaciones" = "2", "No" = "3"),
                  NCURNR=list("ED" = "ED", "EM" = "EM", "PE" = "PE"),
                  TRAREM=lista_si_no,
                  AYUDFA=lista_si_no,
                  AUSENT=lista_si_no,
                  SP=list("Admin. central" = "1.0", "Admin. de SS" = "2.0", "Admin. de CA" = "3.0", "Admin. local" = "4.0", "Empresas públicas" = "5.0", "No sabe" = "0.0"),
                  DUCON1=list("Indefinido" = "1", "Temporal" = "6"),
                  DUCON2=list("Permanente" = "1", "Discontinuo" = "6"),
                  DUCON3=list("1" = "1", "2" = "2", "3" = "3", "4" = "4", "5" = "5", "6" = "6", "7" = "7", "8" = "8"),
                  REGEST=lista_region,
                  PARCO1=list("Completa" = "1", "Parcial" = "6"),
                  EXTRA=lista_si_no,
                  TRAPLU=lista_si_no,
                  MASHOR=list("Si" = "1", "Reduccion" = "2", "No" = "3"),
                  DISMAS=lista_si_no,
                  BUSOTR=lista_si_no,
                  BUSCA=lista_si_no,
                  DESEA=lista_si_no,
                  FOBACT=list("Activos" = "1", "No activos" = "6"),
                  ASALA=list("No sabe" = "0", "Si" = "1", "No" = "6"),
                  DISP=lista_si_no,
                  EMPANT=lista_si_no,
                  SIDI1=lista_boolean,
                  SIDI2=lista_boolean,
                  SIDI3=lista_boolean,
                  SIDI4=lista_boolean,
                  SIDI5=lista_boolean,
                  SIDI6=lista_boolean,
                  SIDI7=lista_boolean,
                  SIDAC1=lista_boolean,
                  SIDAC2=lista_boolean,
                  MUN=list("Mismo" = "1", "Distinto" = "6"),
                  REPAIRE=lista_region,
                  NULL
    )
    )
  }
}
