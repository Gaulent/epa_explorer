library(ggplot2)
library(RSQLite)
library(plyr)

source("../global.R", encoding = "UTF-8")

params<-list(ciclo=176)



grafica<-0

current_data<-getData("CICLO,SITU,BUSCA,FOBACT,NUEVEM,DISP,CCAA,AOI,FACTOREL", c("CICLO BETWEEN",params$ciclo-25,"AND",params$ciclo))

# Preparar recalculo


for (i in 0:6) {
  
  current_data<-getData("FACTOREL", c("CICLO=",params$ciclo-4*i," AND SITU IS NOT NULL"))
  past_data<-getData("FACTOREL", c("CICLO=",params$ciclo-4*i-1," AND SITU IS NOT NULL"))
  grafica[7-i] <- sum(current_data$FACTOREL) - sum(past_data$FACTOREL)
  
}

datos<-round(grafica/1000,digits = 1)
nombres = c("T3-2010","T3-2011","T3-2012","T3-2013","T3-2014","T3-2015","T3-2016")
colores = c("gold1","gold1","gold1","gold1","gold1","gold1","red3")
main_text = "Evolución intertrimestral de la ocupación, en miles\n(variación del 3er trimestre sobre el 2º del mismo año)"

ylim <- c(1.2*min(datos), 1.2*max(datos))
bp <- barplot(datos,space=1,names.arg=nombres, col = colores, border=NA, main=main_text, cex.names=0.75, cex.axis = 0.75,ylim=ylim)
text(x = bp, y = datos, label = datos, pos = 3, cex = 0.75,adj = c(0.5,1))
axis(1,pos=0,labels=FALSE, at = seq(1.5,13.5,2),outer=TRUE)
abline(h=0)





















grafica<-0


CCAA<-c(1:17,51,52,"TOTAL")
current_data<-getData("CCAA,FACTOREL", c("CICLO=",176," AND SITU IS NOT NULL"))
a <- (aggregate(current_data$FACTOREL, by=list(CCAA=current_data[,"CCAA"]), FUN=sum))
current_data<-as.data.frame(CCAA)
current_data<-merge(current_data,a,by="CCAA",all.x=TRUE)
current_data[is.na(current_data)] <- 0
current_data[20,]$x<-sum(current_data$x)

past_data<-getData("CCAA,FACTOREL", c("CICLO=",172," AND SITU IS NOT NULL"))
a <- (aggregate(past_data$FACTOREL, by=list(CCAA=past_data[,"CCAA"]), FUN=sum))
past_data<-as.data.frame(CCAA)
past_data<-merge(past_data,a,by="CCAA",all.x=TRUE)
past_data[is.na(past_data)] <- 0
past_data[20,]$x<-sum(past_data$x)

current_data$x<-round((current_data$x-past_data$x)/past_data$x*100,2)
current_data$colores<-"gold1"
current_data[20,]$colores<-"red3"


datos<-current_data[with(current_data, order(x)), ]

datos$CCAA<-mapvalues(datos$CCAA,from=map_ccaa$value, to=map_ccaa$label) #Retrocompatibilidad


main_text = "Tasa de variación trimestral de la ocupación por comunidades autónomas (%)"

par(mar=c(2,8,4,2)+0.1,cex.axis=0.75) #default par(mar=c(5,5,5,5))
ylim <- c(0, 43)
xlim <- c(ifelse(min(datos$x)<0, min(datos$x), 0) , ifelse(max(datos$x)>0, max(datos$x), 0)*1.2)
bp<-barplot(datos$x,horiz=TRUE,space=1,col=datos$colores,border=NA, main=main_text,axes=FALSE, names.arg=datos$CCAA,las=1,ylim=ylim,xlim=xlim)
axis(2,pos=0,labels=FALSE, at = seq(-0.5,41.5,2))
axis(3,pos=41.5, at = seq(-2,8,1))
text(x=datos$x, y = bp, label = datos$x,adj = c(-0.5,0.5),cex=0.75)
par(mar=c(5, 4, 4, 2) + 0.1,cex.axis=1) #margenes por defecto






















