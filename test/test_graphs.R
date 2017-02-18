library(ggplot2)
library(RSQLite)

source("../global.R")

params<-list(ciclo=176)

grafica<-0

for (i in 0:6) {

  current_data<-getData("FACTOREL", c("CICLO=",params$ciclo-i*4," AND SITU=7"))
  past_data<-getData("FACTOREL", c("CICLO=",params$ciclo-i*4-1," AND SITU=7"))
  grafica[7-i] <- (sum(current_data$FACTOREL) - sum(past_data$FACTOREL))

}

datos_publico<-round(grafica/1000,digits = 1)

for (i in 0:6) {
  
  current_data<-getData("FACTOREL", c("CICLO=",params$ciclo-i*4," AND SITU<>7"))
  past_data<-getData("FACTOREL", c("CICLO=",params$ciclo-i*4-1," AND SITU<>7"))
  grafica[7-i] <- (sum(current_data$FACTOREL) - sum(past_data$FACTOREL))
  
}

datos_privado<-round(grafica/1000,digits = 1)



nombres = c("T3-2010","T3-2011","T3-2012","T3-2013","T3-2014","T3-2015","T3-2016")
colores = c("red3","gold1")
main_text = "Evolución del total de ocupados, en tasa anual"

datos <- rbind(datos_publico,datos_privado)

ylim <- c(1.2*min(datos), 1.2*max(datos))
bp <- barplot(datos,beside=TRUE,names.arg=nombres, col = colores, border=NA, main=main_text, cex.names=0.75, cex.axis = 0.75,ylim=ylim)
text(x = bp, y = datos, label = datos, pos = 3, cex = 0.75,adj = c(0.5,1))
axis(1,pos=0,labels=FALSE, at = seq(1.5,25.5,2),outer=TRUE)
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






