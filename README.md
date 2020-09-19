# Biclustering fMRI time series: a comparative study

![Image of Yaktocat](https://raw.githubusercontent.com/ECastanho/Biclustering-fMRI-Time-Series-A-comparative-Study/master/IllustrativeBics.png)

This repository aims to provide support to the associated paper. It acts as an repository to archive:

- The scripts that generate the synthetic datasets
- The datasets used in the paper
- Scripts to generate the biclusters
- Functions to read and analyse results
- Some generated biclusters to act as example 

## Repository structure

- **SimTB Generators**: Related with the process of generating synthetic datasets
- **Data Collections**: Data used for the analysis
- **Biclustering Generators**: Scripts for generating biclusters from the data
- **Biclustering Analysis**: Functions to compute the analysis metrics


## Data collections

The paper have three data colections.

- **First  data collection**: A single synthetic subject
- **Second data collection**: Twenty synthetic subjects
- **Third  data collection**: Twenty real subjects

## Algorithms
### Biclustering algorithms
- ISA
- XMotifs
- FABIA
- Spectral
- Bimax
- CCC
- BicPAM

### Clustering algorithms
- K-Means
- Spectral
- Ward's 

## Workflow

![Image of Yaktocat](https://raw.githubusercontent.com/ECastanho/Biclustering-fMRI-Time-Series-A-comparative-Study/master/Workflow.png)


## Software requirements
During the development of this paper some software was needed depending on the part of the analysis:

- MATLAB will be needed to run the [SimTB fMRI data simulator](https://trendscenter.org/software/simtb/), to generate the synthetic datasets.
- R will be needed for running most of the biclustering algorithms (FABIA, ISA, Bimax, XMotifs, Spectral).
  - For FABIA, you need the [fabia Package](https://bioconductor.org/packages/release/bioc/html/fabia.html).
  - For ISA, you need the [isa2 Package](https://cran.r-project.org/web/packages/isa2/index.html).
  - For the remaining algorithms, you need the [biclust Package](https://cran.r-project.org/web/packages/biclust/index.html).
- Python will be used for running the clustering algorithms (Spectral, K-means, Ward's hierarchical method) and analysing the biclustering solutions.
  - For the clustering algorithms, we used the implementations provided by [scikit-learn](https://scikit-learn.org/stable/).
  - Other traditional python libraries are used during the scripts.
- BicPAM is implemented in the [BicPAMS tool](https://web.ist.utl.pt/rmch/bicpams/).
  - Both an Desktop GUI and a Java API are provided.
- CCC is implemented as part of the [BiGGEsTS software](http://homepage.tudelft.nl/c7g5f/software/biggests2/) (GUI implementation).
  
  
  
