% This script must be changed ir order to work, considering the file locations
% Additionally, it was created considering a single subject.  

% This part loads the simulation files for one subject.  
load('../Simulation1/aod_subject_001_SIM.mat')
load('../Simulation1/aod_subject_001_DATA.mat')
load('../Simulation1/aod_PARAMS.mat')

% This part creates the data matrix
data = [(0:1:sP.nT)' [sP.SM_source_ID;TC]];

% Saving the data matrix as a csv file
csvwrite('../Datasets/simtbTemp.csv',data)


