############################################################################################################           DATA INPUT AND INITIALIZATION               ####################################################################################################################

#This function aims to encapsulate the FABIA bicluster algorithm. For a quick start, just read the next two sections

##--------------------------------------------------------------##
##                                data output                   ##
##--------------------------------------------------------------##

# A colection of csv files will be saved in the directory_out folder. They will be named "(file_name)**", where * will be the number of the bicluster
# file_name is a given parameter

##--------------------------------------------------------------##
##                                data input                    ##
##--------------------------------------------------------------##

# dataset
## A data frame with the data should be provided

# directory_out = "./", 
## This parameter defines the directory where the csvs associated with the bicluster will be stored

# csv_name = "fabia_Bicluster_",
## This parameter defines a prefix for all generated names

# numbiclusters = 5,
## This parameter defines the maximum number of generated Biclusters. The number of generated csv files could be smaller due to the thesholds.
# In the fabia Software Manual, this corresponds to the "p" parameter of the function fabia

# thresZ = 0.5,
##  threshold for sample belonging to bicluster;

# thresL = NULL,
## thresZ: threshold for sample belonging to bicluster;

# seed = 24,
## Fixing the seed

## For the remaining parameters, read the fabia function in the fabia Software Manual, 

# normalize = TRUE,
# alpha = 0.1,
# cyc = 500,
# spl = 0,
# spz = 0.5,
# random = 1.0,
# center = 2,
# norm = 1,
# scale = 0.0,
# lap = 1,
# nL = 0,
# lL = 0,
# bL = 0



#############################################################################
#Libraries
library(tictoc)
library(fabia)
library(tidyverse)
library(dplyr)

Fabia <- function(dataset,
                  directory_out = "./", 
                  csv_name = "fabia_Bicluster_",
                  numbiclusters = 5,
                  thresZ = 0.5,
                  thresL = NULL,
                  seed = 24,
                  normalize = TRUE,
                  alpha = 0.1,
                  cyc = 500,
                  spl = 0,
                  spz = 0.5,
                  random = 1.0,
                  center = 2,
                  norm = 1,
                  scale = 0.0,
                  lap = 1,
                  nL = 0,
                  lL = 0,
                  bL = 0){
  # Setting seed
  set.seed(seed)
  #normalizing the data
  if (normalize) {
    mydata <- scale(dataset)
  } else {
    mydata <- dataset
  }
  
  # running fabia
  res <- fabia(mydata,
               p=numbiclusters)
  # Extract Biclusters 
  rb <-extractBic(res,
                  thresZ = thresZ,
                  thresL = thresL)
  #generate csv files
  # Save Biclusters in files
  i=1
  for (j in 1:numbiclusters) {
    rowlist = rb$bic[j,]$bixn
    collist = rb$bic[j,]$biypn
    temp <- as.data.frame(mydata[rowlist,collist])
    if ((length(rowlist) > 2 & length(collist) > 2)
        ) {
      rownames(temp) = rowlist
      colnames(temp) = collist
      Name = paste(directory_out, csv_name, toString(i),".csv")
      BicName = gsub(' ','',Name)
      write.csv(temp,file = BicName)
      i = i + 1
    }
  }
  
  
}

##########################################################################################################################################################################################

