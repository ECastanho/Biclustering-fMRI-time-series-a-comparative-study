# The objective of this analysis is to test the default parameters of the Biclustering FABIA method

# setting the directory
setwd("yourChoice")

# Lets go pick the biclustering function
source("yourChoice/FABIA.R")

#Loading the simtb Dataset
data = read.table(file = "yourChoice/dataset.csv", header = TRUE, sep = ',', row.names = 1)

#Running the Fabia Algorithm
Fabia(dataset = data)  


