#' Summary Functions for table1::table1() for Numeric Data
#'
#' @param x A \code{vector} of values passed from [table1::table1()]
#' @param na_is_category A \code{logical} scalar, indicating whether missing
#' values should be treated as one of the values of the variable (TRUE) or
#' tabulated separately (FALSE).
#'
#' @return Tabulations for [table1::table1()]
#' @export
#'
#' @examples
#'
#' table1(
#'   x = ~ ordered + binary_factor + categorical | two_level_group,
#'   data = jfbr_test,
#'   render.categorical = table1_categorical
#' )


table1_categorical <-
  function(x, na_is_category = FALSE) {
    render.categorical.default(
      x = x,
      na.is.category = na_is_category
    )
  }
