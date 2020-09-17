# Generating fMRI synthetic datasets using SimTB 

This folder hosts three MATLAB files associated with the generation of the synthetic datasets:

- **Original.m**: Is the original file provided by SimTB. This was the original file.
- **Synthetic1.m**: This file generates a single synthetic subject
- **Synthetic1.m**: This file generates twenty synthetic subjects

To use them verify the information provided by [SimTB Generator](https://trendscenter.org/software/simtb/), in particular the [User Manual](https://trendscenter.org/trends/software/simtb/docs/2011_simtb_manual_v18.pdf) and the paper associated:

- Erhardt EB, Allen EA, Wei Y, Eichele T, Calhoun VD. SimTB, a simulation toolbox for fMRI data under a model of spatiotemporal separability. Neuroimage. 2012;59(4):4160-4167. doi:10.1016/j.neuroimage.2011.11.088

After running the simulator the data must be preprocessed twice for each subject.

- **converter1.m**: Matlab script that creates a csv based on the simulated data
- **converter2.py**: Python script that changes the previous generated data. It changes the data into a format easier to be read later and adds some white noise
