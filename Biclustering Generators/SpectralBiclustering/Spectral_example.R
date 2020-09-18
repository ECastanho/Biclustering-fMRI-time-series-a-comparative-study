# setting the directory
setwd("yourChoice")

# Lets go pick the biclustering functions
source("yourChoice/Spectral.R")

#Loading the dataset
data = read.table(file = "yourchoice/dataset.csv", header = TRUE, sep = ',', row.names = 1)

#Running the Spectral Algorithm
Spectral(data)
