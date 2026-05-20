library(iSEE)

# library(iSEEu)
# library(iSEEfier)

# library(iSEEde)
# library(iSEEpathways)

# library(iSEEtree)

library(iSEEindex)

# library(iSEEid)


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
