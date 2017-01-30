#install.packages("plyr")
library(plyr)

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