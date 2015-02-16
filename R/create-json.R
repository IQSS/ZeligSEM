#' @include model-semAR.R

library(jsonlite)

z5sem <- zsem$new()
z5sem$toJSON()

zeligsemmodels <- list(zelig5semmodels = list("sem" = z5sem$ljson))

cat(jsonlite::toJSON(zeligsemmodels, pretty = TRUE),
    file = file.path("inst/JSON", "zelig5semmodels.json"))
