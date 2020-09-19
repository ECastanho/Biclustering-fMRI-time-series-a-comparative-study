
#This function aims to encapsulate the K-means Clustering algorithm. For a quick start, just read the next two sections

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

# csv_name = "bimax_Bicluster_",
## This parameter defines a prefix for all generated names

# for the remaining parameters, check:
# https://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html


# General Python Libraries
import os
from collections import defaultdict

# Setting the working directory
os.chdir('/Users/eduardocastanho/Documents/GitHub/Triclustering-algorithms-for-Spatio-Temporal-Data-Analysis/LetsApplyBiclustering/') 

# Data Science Specific Libraries
import pandas as pd 
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import random

# Machine Learning methods
from sklearn.cluster import SpectralClustering
from sklearn.cluster import KMeans


def Kmeansspectral(data, 
                       directory_out = "./",
                       csv_name = "Clusteringspectral_Cluster_",
                       n_clusters=8,
                       init='k-means++', 
                       n_init=10,
                       max_iter=300, 
                       tol=0.0001, 
                       precompute_distances='deprecated', 
                       verbose=0, 
                       random_state=None, 
                       copy_x=True, 
                       n_jobs='deprecated', 
                       algorithm='auto'):
    
    clustering = SpectralClustering(n_clusters=n_clusters,
                                    init=init,
                                    n_init=n_init,
                                    max_iter=max_iter,
                                    tol=tol,
                                    precompute_distances=precompute_distances,
                                    verbose=verbose,
                                    random_state=random_state,
                                    copy_x=copy_x,
                                    n_jobs=n_jobs,
                                    algorithm=algorithm
                                    ).fit(data)
    
    
    biclusters = []
    for i in range(max(clustering.labels_) + 1):
        biclusters.append(pd.DataFrame())
        
        
    for i in range(len(clustering.labels_)):
        biclusters[clustering.labels_[i]][data.index[i]] = data.iloc[i].T
    
    
    for i in range(max(clustering.labels_) + 1):
        biclusters[i] = biclusters[i].T
    
    
    for i in range(max(clustering.labels_) + 1):
        if len(biclusters[i].index) > 1 and len(biclusters[i].columns) > 1: 
            biclusters[i].to_csv(directory_out + csv_name + str(i+1) + ".csv")

####################


directory = "dataDirectory"

data1 = pd.read_csv(directory, index_col=0)

Clusteringspectral(data1)
