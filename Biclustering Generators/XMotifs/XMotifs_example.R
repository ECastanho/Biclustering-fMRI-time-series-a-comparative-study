# setting the directory
setwd("yourChoice")

# Lets go pick the biclustering functions
source("yourChoice/XMotifs.R")

#Loading the Dataset
data = read.table(file = "yourchoice/dataset.csv", header = TRUE, sep = ',', row.names = 1)

Xmotifs(dataset = data),


