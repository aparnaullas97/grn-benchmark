# Methadology and Rationale
## 1. Golub Dataset
This dataset consist of gene expression profiles from 38 tumor samples including 2 different leukemia subtypes: 27 acute lymphoblastic leukemia (ALL) and 11 acute myeloid leukemia (AML) samples (Golub et al., 1999). 
The Affymetrix GeneChip HuGeneFL (known as HU6800) microarray contains 6800 probe-sets. 

#### Methadology
1. All the probe-sets with negative values in any samples were filtered out resulting in 2568 genes.
2. The expression patterns in each subtypes (ALL or AML) was then used to group the genes using the cluster.molecule function.
3. The distance mesaure (1 − correlation coefficient) was set as a cutoff value of based on the cutree function. It was set to 0.6 by the authors.
4. get.eigen.molecule and get.eigen.molecule.graph functions helped in visualising the network.
5. Finally, comp.2.cc.fdr function was used which provided the resulting pairwise differential correlations from the golub dataset. 

<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/DiffCorr_Golub_Table.png" width="500" >
<figcaption><i><b>Figure: </b>Result of pair-wise differential correlations from DiffCorr.</i></figcaption>

#### Results
<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/DiffCorr_Golub_Results.png" width="900" >
Table shows the top 10 significantly differential coexpressions of all AML-specific correlations. 
For example, a correlation between D43949_at (KIAA0082) and HG4185-HT4455_at (Estrogen Sulfotransferase, Ste) was − 0.09 in ALL, and 0.98 in AML. 
The list includes genes encoding the ribosomal proteins L5, L29, L30, L37, and L37a. 
The list also contains eukaryotic translation elongation factor 1 alpha 1 (eEF1A1), which is associated with translation elongation factor activity and has oncogenic potency. 
The DiffCorr package also detetcted “switching mechanism” which are oppositely correlated pairs where, for example, 2 molecules exhibit positive correlation in one condition and negative correlation in the other condition.

## 2. AtGenExpress Leaf and Flower Samples
The dataset was downloaded using the GEOquery package. It includes microarray-based experiments measuring mRNA, genomic DNA, and protein abundance, as well as nonarray techniques such as NGS data, serial analysis of gene expression (SAGE), and mass spectrometry proteomic data.

#### Methadology
1. Preprocessing (See [README.md](https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/README.md) for the steps in detail)
2. Correlation using Spearman Rank
3. Constructed co-expression network using the igraph package
4. Graph Clustering
   
A total of 34 modules in the co-expression networks with GSE5632 (flower samples) and 28 modules in the co-expression networks with GSE5630 (leaf samples) were detected. To assess cluster fidelity, Gene Ontology (GO) term enrichment analyses were performed.

### Results
Used the GOstats package to perform GO term enrichment analysis of the detected co-expression modules and to evaluate whether a particular molecular group is significantly over- or underrepresented. Assessed the predominant function in the biological process within the three modules

Module 1 using flower samples (GSE5632) was involved in “nucleosome assembly” within the “Biological Process” domain. Modules 2 and 3 were related to “cell proliferation” and “RNA methylation,” respectively

<img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/GO.png" width="500" >
<figcaption><i><b>Figure: </b>HTML report of Gene Ontology (GO) enrichment analysis. Results of network Module 1 by GO enrichment analysis (filename: res_mod1.html). GO biological process on- tology terms are listed in order of predominance in the cluster module.</i></figcaption>

## 3. Macrophages and T-Cells
Diffcorr was performed on the Macrophages and CD_8 T cells, both of which are types of immune cells with different roles in the immune system. Macrophages are white blood cells that remove unwanted materials. They engulf and break down debris, germs, and abnormal cells. Macrophages play a vital role by detecting threats and repairing tissue damage. CD8 T cells are another type of white blood cell. They identify and eliminate virus-infected or cancerous cells. CD8 T cells release substances that destroy these harmful cells. Both cell types contribute to the immune system’s defense. The datasets contains gene expression profiles of 100 samples including 2 cell types: Macrophages and CD_8 T-cells