CCAA<-c(1:17,51,52,"TOTAL")
current_data<-getData("CCAA,FACTOREL", c("CICLO=",176," AND SITU IS NOT NULL"))
a <- (aggregate(current_data$FACTOREL, by=list(CCAA=current_data[,"CCAA"]), FUN=sum))
current_data<-as.data.frame(CCAA)
current_data<-merge(current_data,a,by="CCAA",all.x=TRUE)
current_data[is.na(current_data)] <- 0
current_data[20,]$x<-sum(current_data$x)

past_data<-getData("CCAA,FACTOREL", c("CICLO=",175," AND SITU IS NOT NULL"))
a <- (aggregate(past_data$FACTOREL, by=list(CCAA=past_data[,"CCAA"]), FUN=sum))
past_data<-as.data.frame(CCAA)
past_data<-merge(past_data,a,by="CCAA",all.x=TRUE)
past_data[is.na(past_data)] <- 0
past_data[20,]$x<-sum(past_data$x)

current_data$x<-round((current_data$x-past_data$x)/past_data$x*100,2)
current_data$colores<-"gold1"
current_data[20,]$colores<-"red3"


datos<-current_data[with(current_data, order(x)), ]

datos$CCAA<-mapvalues(datos$CCAA,from=map_ccaa$value, to=map_ccaa$label) #Retrocompatibilidad


main_text = "Tasa de variación trimestral de la ocupación por comunidades autónomas (%)"

par(mar=c(2,8,5,5)) #default par(mar=c(5,5,5,5))
ylim <- c(0, 45)
xlim <- c(1.2*min(datos$x), 1.2*max(datos$x))
bp<-barplot(datos$x,horiz=TRUE,space=1,col=datos$colores,border=NA, main=main_text,axes=FALSE, names.arg=datos$CCAA,las=1, cex.names=0.75,ylim=ylim,xlim=xlim)
axis(2,pos=0,labels=FALSE, at = seq(1.5,39.5,2))
axis(3,pos=41.5, at = seq(-2,8,1))
text(x=datos$x, y = bp, label = datos$x, cex = 0.75,adj = c(-0.5,0.5))



ylim <- c(1.2*min(datos$x), 1.2*max(datos$x))
bp <- barplot(datos$x,space=1,horiz=TRUE,names.arg=datos$CCAA, col = colores, border=NA, main=main_text, cex.names=0.75, cex.axis = 0.75,ylim=ylim)
text(x = bp, y = datos$x, label = datos$x, pos = 3, cex = 0.75,adj = c(0.5,1))
axis(1,pos=0,labels=FALSE, at = seq(1.5,13.5,2),outer=TRUE)
abline(h=0)






#---------------------------


a$SEXO1<-as.factor(a$SEXO1)
levels(a$SEXO1)<-list("Andaluc?a", "Arag?n", "Asturias", "Baleares", "Canarias", "Cantabria", "Castilla-Le?n", "Castilla-La Mancha", "Catalu?a", "Comunidad Valenciana", "Extremadura", "Galicia", "Madrid", "Murcia", "Navarra", "Pa?s Vasco", "Rioja", "Ceuta", "Melilla")
a


#--------





current_data<-getData("*", c("CICLO=",175," AND SITU IS NOT NULL"))
a <- (aggregate(current_data$FACTOREL, by=list(SEXO1=current_data[,"CCAA"]), FUN=sum))

a$SEXO1<-as.factor(a$SEXO1)
levels(a$SEXO1)<-list("Andaluc?a"=1, "Arag?n"=2, "Asturias"=3, "Baleares"=4, "Canarias"=5, "Cantabria"=6, "Castilla-Le?n"=7, "Castilla-La Mancha"=8, "Catalu?a"=9, "Comunidad Valenciana"=10, "Extremadura"=11, "Galicia"=12, "Madrid"=13, "Murcia"=14, "Navarra"=15, "Pa?s Vasco"=16, "Rioja"=17, "Ceuta"=51, "Melilla"=52)
a


