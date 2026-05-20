# create the SCE object for all/most app cases ----------------

# PMBC3K -------------------------------------------------------------------

##...
# pbmc3k, pre-annotated, from iUSEiSEE
sce_pbmc3k <- readRDS("sce_pbmc3k.RDS")


# Allen -------------------------------------------------------------------

# allen, with some extra, as from the examples
library(scRNAseq)

sce_allen <- ReprocessedAllenData(assays = "tophat_counts")
class(sce_allen)

library(scater)
library(scrapper)
sce_allen <- normalizeRnaCounts.se(sce_allen, assay.type = "tophat_counts", size.factors = NULL)

sce_allen <- runPCA(sce_allen, ncomponents=4)
sce_allen <- runTSNE(sce_allen)
rowData(sce_allen)$ave_count <- rowMeans(assay(sce_allen, "tophat_counts"))
rowData(sce_allen)$n_cells <- rowSums(assay(sce_allen, "tophat_counts") > 0)

saveRDS(sce_allen, file = "sce_allen.RDS")

# Microbiome data ----------------------------------------

library(iSEEtree)
library(mia)
library(scater)

# Import TreeSE
data("Tengeler2020", package = "mia")
tse <- Tengeler2020

# Add relabundance assay
tse <- transformAssay(tse, method = "relabundance")

# Add reduced dimensions
tse <- runMDS(tse, assay.type = "relabundance")

tse

saveRDS(tse, "tse_tengeler.RDS")

# DE analysis and co ------------------------------------------

library("iSEEde")
library("iSEEpathways")
library("airway")
library("DESeq2")
library("iSEE")

data("airway")
airway$dex <- relevel(airway$dex, "untrt")

library("org.Hs.eg.db")
library("scater")
rowData(airway)[["ENSEMBL"]] <- rownames(airway)
rowData(airway)[["SYMBOL"]] <- mapIds(org.Hs.eg.db, rownames(airway), "SYMBOL", "ENSEMBL")
rowData(airway)[["uniquifyFeatureNames"]] <- uniquifyFeatureNames(
  ID = rowData(airway)[["ENSEMBL"]],
  names = rowData(airway)[["SYMBOL"]]
)
rownames(airway) <- rowData(airway)[["uniquifyFeatureNames"]]

airway <- scrapper::normalizeRnaCounts.se(airway)

library("edgeR")

counts <- assay(airway, "counts")
design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

keep <- filterByExpr(counts, design)
v <- voom(counts[keep,], design, plot=FALSE)
fit <- lmFit(v, design)
contr <- makeContrasts("dextrt - dexuntrt", levels = colnames(coef(fit)))
tmp <- contrasts.fit(fit, contr)
tmp <- eBayes(tmp)
res_limma <- topTable(tmp, sort.by = "P", n = Inf)
head(res_limma)

airway <- iSEEde::embedContrastResults(res_limma, airway, name = "Limma-Voom", class = "limma")
rowData(airway)

library("org.Hs.eg.db")
pathways <- select(org.Hs.eg.db, keys(org.Hs.eg.db, "ENSEMBL"), c("GOALL"), keytype = "ENSEMBL")
#> 'select()' returned 1:many mapping between keys and columns
pathways <- subset(pathways, ONTOLOGYALL == "BP")
pathways <- unique(pathways[, c("ENSEMBL", "GOALL")])
pathways <- merge(pathways, rowData(airway)[, c("ENSEMBL", "uniquifyFeatureNames")])
pathways <- split(pathways$uniquifyFeatureNames, pathways$GOALL)

map_GO <- function(pathway_id, se) {
  pathway_ensembl <- mapIds(org.Hs.eg.db, pathway_id, "ENSEMBL", keytype = "GOALL", multiVals = "CharacterList")[[pathway_id]]
  pathway_rownames <- rownames(se)[rowData(se)[["gene_id"]] %in% pathway_ensembl]
  pathway_rownames
}
airway <- registerAppOptions(airway, Pathways.map.functions = list(GO = map_GO))

library("fgsea")
set.seed(42)

stats <- na.omit(
  log2FoldChange(contrastResults(airway, "Limma-Voom")) *
    -log10(pValue(contrastResults(airway, "Limma-Voom")))
)
set.seed(42)
fgseaRes <- fgsea(pathways = pathways,
                  stats    = na.omit(stats),
                  minSize  = 15,
                  maxSize  = 500)
fgseaRes <- fgseaRes[order(pval), ]
airway <- embedPathwaysResults(
  fgseaRes, airway, name = "fgsea (p-value & fold-change)", class = "fgsea",
  pathwayType = "GO", pathwaysList = pathways, featuresStats = stats)
airway

library("GO.db")
library("shiny")
library("iSEE")

go_details <- function(x) {
  info <- select(GO.db, x, c("TERM", "ONTOLOGY", "DEFINITION"), "GOID")
  html <- list(p(strong(info$GOID), ":", info$TERM, paste0("(", info$ONTOLOGY, ")")))
  if (!is.na(info$DEFINITION)) {
    html <- append(html, list(p(info$DEFINITION)))
  }
  tagList(html)
}

airway <- registerAppOptions(airway, PathwaysTable.select.details = go_details)


se_airway <- airway
saveRDS(se_airway, "se_airway.RDS")










