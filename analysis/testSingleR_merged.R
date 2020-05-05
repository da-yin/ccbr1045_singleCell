library (Seurat)
library(SingleR)
library(SingleCellExperiment)
library(scater)

tabulaMuris = readRDS("tabulaMuris_brain.rds")
sample = readRDS("../integration/merged/y-x/y-x.rds_1.2.rds")

sce = as.SingleCellExperiment(sample)
sce_tm = as.SingleCellExperiment(tabulaMuris)

sce_tm = logNormCounts(sce_tm)
merged_s = SingleR(test=sce, ref=sce_tm,labels=sce_tm$cell_ontology_class,de.method="wilcox")

save.image("tabulaMurisTest_merged.Rdata")
