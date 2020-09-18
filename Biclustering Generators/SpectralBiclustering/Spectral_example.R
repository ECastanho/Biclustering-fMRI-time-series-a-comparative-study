# setting the directory
setwd("yourchoice")

# Lets go pick the biclustering functions
source("yourchoice/Spectral.R")

#Loading the dataset
data = read.table(file = "yourchoice/dataset.csv", header = TRUE, sep = ',', row.names = 1)

Spectral(data)