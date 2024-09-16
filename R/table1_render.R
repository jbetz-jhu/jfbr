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
#' table1::table1(
#'   x = ~ numbers + continuous + binary + ordered +
#'     binary_factor + categorical | three_level_group,
#'   data = jfbr_test,
#'   render = table1_render
#' )
#'
#' table1::table1(
#'   x = ~ numbers + continuous + binary + ordered +
#'     binary_factor + categorical | three_level_group,
#'   data = jfbr_test,
#'   render =
#'     function(...) table1_render(
#'       numeric = render.continuous.default,
#'       categorical = render.categorical.default,
#'       ...
#'     )
#' )


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
