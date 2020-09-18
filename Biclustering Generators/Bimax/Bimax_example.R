# setting the directory
setwd("yourChoice")

# Lets go pick the biclustering functions
source("yourChoice/Bimax.R")

#Loading the simtb Dataset
data = read.table(file = "yourChoice/dataset.csv", header = TRUE, sep = ',', row.names = 1)

Bimax(data)


