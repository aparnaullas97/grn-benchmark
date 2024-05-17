# Enrichment Analysis
The DiffCorr package offers a list of pairwise differentially correlated molecules. the file also includes r-values, p-vales, and fdr values. By identifying the pair corresponding to the maximum absolute difference of r-values (r1-r2), indicating the most differentially correlated pair, enrichment analysis can be perfomed to obtain further useful information

## gProfiler
gProfiler (Gene List Profiling) is a comprehensive web server and tool suite designed for the functional annotation and enrichment analysis of gene lists. It provides insights into the biological significance of gene sets by mapping them to known biological pathways, ontologies, and other annotation categories. It performs enrichment analysis to identify over-represented biological terms and pathways within a given gene list. The tool also annotates genes with information from a wide range of databases, including Gene Ontology (GO), KEGG, Reactome, WikiPathways, and others.

### Step 1: Sort the differentially correlated pairs of genes in descending order of (r1 - r2) values
<div align="center">
    <img src="https://github.com/aparnaullas97/grn-benchmark/blob/main/src/diffcorr/ImageResouces/SortedList.png" width="700" >
</div>
