initial <- list(
  ReducedDimensionPlot(
    PanelWidth = 3L,
    Type = "TSNE",
    ColorBy = "Feature name",
    ColorByFeatureSource = "RowDataTable1"
  ),
  iSEEid::SampleIdentificationCenter(
    ColumnSelectionSource = "ReducedDimensionPlot1",
    PanelWidth = 3L,
    ColDataColumn = "labels_from_automated_tool",
    CellTypeLabel = "new_cell_type",
    AnnotationRationale = "refined round: looking explicitly for markers"
  ),
  FeatureAssayPlot(
    PanelWidth = 3L,
    XAxis = "Column data",
    XAxisColumnData = "Primary.Type",
    YAxisFeatureSource = "RowDataTable1"
  ),
  RowDataTable(
    PanelWidth = 3L,
    Selected = "CD3D",
    Search = "CD"
  )
)

# iSEE(se = sce_allen, initial = initial)
