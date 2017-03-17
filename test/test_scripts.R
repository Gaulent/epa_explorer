
library(ggplot2)

source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")

params<-list(ciclo=176)


CCAA<-c(1:17,51,52,"TOTAL")
current_data<-getData("CCAA,FACTOREL", c("CICLO=",params$ciclo," AND SITU IS NOT NULL"),toFactor = FALSE)
a <- (aggregate(current_data$FACTOREL, by=list(CCAA=current_data[,"CCAA"]), FUN=sum))
current_data<-as.data.frame(CCAA)
current_data<-merge(current_data,a,by="CCAA",all.x=TRUE)
current_data[is.na(current_data)] <- 0
current_data[20,]$x<-sum(current_data$x)

past_data<-getData("CCAA,FACTOREL", c("CICLO=",params$ciclo-1," AND SITU IS NOT NULL"),toFactor = FALSE)
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










result <- current_data %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL))
result$hombres <- (filter(current_data, SEXO==1) %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total
result$mujeres <- (filter(current_data, SEXO==6) %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total

ggplot(result, aes(CICLO)) + 
  geom_line(aes(y = total/1000, colour = "var0")) + 
  geom_line(aes(y = hombres/1000, colour = "var1")) +
  geom_line(aes(y = mujeres/1000, colour = "var2")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max(result$total/1000)))




