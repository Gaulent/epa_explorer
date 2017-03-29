


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")

library(ggplot2)

#install.packages('ggthemes', dependencies = TRUE) 
#library(ggthemes) 
#theme_set(theme_minimal(24)) 

dframe<-getData(c("EDADEST", "DREN"),c("CICLO=176"))

ggplot(aes(x=EDADEST, y=DREN), data = na.omit(dframe)) + 
  geom_point(alpha=1/20, color = 'orange') + 
  xlim(7, 60) + 
  coord_trans(y = 'sqrt') +
  geom_line(stat='summary', fun.y = mean) + 
  geom_line(stat='summary', fun.y = quantile, fun.args = list(probs = .1), linetype = 2, color = 'blue') + 
  geom_line(stat='summary', fun.y = quantile, fun.args = list(probs = .5), color = 'blue') + 
  geom_line(stat='summary', fun.y = quantile, fun.args = list(probs = .9), linetype = 2, color = 'blue') + 
  geom_smooth(method = 'lm', color = 'red')

cor.test(dframe$EDADEST, dframe$DREN)
# 0.3 < significativa, pero pequeña < 0.5 mayor < 0.7

#xlim y coord_trans hay que quitarlos para poner coord_car

ggplot(aes(x=EDADEST, y=DREN), data = na.omit(dframe)) + 
  geom_jitter(alpha=1/20) + 
  xlim(7, 60)

