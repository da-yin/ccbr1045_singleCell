Single cell RNA-seq data analysis
=======================

An analysis of four samples of microglial cells from mouse brain.


Folder structure
-----------

```
.
├── rawData                  # merged seurat object from /data/CCBR/projects/ccbr1045/scrna_guohao2/SingleR_testing
│                            #  
├── analysis                 # analysis folder that contains script and results
│   ├── processedData        # MicrogliaReshape.rds and DEG from published neurodegenerative disease DE analysis
│   ├── results              # Intermediate result files
|       ├── UMAPs            # umap of all cells/microglia 
|       ├── networkss        # plots from Cluserprofiler cnetplot and emaplot pathways and their connected genes.
|       ├── heatmap          # normalzed/average expression for up and down-regulated genes
|       ├── FeaturePlots     # expression of genes projected onto umap
|       ├── microgliaMarker  # markers for each microglia subcluster
|       ├── microgliaCluster # Differential expression between samples for each cluster
|       ├── microglia_Arf1_vs# Differential expression between samples for all microglia
|       ├── microgliaCluster5# Analysis for cluster5
│   ├── *.Rmd                # R scripts 
│   ├── *.html               # Rmarkdown html knit file (run Rmd to get html)
├── reports                  # ppt
├── ref                      # methods and references
├── readme.md                # analysis summary                       
└── ...
```


Workflow for this project:
-----------

![workflow chart](https://github.com/da-yin/ccbr1045_singleCell/blob/master/analysis/results/ccbr1045_workflow.jpg)




Key findings:
-----------

- Arf1 KO shows similar microglia gene dysregulation signature to AD, ALS, MS. 
- A microglia subtype  - microglia Cluster 5 is identified and is strongly associated with Arf1-deficicent neurodegeneration. Cluster 5 markers include some of the previously known neurodegenerative risk factors Apoe, Cd63, Cxcl2, Cd52, Ctsb, H2-D1, Fth1, and Spp1
- Cluster 5 is also characterized by down-regulation of several microglia homeostatic genes, including P2ry12, P2ry13, Tmem119, Selplg, Cx3cr1, Hexb, and Siglech
- Cluster1 has the opposite expression in “disease markers” and ”homeostatic markers” compared to Cluster 5. Cluster 2 and Cluster 4 has ”in-between” expression for these genes, and may represent transitional state from homeostatic to pro-inflammatory state. 
- The pathogenic phenotype of Arf1 knock-out is associated with a shift in the distribution of number of cells from Cluster 1 to Cluster 5. Arf1-KO microglia cells are depleted in Cluster1 and enriched in Cluster 5 compared to three other samples. Percentage of cells in Cluster 5 for WT (5%), for Arf1_KO(15%).



Processed data source: 

- SOD1_Microglia_DEGs.csv: SODG93A endstage versus nontransgenic day 130 for ALS (Chiu et al., 2013)
- tableS3_Holtman2015_microglia_aging.csv: Holtman, I. R. et al. Induction of a common microglia gene expression
signature by aging ..... Acta Neuropathol. Commun. 3, 31 (2015).
- suppData3_KerenShaul2017_DAM.csv Keren-Shaul Cell (2017)






