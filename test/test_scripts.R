


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")

library(ggplot2)

#Scatterplot


install.packages("GGally")
library(GGally)
#theme_set(theme_minimal(20))

set.seed(1836)

pf<-getData("*","CICLO=176")

pf_subset<-pf[,c(4:7)]
names(pf_subset)
ggpairs(pf_subset[sample.int(nrow(pf_subset),1000), ])


ggpairs(pf_subset[sample.int(nrow(pf_subset),1000), ], 
        lower = list(continuous = wrap("points", shape = I('.'))), 
        upper = list(combo = wrap("box", outlier.shape = I('.'))))




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
