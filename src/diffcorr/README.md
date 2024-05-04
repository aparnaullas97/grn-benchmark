<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h1 align="center">DiffCorr</h1>

  <p align="center">
  <h3 align="center">An R package to analyse and visualise differential correlations between two biological networks</h3>
    
  </p>
</div>
<br /><br />
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#the-package">The Package</a>
      <ul>
        <li><a href="#Structure">Structure</a></li>
        <li><a href="#Dataset">About the datasets</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation and Execution</a></li>
      </ul>
    </li>
    <li>
      <a href="#Specifications">Specifications</a>
      <ul>
        <li><a href="#input-specs">Input Specifications</a></li>
        <li><a href="#preprocessing">Preprocessing Steps</a></li>
        <li><a href="#output-specs">Output Specifications</a></li>
        <li><a href="#Analysis">Analysing Output</a></li>
      </ul>
    </li>
    <li><a href="#downstream-analysis">Downstream Analysis</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#references">References</a></li>
  </ol>
</details>



<!-- ABOUT THE PACKAGE -->
## The Package

DiffCorr is a package that can be used to analyze and visualize Differential Correlations in Biological Networks.
It can be seen as an initial step toward interpreting causal connections and identification of potential biomarkers
DiffCorr utilizes Fisher’s z-test to identify changes in correlation patterns between two data groups set in different experimental conditions. It's correlation operation is determined through Pearson’s correlation coefficient. 


The tool first calculates correlation matrices for each dataset, detects principal component-derived "eigen-molecules" within the correlation networks, and then performs statostical tests to identify differential correlations between the two groups


### Structure
The following bulletins describe the features, functionalities, and structure of the DiffCorr package
1. **get.eigen.molecule**: This function retrieves conditional modules obtained from hierarchical cluster analysis (HCA) using the cluster.molecule function. We can use **get.eigen.molecule.graph** to visualise the modules using the igraph package
2. **plot.DiffCorr.group**: This functon can be used to get profile patterns of module members for each condition. This call is also based igraph package that uses the plot function. This provides profile patterns of module members for each module.

3. **comp.2.cc.fdr**: This function saves a list of significantly different correlations as a text file. It utilizes the fdrtool package to manage the false discovery rate (FDR). The exported file includes molecule IDs, conditional correlation coefficients, p-values from the correlation test, the difference between the two correlations, corresponding p-values, and the result of Fisher's z-test while controlling FDR.

<div style="text-align:center">
    <img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/DiffCorr.png" width="100" >
</div>

### About the datasets
The following bulletins describe the features, functionalities, and structure of the DiffCorr package
1. **Golub Dataset**: This dataset consist of gene expression profiles from 38 tumor samples including 2 different leukemia subtypes: 27 acute lymphoblastic leukemia (ALL) and 11 acute myeloid leukemia (AML) samples (Golub et al., 1999). 

2. **Arabidopsis**: Kusano et al. studied a type of Arabidopsis thaliana, a common plant used for research, that doesn't have flavonoids, which are compounds found in plants. They compared this plant to the normal type using a method called gas chromatography coupled with mass spectrometry (GC–MS) to analyze the chemicals present. The mutant plant doesn't have a gene called chalcone synthase (CHS), so it can't make any flavonoids. Flavonoids are chemicals in plants that help protect them from ultraviolet B (UV-B) radiation.


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started
Explore the fundamentals of DiffCorr through the following starter resources.
To get a local copy up and running follow these simple example steps.

### Prerequisites
[![R Studio][R.js]][R-url]

Before starting the project, please ensure that R Studio is installed. The implementation was tested using R Studio version 4.3.3 (2024-02-29) -- "Angel Food Cake", so having the same version installed will ensure compatibility and optimal performance.

[![Cytoscape][Cytoscape.js]][Cytoscape-url]

Additionally, it would be beneficial to have Cytoscape installed for interactive visualization of the networks and for performing enrichment analysis.

[![Jupyter][Jupyter.js]][jupyter-url]

For the down stream analysis, it would be beneficial to have Jupyter installed for interactive visualization of the Classification

### Installation and Execution

_Please follow the steps following to make sure of a smooth installation process._

1. Clone the repo
   ```sh
   git clone https://github.com/bionetslab/grn-benchmark.git
   ```
2. Open terminal and Navigate till the executable script
   ```sh
   /grn-benchmark/src/diffcorr/Example_Script/
   ```
