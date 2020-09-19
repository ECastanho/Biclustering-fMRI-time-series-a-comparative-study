#This function aims to encapsulate the Spectral Clustering algorithm. For a quick start, just read the next two sections

##--------------------------------------------------------------##
##                                data output                   ##
##--------------------------------------------------------------##

# A colection of csv files will be saved in the directory_out folder. They will be named "(file_name)**", where * will be the number of the bicluster
# file_name is a given parameter



##--------------------------------------------------------------##
##                                data input                    ##
##--------------------------------------------------------------##


# data
## A data frame with the data should be provided

# directory_out = "./", 
## This parameter defines the directory where the csvs associated with the bicluster will be stored

# csv_name = "Clusteringspectral_Cluster_",
## This parameter defines a prefix for all generated names

# for the remaining parameters, check:
# https://scikit-learn.org/stable/modules/generated/sklearn.cluster.SpectralClustering.html


# General Python Libraries
import os
from collections import defaultdict

# Setting the working directory
os.chdir('directory') 

# Data Science Specific Libraries
import pandas as pd 
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import random

# Machine Learning methods
from sklearn.cluster import SpectralClustering
from sklearn.cluster import KMeans
def ClusteringSpectral(data, 
                       directory_out = "./",
                       csv_name = "Clusteringspectral_Cluster_",
                       n_clusters = 8,
                       eigen_solver=None,
                       n_components=None,
                       random_state=None,
                       n_init=10,
                       gamma=1.0,
                       affinity='rbf',
                       n_neighbors=10,
                       eigen_tol=0.0,
                       assign_labels='kmeans',
                       degree=3,
                       coef0=1,
                       kernel_params=None,
                       n_jobs=None,
                       inverted = False):
    
    clustering = SpectralClustering(n_clusters=n_clusters).fit(data)
    
    
    biclusters = []
    for i in range(max(clustering.labels_) + 1):
        biclusters.append(pd.DataFrame())
        
        
    for i in range(len(clustering.labels_)):
        biclusters[clustering.labels_[i]][data.index[i]] = data.iloc[i].T
    
    
    for i in range(max(clustering.labels_) + 1):
        biclusters[i] = biclusters[i].T
    
    
    for i in range(max(clustering.labels_) + 1):
        if len(biclusters[i].index) > 2 and len(biclusters[i].columns) > 2: 
            if inverted:
                biclusters[i].T.to_csv(directory_out + csv_name + str(i+1) + ".csv")
            else:
                biclusters[i].to_csv(directory_out + csv_name + str(i+1) + ".csv")


####################


directory = "dataDirectory"

data1 = pd.read_csv(directory, index_col=0)

SpectralClustering(data1)
