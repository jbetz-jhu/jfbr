#' Wrapper for render in [table1::table1]
#'
#' @param numeric A function for computing summaries for numeric variables
#' (e.g. [table1::render.categorical.default])
#' @param categorical A function for computing summaries for categorical
#' variables (e.g. [table1::render.continuous.default])
#' @param ... Other arguments passed onto [table1::render.default]
#'
#' @return The evaluated results
#' @export
#'
#' @examples
#' # To be added

table1_render <-
  function(
    numeric = table1_numeric,
    categorical = table1_categorical,
    ...
  ){
    render.default(
      render.continuous = numeric,
      render.categorical = categorical,
      ...
    )
  }
