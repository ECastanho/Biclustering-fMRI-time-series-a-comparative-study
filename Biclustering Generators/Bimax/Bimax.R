############################################################################################################           DATA INPUT AND INITIALIZATION               ####################################################################################################################

#This function aims to encapsulate the bimax bicluster algorithm. For a quick start, just read the next two sections

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

# csv_name = "bimax_Bicluster_",
## This parameter defines a prefix for all generated names

# seed = 24,
## Fixing the seed

# BCrepBimax    = TRUE,
## In the Biclust package, there are two signature: one is "BCBimax", and the other is "BCrepBimax". At this point, I have no idea what are the diferences. A diference is that, "BCBimax" doesn't allow the maxc parameter, so, at this point, this function allow both to exist

# minr          = 2,
## Minimum row size of resulting bicluster.

# minc          = 2,
## Minimum column size of resulting bicluster.

# number        = 100,
## Number of Bicluster to be found.

# maxc          = 12,
## Maximum column size of resulting bicluster.

#############################################################################
#Libraries
library("biclust")

Bimax <- function(dataset,
                directory_out = "./", 
                csv_name      = "bimax_Bicluster_",
                seed          = 24,
                BCrepBimax    = FALSE,
                minr          = 2,
                minc          = 2,
                number        = 100,
                maxc          = 12)
  {
  # Setting seed
  set.seed(seed)
  #bimax data should be binary
  mydata3 <- binarize(data.matrix(dataset))
  #Biclustering
  if (BCrepBimax) {
    res<-biclust(mydata3,
                 method=BCrepBimax(),
                 minr = minr,
                 minc = minc,
                 number = number,
                 maxc = maxc)  
  }else{
    res<-biclust(mydata3,
                 method=BCBimax(),
                 minr = minr,
                 minc = minc,
                 number = number
                 )
  }
  #extract biclusters
  temp <- bicluster(dataset, res)
  # Save Biclusters in files
  i=1
  for (j in 1:res@Number) {
    rowlist = length(temp[[j]][1,])
    collist = length(temp[[j]][,1])
    if (rowlist > 1 | collist > 1) {
      Name = paste(directory_out, csv_name,toString(i),".csv")
      BicName = gsub(' ','',Name)
      write.csv(temp[[j]],file = BicName)
      i = i + 1
    }
  }
}

##########################################################################################################################################################################################

