#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd 
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import mlxtend 
import random
import scipy

# Quality measures
from sklearn.metrics import mean_squared_error

# Other
import math
import os
from sklearn.preprocessing import normalize
from numpy.random import randn
from  sklearn.preprocessing import normalize


def ComputeNumberColumns(x):
    return len(x[0])  

def ComputeNumberRows(x):
    return len(x)

def ComputeArea(x):
    #Step 0: get the dimensions of the dataset
    I = len(x)
    J = len(x[0])   
    return I*J


def ComputeSMSR(x):
    #Step 0: get the dimensions of the dataset
    I = len(x)
    J = len(x[0])   
    #Step 1: get the global mean
    BIJ = np.mean(x)
    #Iterate over rows and columns
    Smsr = 0
    BiJ = x.mean(1)
    BIj = x.mean(0)
    for i in range(I):
        for j in range(J):
            temp = BiJ[i] * BIj[j] - x[i,j] * BIJ 
            temp = temp / (BiJ[i]*BIj[j])
            temp = temp ** 2  
            Smsr += temp
    return Smsr/(I*J)

def ComputeMSR(x):
    #Step 0: get the dimensions of the dataset
    I = len(x)
    J = len(x[0])   
    #Step 1: get the global mean
    BIJ = np.mean(x)
    #Iterate over rows and columns
    Msr = 0
    BiJ = x.mean(1)
    BIj = x.mean(0)
    for i in range(I):
        for j in range(J):
            Msr += (x[i,j]-BiJ[i]-BIj[j]+BIJ)**2
    return Msr/(I*J)

def ComputeVariance(x):
    #Step 0: get the dimensions of the dataset
    I = len(x)
    J = len(x[0])    
    #Step 1: get the global mean
    BIJ = np.mean(x)
    #Step 2: Compute the sum
    Var = 0
    for i in range(I):
        for j in range(J):
            Var = Var + (x[i,j] - BIJ) ** 2
    return Var/(I*J)
    
    
def ComputeVirtualError(x):
    #Step 0: get the dimensions of the dataset
    I = len(x)
    J = len(x[0])
    #Step 1: make the bicluster Standard.
    bhat = RowStandardization(x)
    #Step 2: get the pattern
    ro = np.mean(x, axis = 0)
    #Step 3: get the error
    VE = 0
    for i in range(I):
        for j in range(J):
            VE = VE + abs(x[i,j] - ro[j])
    return VE/(I*J)
    
def RowStandardization(x):
    #Step 0: get the dimensions of the dataset
    I = len(x)
    J = len(x[0])
    #get mean and sigma
    mu = np.mean(x, axis = 1)
    sigma = np.std(x, axis = 1)
    bic = x
    for i in range(I):
        for j in range(J):
            bic[i,j]  = (bic[i,j] - mu[i]) / sigma[i]
    return bic

# This functions loads a single Bicluster from a given file
# directory: file directory
# name: file name
def ImportSingleBicluster(directory, filename):
    return pd.read_csv(directory + filename, index_col=0)
