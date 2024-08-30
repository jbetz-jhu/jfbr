#' Summary Functions for table1::table1() for Numeric Data
#'
#' The default functions in table1::table1() compute the Mean (SD) and Median
#' (Min, Max) for continuous values. These summary functions are meant to offer
#' more flexibility in terms of summaries.
#'
#' @param x A \code{vector} of values passed from [table1::table1()]
#' @param mean_sd A \code{logical} scalar: Compute Mean & SD?
#' @param median_iqr A \code{logical} scalar: Compute Median & IQR?
#' @param range A \code{logical} scalar: Compute Range?
#' @param quantiles A \code{vector} of \code{numeric} values: Quantiles to
#' compute
#' @param ... Arguments passed to [jfbr::stats_jfbr()]
#'
#' @return A \code{vector} of character-formatted results
#'
#' @export
#'
#' @examples
#'
#' table1_numeric(
#'   x = c(1:100, NA),
#'   quantiles = c(0.05, 0.95)
#' )
#'
#' data(jfbr_test)
#' library(table1)
#'
#'   table1(
#'     x = ~ continuous + numbers | two_level_group,
#'     data = jfbr_test,
#'     render.continuous = table1_numeric
#'   )

table1_numeric <-
  function (
    x,
    mean_sd = TRUE,
    median_iqr = TRUE,
    range = TRUE,
    quantiles = NULL,
    ...
  ) {
    with(
      data = stats_apply_rounding_jfbr(
        x = stats_jfbr(x, custom_quantiles = quantiles, ...),
        ...
      ),
      expr = {
        c("",
          if(mean_sd) {
            c("Mean (SD)" = sprintf("%s (%s)", MEAN, SD))
          },
          if(median_iqr){
            c("Median [IQR]" = sprintf("%s [%s, %s]", MEDIAN, Q1, Q3))
          },
          if(range){
            c("[Min, Max]" = sprintf("[%s, %s]", MIN, MAX))
          },
          if(!is.null(quantiles)){
            setNames(
              object = paste(CQ, collapse = ", "),
              nm = paste(names(CQ), collapse = ", ")
            )
          }
        )
      }
    )
  }
