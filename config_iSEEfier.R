library("iSEE")

sce_pbmc3k <- readRDS("sce_pbmc3k.RDS")
initial <- iSEEfier::iSEEmarker(sce_pbmc3k, clusters = "Cluster", groups = "labels_main")

# iSEE(sce_pbmc3k, initial = initial)
