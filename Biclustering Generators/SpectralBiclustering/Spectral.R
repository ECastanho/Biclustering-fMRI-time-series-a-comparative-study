
#This function aims to encapsulate the spectral Biclustering algorithm. For a quick start, just read the next two sections

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

# csv_name = "spectral_Bicluster_",
## This parameter defines a prefix for all generated names

# seed = 24,
## Fixing the seed

# normalization
## Normalization method to apply to mat. Three methods are allowed as described by Kluger et al.: "log" (Logarithmic normalization), "irrc" (Independent Rescal- ing of Rows and Columns) and "bistochastization". If "log" normalization is used, be sure you can apply logarithm to elements in data matrix, if there are val- ues under 1, it automatically will sum to each element in mat (1+abs(min(mat))) Default is "log", as recommended by Kluger et al.

# numberOfEigenvalues
## the number of eigenValues considered to find biclusters. Each row (gene) eigen- Vector will be combined with all column (condition) eigenVectors for the first numberOfEigenValues eigenvalues. Note that a high number could increase dramatically time performance. Usually, only the very first eigenvectors are used. With "irrc" and "bistochastization" methods, first eigenvalue contains background (irrelevant) information, so it is ignored.

# minr
## minimum number of rows that biclusters must have. The algorithm will not consider smaller biclusters.

# minc
## minimum number of columns that biclusters must have. The algorithm will not consider smaller biclusters.

# withinVar
## maximum within variation allowed. Since spectral biclustering outputs a checker- board structure despite of relevance of individual cells, a filtering of only rele- vant cells is necessary by means of this within variation threshold.


#############################################################################
#Libraries
library("biclust")

Spectral <- function(dataset,
                directory_out = "./", 
                csv_name      = "spectral_Bicluster_",
                seed          = 24,
                normalization="log",
                numberOfEigenvalues=3,
                minr=2,
                minc=2,
                withinVar=1
                )
{
  # Setting seed
  set.seed(seed)
  #biclust package demands data matrix
  mydataset <- data.matrix(dataset)
  #Biclustering
  res<-biclust(mydataset,
               method=BCSpectral(),
               normalization=normalization,
               numberOfEigenvalues=numberOfEigenvalues,
               minr=minr,
               minc=minc,
               withinVar=withinVar)
  
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

