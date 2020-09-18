# setting the directory
setwd("yourchoice")

# Lets go pick the biclustering functions
source("yourchoice/XMotifs.R")

#Loading the simtb Dataset
data = read.table(file = "yourchoice/dataset.csv", header = TRUE, sep = ',', row.names = 1)

Xmotifs(dataset = data),


