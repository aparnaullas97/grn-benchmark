# Installing the DiffCorr Package
options(repos = c(CRAN = "https://cloud.r-project.org"))
install.packages("BiocManager")
BiocManager::install("http://bioconductor.org/biocLite.R")
BiocManager::install(c("pcaMethods", "multtest"), force = TRUE)
BiocManager::install("GEOquery", force = TRUE)
BiocManager::install("affy", force = TRUE)
BiocManager::install("genefilter", force = TRUE)
BiocManager::install("GOstats", force = TRUE)
BiocManager::install("ath1121501.db", force = TRUE)
install.packages("spatstat", force = TRUE)
install.packages("igraph", force = TRUE)
library(cluster)
library(DiffCorr)
library("GEOquery")
library(affy)
library(genefilter)

## Constructing Co-Expression (Correlation) Networks from Omics Data – Transcriptome Data set
# Downloading the Transcriptome Data set
data <- getGEOSuppFiles("GSE5632")
untar("GSE5632/GSE5632_RAW.tar", exdir="GSE5632")
data <- getGEOSuppFiles("GSE5630")
untar("GSE5630/GSE5630_RAW.tar", exdir="GSE5630")

# Data Filtering
# Before calculation of the correlation relationships, all CEL files must be normalized to adjust technical variations between the arrays. 
# Here, we use Robust Multichip Average (RMA) normalization via the affy package 
tgt <- list.files("./GSE5630", pattern="*.CEL.gz", full.names=TRUE)
## RMA normalization
eset.GSE5630 <- justRMA(filenames=tgt)
eset.GSE5630
dim(eset.GSE5630)

tgt2 <- list.files("./GSE5632", pattern="*.CEL.gz", full.names=TRUE)
eset.GSE5632 <- justRMA(filenames=tgt2)
eset.GSE5632
dim(eset.GSE5632)


# Utilization of AFFX spike-in control probes to monitor sample throughout Affymetrix GeneChip. 
# We discard all control probes. 
# Data for all probe sets with the prefix “s_at” or “x_at” were also omitted as they may recognize transcripts from different genes, or cross-hybridization.
rmv <- c(grep("AFFX", rownames(eset.GSE5632)), grep("s_at", rownames(eset.GSE5632)),grep("x_at", rownames(eset.GSE5632)))
eset.GSE5632 <- eset.GSE5632[-rmv,]
dim(eset.GSE5632)

eset.GSE5630 <- eset.GSE5632[-rmv,]
dim(eset.GSE5630)


# Calculation of the Correlation and Visualization of Correlation Networks
# For large-scale data matrices, computation of the correlation coefficient is very time-consuming and memory-filling. 
# The following filter steps significantly reduce the number of targets for further statistical analyses via the genefilter package
# We use a filter function for the expression level and the coefficient of variation. 
# The ratio of the standard deviation and the mean of a gene’s expression values across all samples must be higher than a given threshold.
e.mat <- 2 ^ exprs(eset.GSE5632)
ffun <- filterfun(pOverA(0.2, 100), cv(0.5, 10))
filtered <- genefilter(e.mat,ffun)
eset.GSE5632.sub <- log2(e.mat[filtered, ])
dim(eset.GSE5632.sub)

e.mat <- 2 ^ exprs(eset.GSE5630)
ffun <- filterfun(pOverA(0.2, 100), cv(0.5, 10))
filtered <- genefilter(e.mat,ffun)
eset.GSE5630.sub <- log2(e.mat[filtered, ])
dim(eset.GSE5630.sub)

# Identify common probe sets between the two data sets.
comm <- intersect(rownames(eset.GSE5632.sub), rownames(eset.GSE5630.sub))
head(comm)
length(comm)
eset.GSE5632.sub <- eset.GSE5632.sub[comm, ]
eset.GSE5630.sub <- eset.GSE5630.sub[comm, ]
dim(eset.GSE5630.sub)
dim(eset.GSE5632.sub)

## 1.4 Differential Correlation Analysis by DiffCorr Package
# Calculation of Differential Co-Expression between Organs in Arabidopsis
# We calculate differential co-expression between leaf and flower samples in AtGenExpress development
# To test whether two correlated modules in co-expression networks are significantly different, we first calculate the eigen-molecule or “eigengene” in the network as a representative correlation pattern within each module. 
# The eigen-molecule is based on the first principal component (PC) of a data matrix of a module extracted from HCA using the hclust function in R. 
# The get.eigen.molecule function uses the pcaMethods package to perform principal component analysis (PCA) and returns the top 10 PCs (default). Using these eigen-molecule modules, we can also test differential correlations between modules in addition to pairwise differential correlations between molecules 

# Clusters on each subset

data <- cbind(eset.GSE5632.sub, eset.GSE5630.sub)
hc.flowers <- cluster.molecule(data[, 1:66],method="pearson", linkage="average")  
hc.leaves <- cluster.molecule(data[, 67:126],method="pearson", linkage="average")
g1 <- cutree(hc.flowers, h=0.4) 
g2 <- cutree(hc.leaves, h=0.4)
res1 <- get.eigen.molecule(data, groups=g1, whichgroups=c(1:10), methods="svd", n=2)
res2 <- get.eigen.molecule(data, groups=g2, whichgroups=c(11:20), methods="svd", n=2)

gg1 <- get.eigen.molecule.graph(res1)
gg2 <- get.eigen.molecule.graph(res2)
plotDiffCorrGroup(data, g1, g2, 21, 24, 1:27, 28:38,scale.center=TRUE, scale.scale=TRUE,ylim=c(-5,5))
comp.2.cc.fdr(output.file="Transcript_DiffCorr_res.txt",data[,1:66], data[,67:126], threshold=0.05)
