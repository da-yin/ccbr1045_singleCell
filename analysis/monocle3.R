library(dplyr)
library(Seurat)
library(monocle)

microgliaReshape = readRDS("microgliaReshape.rds")

data = as(as.matrix(microgliaReshape@assays$RNA@counts), 'sparseMatrix')
pd <- new('AnnotatedDataFrame', data = microgliaReshape@meta.data)

fData <- data.frame(gene_short_name = row.names(data), row.names = row.names(data))
fd <- new('AnnotatedDataFrame', data = fData)
my_cds <- newCellDataSet(data,
                         phenoData = pd,
                         featureData = fd,
                         lowerDetectionLimit = 0.5,
                         expressionFamily = negbinomial.size())

my_cds <- estimateSizeFactors(my_cds)
my_cds <- estimateDispersions(my_cds)
my_cds <- detectGenes(my_cds, min_expr = 0.1)
head(fData(my_cds))
head(pData(my_cds))

pData(my_cds)$UMI <- Matrix::colSums(exprs(my_cds))
disp_table <- dispersionTable(my_cds)
head(disp_table)


table(disp_table$mean_expression>=0.1)
unsup_clustering_genes <- subset(disp_table, mean_expression >= 0.1)
my_cds <- setOrderingFilter(my_cds, unsup_clustering_genes$gene_id)
plot_ordering_genes(my_cds)


expressed_genes <- row.names(subset(fData(my_cds), num_cells_expressed >= 10))
my_cds_subset <- my_cds[expressed_genes, ]
my_cds_subset
head(pData(my_cds_subset))


my_cds_subset <- detectGenes(my_cds_subset, min_expr = 0.1)
fData(my_cds_subset)$use_for_ordering <- fData(my_cds_subset)$num_cells_expressed > 0.05 * ncol(my_cds_subset)
table(fData(my_cds_subset)$use_for_ordering)


#plot_pc_variance_explained(my_cds_subset, return_all = FALSE) # takes long time

my_cds_subset <- reduceDimension(my_cds_subset,max_components = 2,norm_method = 'log',num_dim = 10,reduction_method = 'tSNE',verbose = TRUE)
my_cds_subset <- clusterCells(my_cds_subset, verbose = FALSE)
plot_rho_delta(my_cds_subset, rho_threshold = 2, delta_threshold = 10)
my_cds_subset <- clusterCells(my_cds_subset,rho_threshold = 2,delta_threshold = 10,skip_rho_sigma = T,verbose = FALSE)



table(pData(my_cds_subset)$Cluster)
plot_cell_clusters(my_cds_subset)
head(pData(my_cds_subset))


clustering_DEG_genes <- differentialGeneTest(my_cds_subset,fullModelFormulaStr = '~Cluster',cores = 12)
dim(clustering_DEG_genes)

saveRDS(object = my_cds_subset, file = "my_cds_subset4.rds")

clustering_DEG_genes %>% arrange(qval) %>% head()
my_ordering_genes <- row.names(clustering_DEG_genes)[order(clustering_DEG_genes$qval)][1:1000]
my_cds_subset <- setOrderingFilter(my_cds_subset, ordering_genes = my_ordering_genes)
my_cds_subset <- reduceDimension(my_cds_subset, method = 'DDRTree')
my_cds_subset <- orderCells(my_cds_subset)

saveRDS(object = my_cds_subset, file = "my_cds_subset5.rds")

#pseudotime trajectories calculated
plot_cell_trajectory(my_cds_subset, color_by = "SampleName")
plot_cell_trajectory(my_cds_subset, color_by = "new_clusters")
plot_cell_trajectory(my_cds_subset, color_by = "orig.ident")
head(pData(my_cds_subset))
my_pseudotime_de <- differentialGeneTest(my_cds_subset,fullModelFormulaStr = "~sm.ns(Pseudotime)",cores = 12)
my_pseudotime_de %>% arrange(qval) %>% head()
my_pseudotime_de %>% arrange(qval) %>% head() %>% select(gene_short_name) -> my_pseudotime_gene
plot_cell_trajectory(my_cds_subset, color_by = "Pseudotime")

saveRDS(object = my_cds_subset, file = "my_cds_subset6.rds")