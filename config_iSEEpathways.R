# app <- iSEE(se_airway, initial = list(
#   PathwaysTable(ResultName="fgsea (p-value)", Selected = "GO:0046324", PanelWidth = 4L),
#   VolcanoPlot(RowSelectionSource = "PathwaysTable1", ColorBy = "Row selection", PanelWidth = 4L),
#   ComplexHeatmapPlot(RowSelectionSource = "PathwaysTable1",
#                      PanelWidth = 4L, PanelHeight = 700L,
#                      CustomRows = FALSE, ColumnData = "dex",
#                      ClusterRows = TRUE, ClusterRowsDistance = "euclidean", AssayCenterRows = TRUE),
#   FgseaEnrichmentPlot(ResultName="fgsea (p-value)", PathwayId = "GO:0046324", PanelWidth = 12L)
# ))


initial <- list(
  PathwaysTable(ResultName="fgsea (p-value)", Selected = "GO:0046324", PanelWidth = 4L),
  VolcanoPlot(RowSelectionSource = "PathwaysTable1", ColorBy = "Row selection", PanelWidth = 4L),
  ComplexHeatmapPlot(RowSelectionSource = "PathwaysTable1",
                     PanelWidth = 4L, PanelHeight = 700L,
                     CustomRows = FALSE, ColumnData = "dex",
                     ClusterRows = TRUE, ClusterRowsDistance = "euclidean", AssayCenterRows = TRUE),
  FgseaEnrichmentPlot(ResultName="fgsea (p-value)", PathwayId = "GO:0046324", PanelWidth = 12L)
)
