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
#' @param completeness A \code{logical} scalar: Compute completeness?
#' @param na.rm \code{logical} scalar: Remove \code{NA} values?
#' @param quantile_type A \code{numeric} scalar, indicating the method of
#' computing quantiles with [stats::quantile()].
#' @param digits  A \code{numeric} scalar, indicating the number of significant
#' figures to include in results.
#'
#' @return A \code{vector} of character-formatted results
#'
#' @export
#'
#' @examples
#' table1_numeric(
#'   x = c(1:100, NA),
#'   quantiles = c(0.05, 0.95)
#' )

table1_numeric <-
  function(
    x,
    mean_sd = TRUE,
    median_iqr = TRUE,
    range = TRUE,
    quantiles = NULL,
    completeness = TRUE,
    na.rm = TRUE,
    quantile_type = 7,
    digits = 2
  ){

    if(!is.numeric(x)){
      stop("x must be numeric.")
    }

    if(!any(mean_sd, median_iqr, range, !is.null(quantiles))){
      stop("At least one summary must be computed. See `?table1_numeric`")
    }

    results <- c("")

    if(mean_sd){
      results <-
        c(results,
          `Mean (SD)` =
            sprintf("%s (%s)",
                    round(x = mean(x, na.rm = na.rm), digits = digits),
                    round(x = sd(x, na.rm = na.rm), digits = digits)
            )
        )
    }

    if(median_iqr){
      med_iqr <-
        round(
          x = quantile(x = x, probs = c(0.5, 0.25, 0.75), type = quantile_type,
                       na.rm = na.rm),
          digits = digits
        )

      results <-
        c(results,
          `Median [IQR]` =
            sprintf("%s (%s)",
                    round(x = quantile(x, prob = 0.5, na.rm = na.rm),
                          digits = digits),
                    round(x = sd(x, na.rm = na.rm), digits = digits)
            )
        )
    }

    if(range){
      results <-
        c(results,
          `[Min, Max]` =
            sprintf("[%s, %s]",
                    round(x = min(x, na.rm = na.rm), digits = digits),
                    round(x = max(x, na.rm = na.rm), digits = digits)
            )
        )
    }

    if(!is.null(quantiles)){

      if(!all(is.finite(quantiles))){
        stop("Quantiles must be numeric values in range [0, 1]. ",
             "See `?quantile`")
      } else {
        if(any(quantiles > 1) | any(quantiles < 0)){
          stop("Quantiles must be numeric values in range [0, 1]. ",
               "See `?quantile`")
        }
      }

      q_result <-
        sapply(
          X =
            quantile(x = x, probs = quantiles, type = quantile_type,
                       na.rm = na.rm) |>
            round(digits = digits),
          FUN = function(x) sprintf("%s", x)
        ) |>
        paste(collapse = ", ")


      q_result <-
        setNames(
          object = q_result,
          nm =
            paste0(
              paste0(round(100*quantiles, digits = 2), "%"),
              collapse = ", "
            )
        )

      results <-
        c(results, q_result)
    }

    if(completeness){
      results <-
        c(results,
          `Complete (N%)` =
            sprintf("%s (%s%%)",
                    sum(!is.na(x)),
                    round(x = (100*mean(!is.na(x))), digits = digits)
            )
        )
    }

    return(results)
  }
