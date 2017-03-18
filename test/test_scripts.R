
library(ggplot2)

source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")


current_data<-getData("CICLO, SEXO, FACTOREL", "SITU IS NOT NULL AND CICLO >= 155")
result <- current_data %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL))
result$hombres <- (filter(current_data, SEXO=="V") %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total
result$mujeres <- (filter(current_data, SEXO=="M") %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total

ggplot(result, aes(155:176)) + 
  geom_line(aes(y = total/1000, colour = "var0")) + 
  geom_line(aes(y = hombres/1000, colour = "var1")) +
  geom_line(aes(y = mujeres/1000, colour = "var2"))







