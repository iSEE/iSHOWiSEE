library(iSEE)
library(iSEEde)

# library(iSEEu)
library(iSEEfier)
library(iSEEtree)
library(TreeSummarizedExperiment)
library(fgsea)

# library(iSEEde)
# library(iSEEpathways)

library(iSEEindex)
library(iSEEid)



library("BiocFileCache")
bfc <- BiocFileCache(cache = tempdir())

dataset_fun <- function() {
  x <- yaml::read_yaml("config_iSHOWiSEE.yml")
  x$datasets
}

initial_fun <- function() {
  x <- yaml::read_yaml("config_iSHOWiSEE.yml")
  x$initial
}

library(iSEEde)
library(iSEEpathways)
library(iSEEid)
library(AnnotationDbi)
library(org.Hs.eg.db)
library(GO.db)

app <- iSEEindex(bfc, dataset_fun, initial_fun)
app
