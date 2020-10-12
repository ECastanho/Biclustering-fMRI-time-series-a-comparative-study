############################################################################################################           DATA INPUT AND INITIALIZATION               ####################################################################################################################

#This function aims to encapsulate the XMotifs bicluster algorithm. For a quick start, just read the next two sections

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

# csv_name = "xmotifs_Bicluster_",
## This parameter defines a prefix for all generated names

# seed = 24,
## Fixing the seed

# ns	
## Number of columns choosen.
 
# nd	
## Number of repetitions.
 
# sd	
## Sample size in repetitions.
 
# alpha	
## Scaling factor for column result.
 
# number	
## Number of bicluster to be found.

# nsymbols
## Number of symbols to be used in the Bimax descritization step

#############################################################################
#Libraries
library("biclust")

Xmotifs <- function(dataset,
                  directory_out = "./", 
                  csv_name      = "xmotifs_Bicluster_",
                  seed          = 24,
                  ns=10,
                  nd=10,
                  sd=5,
                  alpha=0.05,
                  number=100,
                  nsymbols = 2)
{
  
  mydata =  data.matrix(discretize(dataset,nsymbols))
  # Setting seed
  set.seed(seed)
  #Biclustering
  res<-biclust(mydata,
               method=BCXmotifs(),
               ns=ns,
               nd=nd,
               sd=sd,
               alpha=alpha,
               number=number)
  
  #extract biclusters
  temp <- bicluster(dataset, res)
  # Save Biclusters in files
  i=1
  for (j in 1:res@Number) {
    rowlist = length(temp[[j]][1,])
    collist = length(temp[[j]][,1])
    if (rowlist > 1 & collist > 1) {
      Name = paste(directory_out, csv_name,toString(i),".csv")
      BicName = gsub(' ','',Name)
      write.csv(temp[[j]],file = BicName)
      i = i + 1
    }
  }
}

##########################################################################################################################################################################################

