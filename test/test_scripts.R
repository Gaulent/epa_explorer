


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")

library(ggplot2)

#install.packages('ggthemes', dependencies = TRUE) 
#library(ggthemes) 
#theme_set(theme_minimal(24)) 

dframe<-getData(c("EDAD5", "ANORE","FACTOREL"),c("CICLO=176"))

qplot(data=dframe, x=ANORE)

#---------- IMPLEMENTAR ESTO EN LA INTERFAZ

ggplot(data=na.omit(dframe), aes_string(x="ANORE")) + 
  geom_histogram(binwidth = 1, color = 'black', fill = '#099DD9') + #Ajustar ancho de columna
  facet_wrap("SEXO", ncol=2) + #Dividir por un factor
  scale_x_continuous(limits = c(0, 20), breaks = 1:31) + #Limitar el conjunto de datos
  scale_x_log10()
  scale_x_sqrt()

  ggplot(data=na.omit(dframe), aes_string(x="EDAD5")) + 
    geom_histogram(bins=20, color = 'black', fill = '#099DD9')

  ggplot(data=na.omit(dframe), aes_string(x="ANORE")) + 
    geom_freqpoly(aes_string(color = "SEXO")) #Ajustar ancho de columna

  ggplot(data=na.omit(dframe), aes_string(x="SEXO", y="ANORE")) + 
    geom_boxplot() +#Ajustar ancho de columna
    #scale_y_continuous(limits = c(0, 50))
    coord_cartesian(ylim = c(0, 50))
  
# --------------
  
  
  
  
  ggplot(aes(x = friend_count, y = ..count../sum(..count..)), data = subset(pf, !is.na(gender))) + 
    geom_freqpoly(aes(color = gender), binwidth=1)












current_data<-getData("CICLO, SEXO, FACTOREL", "SITU IS NOT NULL AND CICLO >= 155")
result <- current_data %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL))
result$hombres <- (filter(current_data, SEXO=="V") %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total
result$mujeres <- (filter(current_data, SEXO=="M") %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total

ggplot(result, aes(155:176)) + 
  geom_line(aes(y = total/1000, colour = "var0")) + 
  geom_line(aes(y = hombres/1000, colour = "var1")) +
  geom_line(aes(y = mujeres/1000, colour = "var2"))


