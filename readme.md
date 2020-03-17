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

Processed data source: 

- SOD1_Microglia_DEGs.csv: SODG93A endstage versus nontransgenic day 130 for ALS (Chiu et al., 2013)
- tableS3_Holtman2015_microglia_aging.csv: Holtman, I. R. et al. Induction of a common microglia gene expression
signature by aging ..... Acta Neuropathol. Commun. 3, 31 (2015).
- suppData3_KerenShaul2017_DAM.csv Keren-Shaul Cell (2017)




The four conditions are as follows:
WT: No disease
Arf_KO: disease
Ifng_KO: No disease
Arf_KO/Ifng_KO: No disease

