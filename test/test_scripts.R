


source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")



# Pruebas de Clustering
# ---------------------------------------------------------

selected_atributes <- c("CCAA","PROV","EDAD5", "SEXO", "NAC", "MUN", "REGNA", "ECIV", "NFORMA", "CURSR", "CURSNR", "TRAREM", "AOI", "OFEMP")

dframe<-getData(selected_atributes,c("CICLO=176 AND NIVEL=1"))

dframe <- as.data.frame(unclass(dframe))

indx <- sapply(dframe, is.numeric)
dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = 5, include.lowest = TRUE, ordered_result = TRUE))


dframe <- dframe[sample.int(nrow(dframe),1000), ]

library(klaR)
clusters <- kmodes(na.omit(dframe), 4, iter.max = 2)

plot(dframe[1:2], col = clusters$cluster)


# Pruebas de reglas de asociacion
# ---------------------------------------------------------

dframe<-getData("*","CICLO=176 AND NIVEL=1")

dframe <- as.data.frame(unclass(dframe))

indx <- sapply(dframe, is.numeric)
dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = 5, include.lowest = TRUE, ordered_result = TRUE))

#☻sample_df <- dframe[sample.int(nrow(dframe),100000), ]

sample_df <- na.omit(dframe[, c("CCAA","PROV","EDAD5", "SEXO", "NAC", "MUN", "REGNA", "ECIV", "NFORMA", "CURSR", "CURSNR", "TRAREM", "AOI", "OFEMP", "SIDI1", "SIDI2", "SIDI3", "SIDI4", "SIDI5", "SIDI6", "SIDI7", "SIDAC1", "SIDAC2")])

library(arules)
# find association rules with default settings
rules <- apriori(sample_df, parameter=list(support = 0.1, minlen = 3, maxlen = 3, target= "rules", confidence = 0.7))
inspect(rules[1:20])


library(arulesViz)
plot(rules)

plot(rules[1:20], method="graph", control=list(type="items"))
plot(rules[1:100], method="paracoord", control=list(reorder=TRUE))
