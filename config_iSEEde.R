# app <- iSEE(se_airway, initial = list(
#   iSEEde::DETable(ContrastName="Limma-Voom", HiddenColumns = c("baseMean",
#                                                                "lfcSE", "stat"), PanelWidth = 4L),
#   iSEEde::VolcanoPlot(ContrastName="Limma-Voom", PanelWidth = 4L),
#   iSEEde::MAPlot(ContrastName="Limma-Voom", PanelWidth = 4L)
# ))

initial <- list(
  iSEEde::DETable(ContrastName="Limma-Voom", HiddenColumns = c("baseMean",
                                                               "lfcSE", "stat"), PanelWidth = 4L),
  iSEEde::VolcanoPlot(ContrastName="Limma-Voom", PanelWidth = 4L),
  iSEEde::MAPlot(ContrastName="Limma-Voom", PanelWidth = 4L)
)
