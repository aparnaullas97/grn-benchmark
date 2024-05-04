# Load required libraries
options(repos = c(CRAN = "https://cloud.r-project.org"))
install.packages("BiocManager")
library(affy)
library(genefilter)
library(igraph)
library(spatstat)
library(cluster)
library(DiffCorr)

# Load the multtest package to access the Golub dataset
library(multtest)
# Load the Golub gene expression dataset
data(golub)

# Subset for ALL (tumor class code 0)
all_samples <- golub[, golub.cl == 0]  
# Subset for AML (tumor class code 1)
aml_samples <- golub[, golub.cl == 1]  

all_aml_data <- cbind(all_samples, aml_samples)

# Hierarchical clustering for ALL and AML
hc.all <- cluster.molecule(all_aml_data[, 1:27], method = "pearson", linkage = "average")  
hc.aml <- cluster.molecule(all_aml_data[, 28:38], method = "pearson", linkage = "average")  

allg <- cutree(hc.all, h = 0.7) 
amlg <- cutree(hc.aml, h = 0.7)

# Display cluster counts
print("ALL Cluster Counts:")
print(table(allg))
print("AML Cluster Counts:")
print(table(amlg))

# Example assuming 'data' is a data matrix and 'allg' is a grouping variable
res1all <- get.eigen.molecule(all_aml_data, groups = allg, whichgroups = c(1:10), methods = "svd", n = 2)
res2aml <- get.eigen.molecule(all_aml_data, groups = amlg, whichgroups = c(11:20), methods = "svd", n = 2)

gg1all <- get.eigen.molecule.graph(res1all)
gg2aml <- get.eigen.molecule.graph(res2aml)

# Plot the graphs
plot(gg1all, layout = layout.fruchterman.reingold(gg1all), main = "ALL")
plot(gg2aml, layout = layout.fruchterman.reingold(gg2aml), main = "AML")

# Write module lists to files
write.modules(allg, res1all, outfile = "module1_listall.txt")
write.modules(amlg, res2aml, outfile = "module1_listaml.txt")

# Plotting DiffCorr groups 21 and 24
plotDiffCorrGroup(all_aml_data, allg, amlg, 21, 24, 1:27, 28:38,
                  scale.center = TRUE, scale.scale = TRUE,
                  ylim = c(-5, 5))

# Run Comp. 2.cc.fdr and save the output
comp.2.cc.fdr(output.file = "Result.txt", all_aml_data[,1:27], all_aml_data[,28:38], threshold = 0.05)

