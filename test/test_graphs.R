library(ggplot2)
library(RSQLite)

getData <- function(select, where) {
  con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
  sql_query<-paste(c("SELECT ", select, " FROM epa_table WHERE ", where),collapse="")
  rs <- dbSendQuery(con, sql_query)
  result_data<-dbFetch(rs,n=-1)
  dbClearResult(rs)
  dbDisconnect(con)
  return(result_data)
}

grafica<-0
params<-list(ciclo=176)

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






