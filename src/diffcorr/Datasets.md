# Downstream Analysis
The downstream analysis was performed on three datasets: leaf and flower samples from the AtGenExpress development (Accession: GSE5630 and GSE5632, respectively), the Golub dataset and the Arabidopsis dataset.

## 1. AtGenExpress Leaf and Flower Samples
The dataset was downloaded using the GEOquery package. It includes microarray-based experiments measuring mRNA, genomic DNA, and protein abundance, as well as nonarray techniques such as NGS data, serial analysis of gene expression (SAGE), and mass spectrometry proteomic data.

The following steps were performed fro the analysis via R code
1. Preprocessing <a href="#preprocessing"> (See above for the steps in detail)
2. Correlation using Spearman Rank
3. Constructed co-expression network using the igraph package
4. Graph Clustering

A total of 34 modules in the co-expression networks with GSE5632 (flower samples) and 28 modules in the co-expression networks with GSE5630 (leaf samples) were detected. We focus on subnetworks in the top three clusters of the graph clustering results. To assess cluster fidelity, Gene Ontology (GO) term en- richment analyses were performed.

<b>Enrichment Analysis </b>
Used the GOstats package to perform GO term enrichment analysis of the detected co-expression modules and to evaluate whether a particular molecular group is significantly over- or underrepresented

Assessed the predominant function in the biological process within the three modules

Module 1 using flower samples (GSE5632) was involved in “nucleosome assembly” within the “Biological Process” domain. Modules 2 and 3 were related to “cell proliferation” and “RNA methylation,” respectively

<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/GO.png" width="500" >
<figcaption><i><b>Figure: </b>HTML report of Gene Ontology (GO) enrichment analysis. Results of network Module 1 by GO enrichment analysis (filename: res_mod1.html). GO biological process on- tology terms are listed in order of predominance in the cluster module.</i></figcaption>

### Golub Dataset
This dataset consist of gene expression profiles from 38 tumor samples including 2 different leukemia subtypes: 27 acute lymphoblastic leukemia (ALL) and 11 acute myeloid leukemia (AML) samples (Golub et al., 1999). 
The Affymetrix GeneChip HuGeneFL (known as HU6800) microarray contains 6800 probe-sets. 

#### Methadology
First all the probe-sets with negative values in any samples were filtered out, which resulted in 2568 genes. The expression patterns in each subtypes (ALL or AML) was then used to group the genes using the cluster.molecule function. The distance mesaure (1 − correlation coefficient) was set as a cutoff value of based on the cutree function. It was set to 0.6 by the authors.  get.eigen.molecule and get.eigen.molecule.graph functions helped in visualising the network.

<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/Modules_golub.png" width="500" >
<figcaption><i><b>Figure 1 </b>Module networks including ALL and AML samples from the Golub dataset.</i></figcaption>

Finally authors used the comp.2.cc.fdr function whcih provides the resulting pairwise differential correlations from the golub dataset. 

<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/DiffCorr_Golub_Table.png" width="500" >
<figcaption><i><b>Figure 2 </b>Result of pair-wise differential correlations from DiffCorr.</i></figcaption>

#### Results
<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/DiffCorr_Golub_Results.png" width="900" >
Table 1 shows the top 10 significantly differential coexpressions of all AML-specific correlations. 
For example, a correlation between D43949_at (KIAA0082) and HG4185-HT4455_at (Estrogen Sulfotransferase, Ste) was − 0.09 in ALL, and 0.98 in AML. 
The list includes genes encoding the ribosomal proteins L5, L29, L30, L37, and L37a. 
The list also contains eukaryotic translation elongation factor 1 alpha 1 (eEF1A1), which is associated with translation elongation factor activity and has oncogenic potency. 
The DiffCorr package also detetcted “switching mechanism” which are oppositely correlated pairs where, for example, 2 molecules exhibit positive correlation in one condition and negative correlation in the other condition.

### Arabidopsis
This dataset was taken to study the flavonoid-deficient Arabidopsis thaliana (the model plant) and the wild-type by using gas chromatography coupled with mass spectrometry (GC–MS)-based metabolite profiling. This mutant lacks gene encoding chalcone synthase (CHS) and cannot synthesize any flavonoids, which are plant secondary metabolites that function as protectants against ultraviolet B (UV-B) irradiation. 
This dataset consists of the metabolite profiles of 37 samples, including 2 genotypes: 17 Columbia-0 wild-type and 20 transparent testa 4 (tt4, flavonoid defi- cient mutant) plants. The data also contain a wide-range of primary metabolites including amino acids, organic acids, fatty acids, sugars and sugar alcohols. 

The DiffCorr package detected significant differential correlations between sinapate and aromatic metabolites in tt4 and wild-type plants. Aromatic metabolites in the shikimate pathway, namely sinapate, phenylalanine (Phe), and tyrosine (Tyr), were significantly correlated in tt4, but not in wild-type plants. This implies a linkage with the role of sinapoyl-malate against UV-B irradiation in the flavonoid-less tt4 mutant. 

We next showed that Arabidopsis attempts to compensate for deficiency in either flavonoid or sinapoyl-malate production by over-accumulating the alternative protectants (Kusano et al., 2011). These results suggest that DiffCorr can be applied to not only transcriptomic data, but to other post-genomics data type, including metabolomic data.
