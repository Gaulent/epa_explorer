


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")



library(klaR)

dframe<-getData("*","CICLO=176")
dframe <- as.data.frame(unclass(dframe))
kmodes(na.omit(dframe[, 20:24]), 4, iter.max = 2)




# -------------------------------- IMPORTANTE -----------------------
# Para comparar cosas en el tiempo.

library(dplyr)
pf.fc_by_age_months <- pf %.%
  group_by(age_with_months) %.%
  summarise(friend_count_mean = mean(friend_count),
            friend_count_median = median(friend_count),
            n = n()) %.%
  arrange(age_with_months)

head(pf.fc_by_age_months)
