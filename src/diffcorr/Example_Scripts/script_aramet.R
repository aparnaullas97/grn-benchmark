library(DiffCorr)

data(AraMetLeaves)
dim(AraMetLeaves)

colnames(AraMetLeaves)
comp.2.cc.fdr(output.file = "Met_DiffCorr_res.txt",
              log10(AraMetLeaves[, 1:17]), ## Col-0 (17 samples)
              log10(AraMetLeaves[, 18:37]), ## tt4 (20 samples)
              method = "pearson",
              threshold = 1.0)

