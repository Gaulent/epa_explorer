


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")



library(klaR)

dframe<-getData("*","CICLO=176")
dframe <- as.data.frame(unclass(dframe))
kmodes(na.omit(dframe[, 20:24]), 4, iter.max = 2)

# utilizar ??cut para discretizar variables numericas