## This page will explain in detail about the datasets used to implement the package
### Golub Dataset
This dataset consist of gene expression profiles from 38 tumor samples including 2 different leukemia subtypes: 27 acute lymphoblastic leukemia (ALL) and 11 acute myeloid leukemia (AML) samples (Golub et al., 1999). 
The Affymetrix GeneChip HuGeneFL (known as HU6800) microarray contains 6800 probe-sets. 

#### Methadology
First all the probe-sets with negative values in any samples were filtered out, which resulted in 2568 genes. The expression patterns in each subtypes (ALL or AML) was then used to group the genes using the cluster.molecule function. The distance mesaure (1 − correlation coefficient) was set as a cutoff value of based on the cutree function. It was set to 0.6 by the authors.  get.eigen.molecule and get.eigen.molecule.graph functions helped in visualising the network. See Fig. 1
Finally authors used the comp.2.cc.fdr function whcih provides the resulting pair-wise differential correlations from a dataset. See Fig. 2 

#### Results
Table 1 shows the top 10 significantly differential coexpressions (FDR < 0.05), which were all AML-specific correlations. 
For example, a correlation between D43949_at (KIAA0082) and HG4185-HT4455_at (Estrogen Sulfotransferase, Ste) was − 0.09 in ALL, and 0.98 in AML. 
As can be seen, the list includes genes encoding the ribosomal proteins L5, L29, L30, L37, and L37a. 
The list also contained eukaryotic translation elongation factor 1 alpha 1 (eEF1A1), which is associated with translation elongation factor activity and has oncogenic potency. 
The DiffCorr package also detects oppositely correlated pairs where, for example, 2 molecules exhibit positive correlation in one condition and negative correlation in the other condition, a condition referred to as a “switching mechanism” (Kayano et al., 2011). 
Table 3 shows the list of switching mechanisms of gene expression between ALL and AML samples. Several oncogenes are present, including the IQ motif containing GTPase activating protein 1 (IQGAP1), which is often over-expressed in cancer (see review White et al., 2009).

### Arabidopsis


### 