3. Run the command to execute the tool for exemplary datasets (No parameters required)
    
    Execute DiffCorr on the Golub dataset which contains ALL and AML conditions
   ```js
   Rscript script_all_aml.R
   ```
    Execute DiffCorr on the datasets from leaf and flower samples from AtGenExpress development
    ```js
   Rscript script_flower_leaf.R
   ```
    Execute DiffCorr to explore the Metabolome Data of Flavonoid-Deficient Arabidopsis
    ```js
   Rscript script_aramet.R
   ```
4. Run the following command to execute the tool for Arbitrary Datasets
    ```js
   Rscript script_arbitrary.R --input.file.1 --input.file.2 --output.path
   ```
    
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Specifications
### Input file format specification:
- `--input.file.1`: Path to a file in tab-separated format containing gene expression data for condition 1. Each row represents a gene, and each column represents a cell. The values in the table are normalized gene expression levels.
- `--input.file.2`: Path to another file in tab-separated format containing gene expression data for condition 2. It follows the same structure as the file for condition 1.
- `--output.path`: Path to the folder where the output will be stored. This folder must already exist before running the program.

### Preprocessing
Make sure to input 2 gene expression data which are preprocessed - normalised, filtered, non NA values

For example, a series of steps had to be taken for the Arabidopsis dataset
1. Robust Multichip Average (RMA) method via the `justRMA` function from the `affy` package normalized the transcriptome data.
2. The probes that do not represent biological transcripts or may have cross-hybridization issues were removed from the dataset.
3. Genes with low expression levels and low variability across samples were filtered out using the `genefilter` package to reduces the number of targets 
4. Common probe sets between the two datasets were identified and retained

### Output file format specification
Tab-separated output file will be stored at `--output.path`

### Interpretation of the Output
The output text file contains the results of differential correlation analysis by the DiffCorr package between pairs of molecules under different conditions or treatments 1 and 2, respectively.
- `Molecule X, Molecule Y`: These columns are pairs of molecules which are correlated
- `r1, r2`: Correlation coefficients for Molecule X and Molecule Y 
- `p1, p2`: p-values for the correlation coefficients 
- `p (difference)`: Indicates the significance of the difference between the correlations of Molecule X and Molecule Y under the two conditions.
- `(r1 - r2)`: Difference in correlation coefficients 
- `lfdr (in cond. 1), lfdr (in cond. 2)`: Local false discovery rate (lfdr)
- `lfdr (difference)`: Shows the significance of the difference between the correlations of Molecule X and Molecule Y under the two conditions.


<!-- ROADMAP -->
## Roadmap

- [x] Authors Implementation on Arabodopolis dataset
- [x] Reproduction of implementation on Golub dataset
- [x] Reproduction of implementation on Reference datasets
- [x] Generation of images/results from the paper
- [ ] Analysis
    - [x] Cytoscape
    - [x] Gene Ontology Enrichment Analysis
    - [ ] Gene Regulatory Network
- [x] Generation of scripts
- [x] Downstream Analysis
    - [x] Classification Implementation
    - [x] Scripting for Arbitrary datasets

See [here](https://github.com/othneildrew/Best-README-Template/issues) for exhaustive notes on the roadmap, datasets, and known issues.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## References

* [DiffCorr Paper](https://www.sciencedirect.com/science/article/pii/S0378111912014497?ref=pdf_download&fr=RR-2&rr=877dd3089d88a040)
* [Implementation Tutorial](https://application.wiley-vch.de/books/sample/3527339582_c01.pdf)
* [Download Package](https://sourceforge.net/projects/diffcorr/)
* [Classification of Gene expression dataset (Golub et al.)](https://www.kaggle.com/code/aasthaadhikari/cancer-prediction)
* [A gene expression map of Arabidopsis thaliana development](https://www.nature.com/articles/ng1543)
* [GitHub Pages](https://github.com/afukushima/afukushima.github.io/tree/master)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[R.js]: https://img.shields.io/badge/R_Studio-75AADB?style=for-the-badge&logo=rstudio&logoColor=white
[R-url]: https://posit.co/downloads/
[Cytoscape.js]: https://img.shields.io/badge/Cytoscape-FF5733?style=for-the-badge
[cytoscape-url]: https://cytoscape.org
[Jupyter.js]: https://img.shields.io/badge/Jupyter_Notebook-8B008B?style=for-the-badge&logo=jupyter&logoColor=white
[jupyter-url]: https://jupyter.org
[DiffCorr.js]: https://img.shields.io/badge/DiffCorr-FFFF00?style=for-the-badge&logoColor=white
[diffcorr-url]: https://www.sciencedirect.com/science/article/pii/S0378111912014497?ref=pdf_download&fr=RR-2&rr=877dd3089d88a040