for (i in 0:6) {
  
  current_data<-getData("FACTOREL", c("CICLO=",params$ciclo-4*i," AND ((BUSCA=1 AND FOBACT=1) OR NUEVEM=1) AND DISP=1"))
  past_data<-getData("FACTOREL", c("CICLO=",params$ciclo-4*i-1," AND ((BUSCA=1 AND FOBACT=1) OR NUEVEM=1) AND DISP=1"))
  grafica[7-i] <- sum(current_data$FACTOREL) - sum(past_data$FACTOREL)
  
}

datos<-round(grafica/1000,digits = 1)
nombres = c("T3-2010","T3-2011","T3-2012","T3-2013","T3-2014","T3-2015","T3-2016")
colores = c("gold1","gold1","gold1","gold1","gold1","gold1","red3")
main_text = "Evolución intertrimestral de la ocupación, en miles\n(variación del 3er trimestre sobre el 2º del mismo año)"

ylim <- c(1.2*min(datos), 1.2*max(datos))
bp <- barplot(datos,space=1,names.arg=nombres, col = colores, border=NA, main=main_text, cex.names=0.75, cex.axis = 0.75,ylim=ylim)
text(x = bp, y = datos, label = datos, pos = 3, cex = 0.75,adj = c(0.5,1))
axis(1,pos=0,labels=FALSE, at = seq(1.5,13.5,2),outer=TRUE)
abline(h=0)




















x <- c(0.0001, 0.0059, 0.0855, 0.9082)
y <- c(0.54, 0.813, 0.379, 0.35)
# create a two row matrix with x and y
height <- rbind(datos_publico, datos_privado)
# Use height and set 'beside = TRUE' to get pairs
# save the bar midpoints in 'mp'
# Set the bar pair labels to A:D
mp <- barplot(height, beside = TRUE)
# Nel caso generale, i.e., che si usa di
# solito (height MUST be a matrix)
mp <- barplot(height, beside = TRUE)
# Draw the bar values above the bars
text(mp, height, labels = format(height, 4),
     pos = 3, cex = .75)












nombres = c("T3-2010","T3-2011","T3-2012","T3-2013","T3-2014","T3-2015","T3-2016")
colores = c("red3","gold1")
main_text = "Evolución del total de ocupados, en tasa anual"

datos <- rbind(datos_publico,datos_privado)

ylim <- c(1.2*min(datos), 1.2*max(datos))
bp <- barplot(datos,beside=TRUE,names.arg=nombres, col = colores, border=NA, main=main_text, cex.names=0.75, cex.axis = 0.75,ylim=ylim)
text(x = bp, y = datos, label = datos, pos = 3, cex = 0.75,adj = c(0.5,1))
axis(1,pos=0,labels=FALSE, at = seq(1.5,25.5,2),outer=TRUE)
abline(h=0)




dtf <- data.frame(y = datos,
                  x = nombres)
ggplot(dtf, aes(x, y)) +
  ggtitle(main_text,subtitle="test") +
  geom_bar(stat = "identity", aes(fill = x), show.legend = FALSE, width = 0.5) + 
  geom_text(aes(label = y,
            vjust = ifelse(y >= 0, -0.5, 1.5))) + 
  geom_hline(data=seq(1.5,13.5,2),yintercept = 0) +
scale_fill_manual(values=c("gold1","gold1","gold1","gold1","gold1","gold1","red3")) 




















##-------- Ejemplo con ggplot2

library(plyr)
library(ggplot2)
library(scales)
dtf <- data.frame(x = c("ETB", "PMA", "PER", "KON", "TRA", 
                        "DDR", "BUM", "MAT", "HED", "EXP"),
                  y = c(.02, .11, -.01, -.03, -.03, .02, .1, -.01, -.02, 0.06))
ggplot(dtf, aes(x, y)) +
  geom_bar(stat = "identity", aes(fill = x), show.legend = FALSE) + 
  geom_text(aes(label = paste(y * 100, "%"),
                vjust = ifelse(y >= 0, 0, 1))) +
  scale_y_continuous("Anteil in Prozent", labels = percent_format())






