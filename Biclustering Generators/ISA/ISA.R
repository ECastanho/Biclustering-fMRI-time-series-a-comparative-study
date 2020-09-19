#This function aims to encapsulate the isa bicluster algorithm. For a quick start, just read the next two sections

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

# seed = 24,
## Fixing the seed

## Check the isa2 package documentation for the remaining parameters


#############################################################################
#Libraries
library(isa2)

Isa <- function(dataset,
                directory_out = "./", 
                csv_name      = "isa_Bicluster_",
                seed          = 24,
                thrrow        = seq(1,3,by=0.5),
                thrcol        = seq(1,3,by=0.5),
                noseeds       = 100,
                direction     = c("updown","updown")
                ){
  
  
  # Setting seed
  #set.seed(seed)
  # normalizing the data
  mydataset <- isa.normalize(data.matrix(dataset))$Ec
  # running isa
  modules = isa(mydataset,
                thr.row = thrrow,
                thr.col = thrcol,
                no.seeds = noseeds,
                direction = direction)
  #this line comes from the tutorial.
  mymodules <- lapply(seq(ncol(modules$rows)), function(x) {list(rows = which(modules$rows[, x] != 0),columns = which(modules$columns[, x] != 0))})
  #Generate the bicluster csvs  
  i=1
  for (j in 1:length(mymodules)) {
    rowlist = mymodules[[j]]$rows
    collist = mymodules[[j]]$columns
    if (length(rowlist) > 1 & length(collist) > 1) {
      temp <- as.data.frame(dataset[rowlist,collist])
      rownames(temp) = rownames(dataset)[rowlist]
      colnames(temp) = colnames(dataset)[collist]     
      Name = paste(directory_out, csv_name,toString(i),".csv")
      BicName = gsub(' ','',Name)
      write.csv(temp,file = BicName)
      i = i + 1
    }
  }
}

##########################################################################################################################################################################################

