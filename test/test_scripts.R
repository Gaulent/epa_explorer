


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")



# Pruebas de Clustering
# ---------------------------------------------------------

dframe<-getData("*","CICLO=176")

dframe <- as.data.frame(unclass(dframe))

indx <- sapply(dframe, is.numeric)
dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = 5, include.lowest = TRUE, ordered_result = TRUE))


dframe <- dframe[sample.int(nrow(dframe),1000), ]

library(klaR)
kmodes(na.omit(dframe[, 2:5]), 4, iter.max = 2)

# Pruebas de reglas de asociacion
# ---------------------------------------------------------

dframe<-getData("*","CICLO=176")

dframe <- as.data.frame(unclass(dframe))

indx <- sapply(dframe, is.numeric)
dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = 5, include.lowest = TRUE, ordered_result = TRUE))

dframe <- dframe[sample.int(nrow(dframe),1000), ]

library(arules)
# find association rules with default settings
rules <- apriori(na.omit(dframe[, 2:5]))
inspect(rules)
